module Day3 (part1, part2) where

import Advent.Of.Code.Input (customList)
import Data.Bool (bool)
import Data.Char (digitToInt)
import Data.List (foldl', transpose)
import Data.Text (Text)
import Data.Text qualified as T
import TextShow (showt)

part1 :: Text -> Text
part1 = showt . ((*) <$> gamma <*> epsilon) . rates . customList T.unpack

part2 :: Text -> Text
part2 = showt . ((*) <$> oxygen <*> co2) . customList T.unpack

rates :: [String] -> [Bool]
rates = fmap criteria . transpose

gamma :: [Bool] -> Word
gamma = parseBinary . fmap (bool '0' '1')

epsilon :: [Bool] -> Word
epsilon = parseBinary . fmap (bool '1' '0')

criteria :: String -> Bool
criteria = (>= 0) . sum . fmap toInt

oxygen :: [String] -> Word
oxygen = rating True

co2 :: [String] -> Word
co2 = rating False

rating :: Bool -> [String] -> Word
rating b = go 0
  where
    go :: Int -> [String] -> Word
    go _ [x] = parseBinary x
    go n xs = go (n + 1) (filter p xs)
      where
        c = transpose xs !! n
        x = (bool '0' '1' . bool not id b . criteria) c
        p = (== x) . (!! n)

parseBinary :: String -> Word
parseBinary = foldl' (\z x -> z * 2 + fromIntegral (digitToInt x)) 0

toInt :: Char -> Int
toInt = \case
  '0' -> -1
  '1' -> 1
  _ -> error "Invalid input (non-binary character)"
