module MainTest where

import TestDependencyA
import TestDependencyB exposing (..)

--import InvalidDependency exposing (..)

import Html exposing (..)

main =
  div [] [text "Hello World!"]