module Day1 (part1, part2) where

import Advent.Of.Code.Input qualified as Input
import Control.Comonad
import Data.List.NonEmpty (NonEmpty (..))
import Data.Text (Text)
import TextShow (showt)

part1 :: Text -> Text
part1 = showt . count . Input.nonEmpty @Int

part2 :: Text -> Text
part2 = showt . count3 . Input.nonEmpty @Int

count :: Ord a => NonEmpty a -> Int
count = sum . extend \case
  x :| y : _ | y > x -> 1
  _ -> 0

count3 :: Ord a => NonEmpty a -> Int
count3 = sum . extend \case
  x :| _ : _ : y : _ | y > x -> 1
  _ -> 0
