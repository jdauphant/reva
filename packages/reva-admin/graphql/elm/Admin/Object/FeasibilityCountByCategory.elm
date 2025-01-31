-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Admin.Object.FeasibilityCountByCategory exposing (..)

import Admin.InputObject
import Admin.Interface
import Admin.Object
import Admin.Scalar
import Admin.Union
import Data.Scalar
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


all : SelectionSet Int Admin.Object.FeasibilityCountByCategory
all =
    Object.selectionForField "Int" "ALL" [] Decode.int


pending : SelectionSet Int Admin.Object.FeasibilityCountByCategory
pending =
    Object.selectionForField "Int" "PENDING" [] Decode.int


rejected : SelectionSet Int Admin.Object.FeasibilityCountByCategory
rejected =
    Object.selectionForField "Int" "REJECTED" [] Decode.int


admissible : SelectionSet Int Admin.Object.FeasibilityCountByCategory
admissible =
    Object.selectionForField "Int" "ADMISSIBLE" [] Decode.int
