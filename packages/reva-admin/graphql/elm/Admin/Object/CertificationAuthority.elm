-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Admin.Object.CertificationAuthority exposing (..)

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


id : SelectionSet Data.Scalar.Id Admin.Object.CertificationAuthority
id =
    Object.selectionForField "Data.Scalar.Id" "id" [] (Data.Scalar.codecs |> Admin.Scalar.unwrapCodecs |> .codecId |> .decoder)


label : SelectionSet String Admin.Object.CertificationAuthority
label =
    Object.selectionForField "String" "label" [] Decode.string


contactFullName : SelectionSet (Maybe String) Admin.Object.CertificationAuthority
contactFullName =
    Object.selectionForField "(Maybe String)" "contactFullName" [] (Decode.string |> Decode.nullable)


contactEmail : SelectionSet (Maybe String) Admin.Object.CertificationAuthority
contactEmail =
    Object.selectionForField "(Maybe String)" "contactEmail" [] (Decode.string |> Decode.nullable)
