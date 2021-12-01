module Main where

import Advent.Of.Code
import Data.Text (Text)
import Day1 qualified

main :: IO ()
main = runAdvent 2021 solve

solve :: Int -> Part -> Maybe (Text -> Text)
solve 1 Part1 = Just Day1.part1
solve 1 Part2 = Just Day1.part2
solve _ _ = Nothing
