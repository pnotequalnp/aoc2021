module Day2 (part1, part2) where

import Advent.Of.Code.Input (readt, wordsList)
import Data.List (foldl')
import Data.Text (Text)
import TextShow (showt)

data Coord = Coord Int Int Int

(<+>) :: Coord -> Coord -> Coord
Coord x1 y1 z1 <+> Coord x2 y2 z2 = Coord (x1 + x2) (y1 + z1 * y2) (z1 + z2)

zeroCoord :: Coord
zeroCoord = Coord 0 0 0

part1 :: Text -> Text
part1 = solution \(Coord x _ z) -> x * z

part2 :: Text -> Text
part2 = solution \(Coord x y _) -> x * y

solution :: (Coord -> Int) -> Text -> Text
solution f = showt . f . foldl' (<+>) zeroCoord . wordsList parseCommand

parseCommand :: [Text] -> Coord
parseCommand = \case
  [direction, readt -> x]
    | direction == "forward" -> Coord x x 0
    | direction == "up" -> Coord 0 0 (negate x)
    | direction == "down" -> Coord 0 0 x
  _ -> error "Invalid input command"
