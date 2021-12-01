{
  inputs = {
    advent-of-code.url = "github:pnotequalnp/advent-of-code";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, advent-of-code }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hs = pkgs.haskellPackages;
        aoc = advent-of-code.defaultPackage.${system};
      in rec {
        packages.aoc2021 = hs.callCabal2nix "aoc2021" ./. { advent-of-code = aoc; };
        defaultPackage = packages.aoc2021;

        apps.aoc2021 = flake-utils.lib.mkApp { drv = packages.aoc2021; };
        defaultApp = apps.aoc2021;

        devShell = packages.aoc2021.env.overrideAttrs
          (super: { buildInputs = super.buildInputs ++ [ hs.cabal-install ]; });
      });
}
