module Test.MySolutions where

import Data.Array
import Prelude

import Control.Alternative (guard)
import Data.Maybe (Maybe, fromMaybe)
import Data.Path (Path, filename, isDirectory, ls, size)
import Test.Examples (allFiles, factors)

-- Note to reader: Add your solutions to this file
isEven :: Int -> Boolean
isEven 0 = true
isEven 1 = false
isEven 2 = true
isEven n = if n < 0
           then isEven $ -1 * n
           else not isEven $ n - 1


countEven :: Array Int -> Int
countEven [] = 0
countEven arr = if isEven $ fromMaybe 0 $ head arr
                   then 1 + countEven rest
                   else countEven rest
                 where
                   rest = fromMaybe [] $ tail arr

squared :: Array Number -> Array Number
squared = map (\x -> x * x)

keepNonNegative :: Array Number -> Array Number
keepNonNegative = filter (_ >= 0.0)

infix 8 filter as <$?>

keepNonNegativeRewrite :: Array Number -> Array Number
keepNonNegativeRewrite arr = (_ >= 0.0) <$?> arr

isPrime :: Int -> Boolean
isPrime n = n > 1 && (length $ factors n) == 1

cartesianProduct :: forall a. Array a -> Array a -> Array (Array a)
cartesianProduct arr brr = do
  a <- arr
  b <- brr
  [[a, b]]

triples :: Int -> Array (Array Int)
triples n = do
  a <- 1 .. n
  b <- a .. n
  c <- b .. n
  guard $ a * a + b * b == c * c
  pure [a, b, c]

primeFactors :: Int -> Array Int
primeFactors n = aux 2 n
  where
    aux :: Int -> Int -> Array Int
    aux _ 1 = []
    aux a b = if b `mod` a == 0 then
                 cons a $ aux a (b / a)
               else
                 aux (a + 1) b

allTrue :: Array Boolean -> Boolean
allTrue = foldl (&&) true

fibTailRec :: Int -> Int
fibTailRec 0 = 0
fibTailRec 1 = 1
fibTailRec n = aux 2 1 0
  where
    aux :: Int -> Int -> Int -> Int
    aux ct a b = if ct == n then
                    a + b
                  else
                    aux (ct + 1) (a + b) a

reverse :: Array Int -> Array Int
reverse = foldl (\acc x -> cons x acc) []

onlyFiles :: Path -> Array Path
onlyFiles path = filter (not isDirectory) (allFiles path)

whereIs :: Path -> String -> Maybe Path
whereIs path name = head $ do
  p <- allFiles path
  child <- ls p
  guard $ filename child == filename p <> name
  pure p
                   
largestSmallest :: Path -> Array Path
largestSmallest path = foldl aux [] (onlyFiles path) where
  aux :: Array Path -> Path -> Array Path
  aux [last] current | size current > size last = [current, last]
                     | otherwise = [last, current]
  aux [largest, smallest] current | size current < size smallest = [largest, current]
                                  | size current > size largest = [current, smallest]
                                  | otherwise = [largest, smallest]
  aux arr current = current : arr
