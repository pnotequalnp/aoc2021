module Main where

import Advent.Of.Code (Day (..), Part (..), runAdvent)
import Data.Text (Text)
import Day1 qualified
import Day2 qualified
import Day3 qualified

main :: IO ()
main = runAdvent 2021 solve

solve :: Day -> Part -> Maybe (Text -> Text)
solve Day1 Part1 = Just Day1.part1
solve Day1 Part2 = Just Day1.part2
solve Day2 Part1 = Just Day2.part1
solve Day2 Part2 = Just Day2.part2
solve Day3 Part1 = Just Day3.part1
solve Day3 Part2 = Just Day3.part2
solve _ _ = Nothing
