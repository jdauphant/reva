-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Admin.Object.Feasibility exposing (..)

import Admin.Enum.FeasibilityDecision
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


id : SelectionSet Data.Scalar.Id Admin.Object.Feasibility
id =
    Object.selectionForField "Data.Scalar.Id" "id" [] (Data.Scalar.codecs |> Admin.Scalar.unwrapCodecs |> .codecId |> .decoder)


feasibilityFileSentAt : SelectionSet Data.Scalar.Timestamp Admin.Object.Feasibility
feasibilityFileSentAt =
    Object.selectionForField "Data.Scalar.Timestamp" "feasibilityFileSentAt" [] (Data.Scalar.codecs |> Admin.Scalar.unwrapCodecs |> .codecTimestamp |> .decoder)


feasibilityFile :
    SelectionSet decodesTo Admin.Object.File
    -> SelectionSet decodesTo Admin.Object.Feasibility
feasibilityFile object____ =
    Object.selectionForCompositeField "feasibilityFile" [] object____ Basics.identity


documentaryProofFile :
    SelectionSet decodesTo Admin.Object.File
    -> SelectionSet (Maybe decodesTo) Admin.Object.Feasibility
documentaryProofFile object____ =
    Object.selectionForCompositeField "documentaryProofFile" [] object____ (Basics.identity >> Decode.nullable)


certificateOfAttendanceFile :
    SelectionSet decodesTo Admin.Object.File
    -> SelectionSet (Maybe decodesTo) Admin.Object.Feasibility
certificateOfAttendanceFile object____ =
    Object.selectionForCompositeField "certificateOfAttendanceFile" [] object____ (Basics.identity >> Decode.nullable)


candidacy :
    SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet decodesTo Admin.Object.Feasibility
candidacy object____ =
    Object.selectionForCompositeField "candidacy" [] object____ Basics.identity


decision : SelectionSet Admin.Enum.FeasibilityDecision.FeasibilityDecision Admin.Object.Feasibility
decision =
    Object.selectionForField "Enum.FeasibilityDecision.FeasibilityDecision" "decision" [] Admin.Enum.FeasibilityDecision.decoder


decisionComment : SelectionSet (Maybe String) Admin.Object.Feasibility
decisionComment =
    Object.selectionForField "(Maybe String)" "decisionComment" [] (Decode.string |> Decode.nullable)


decisionSentAt : SelectionSet (Maybe Data.Scalar.Timestamp) Admin.Object.Feasibility
decisionSentAt =
    Object.selectionForField "(Maybe Data.Scalar.Timestamp)" "decisionSentAt" [] (Data.Scalar.codecs |> Admin.Scalar.unwrapCodecs |> .codecTimestamp |> .decoder |> Decode.nullable)
