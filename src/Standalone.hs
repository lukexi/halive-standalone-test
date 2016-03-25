module Standalone where

--import Data.HashMap.Strict

data MyThing = MyThing 
    { thing1 :: String
    , thing2 :: String
    --, thing3 :: HashMap String String
    } deriving Show
