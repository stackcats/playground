module Main exposing (main)

import Html exposing (text)


greeting : String
greeting =
    "Hello, Static Elm!"


meaningOfLife : Int
meaningOfLife =
    42


pi : Float
pi =
    3.14


canChunk : Bool
canChunk =
    True


sayHello : String -> String
sayHello name =
    "Hello, " ++ name ++ "."


bottlesOf : String -> Int -> String
bottlesOf contents amount =
    Debug.toString amount ++ " bottles of " ++ contents ++ " on the wall."


main =
    text (bottlesOf "Hello" 100)
