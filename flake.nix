{
  inputs = {
    nixpkgs.url = "nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    advent-of-code.url = "github:pnotequalnp/advent-of-code";
  };

  outputs = { self, nixpkgs, flake-utils, advent-of-code }:
    let
      overlay = final: prev: {
        haskell = prev.haskell // {
          packageOverrides = hsFinal: hsPrev: prev.haskell.packageOverrides hsFinal hsPrev // {
            aoc2021 = hsFinal.callCabal2nix "aoc2021" ./. { };
          };
        };
      };
    in
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ]
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              advent-of-code.overlays.default
              overlay
            ];
          };
          hs = pkgs.haskellPackages;
        in
        rec {
          packages = rec {
            aoc2021 = hs.aoc2021;
            default = aoc2021;
          };

          apps = rec {
            aoc2021 = flake-utils.lib.mkApp { drv = packages.aoc2021; };
            default = aoc2021;
          };

          devShells.default = hs.shellFor {
            packages = hsPkgs: with hsPkgs; [ aoc2021 ];
            nativeBuildInputs = with hs; [
              cabal-install
              fourmolu
              haskell-language-server
              hlint
            ];
          };
        }) // {
      overlays.default = overlay;
    };
}
