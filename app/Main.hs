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

data Error

data Result = Ok | Err [Error]

newtype All = All {getAll :: Result}

newtype Any = Any {getAny :: Result}

instance Semigroup All where
  All Ok <> All Ok = All Ok
  All e <> All Ok = All e
  All Ok <> All e = All e
  All (Err e) <> All (Err e') = All (Err (e <> e'))

instance Monoid All where
  mempty = All Ok

instance Semigroup Any where
  Any Ok <> Any Ok = Any Ok
  Any _ <> Any Ok = Any Ok
  Any Ok <> Any _ = Any Ok
  Any (Err e) <> Any (Err e') = Any (Err (e <> e'))

instance Monoid Any where
  mempty = Any (Err [])

type Rule a b = a -> b -> Result

ruleLocal :: Rule b c -> (a -> b) -> Rule a c
ruleLocal = (.)

ruleMap :: (a' -> b) -> Rule a b -> Rule a' a
ruleMap f r x y = r y (f x)

infixr 7 .:
(.:) :: (c -> d) -> (a -> b -> c) -> a -> b -> d
(.:) = (.) . (.)

infixr 6 ..:
(..:) :: (d -> e) -> (a -> b -> c -> d) -> a -> b -> c -> e
(..:) = (.) . (.) . (.)

(>&&>) :: Rule a b -> Rule a b -> Rule a b
f >&&> g = getAll .: (All .: f <> All .: g)

(>||>) :: Rule a b -> Rule a b -> Rule a b
f >||> g = getAny .: (Any .: f <> Any .: g)

foo :: Rule a b
foo = getAll .: mempty -- foo = Ok

bar :: Rule a b
bar = getAny .: mempty -- foo = Err

all' :: Foldable t => t (Rule a b) -> Rule a b
all' = getAll ..: foldMap (All .:)
