module Test.MySolutions where

import Prelude

import ChapterExamples (Amp(..), Person, Volt(..))
import Data.Maybe (Maybe(..))
import Data.Picture (Picture, Shape(..), Bounds, origin)
import Math (abs, pi)


factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

binomial :: Int -> Int -> Int
binomial _ 0 = 1
binomial 0 _ = 0
binomial n k | n < k = 0
  | otherwise = factorial n / (factorial k * factorial (n - k))

pascal :: Int -> Int -> Int
pascal _ 0 = 1
pascal 0 _ = 0
pascal n k = pascal (n - 1) k + pascal (n - 1) (k - 1)

sameCity :: Person -> Person -> Boolean
sameCity { address: { city: c1 } } { address: { city: c2 } }
  | c1 == c2 = true
  | otherwise = false

fromSingleton :: forall a. a -> Array a -> a
fromSingleton _ [x] = x
fromSingleton d _ = d

circleAtOrigin :: Shape
circleAtOrigin = Circle { x: 0.0, y: 0.0 } 10.0

doubleScaleAndCenter :: Shape -> Shape
doubleScaleAndCenter (Circle _ radius) = Circle origin (radius * 2.0)
doubleScaleAndCenter (Rectangle _ w h) = Rectangle origin (w * 2.0) (h * 2.0)
doubleScaleAndCenter (Line { x: x1, y: y1 } { x : x2, y: y2 }) = Line { x: -x, y: -y } { x, y }
   where
     x = abs (x2 - x1)
     y = abs (y2 - y1)
doubleScaleAndCenter (Text _ text) = Text origin text

shapeText :: Shape -> Maybe String
shapeText (Text _ text) = Just text
shapeText _ = Nothing

newtype Watt = Watt Number

calculateWattage :: Amp -> Volt -> Watt
calculateWattage (Amp a) (Volt v) = Watt (a * v)

area :: Shape -> Number
area (Circle _ r) = pi * r * r
area (Rectangle _ w h) = w * h
area _ = 0.0
