module Api.Form.Archive exposing (..)

import Admin.Mutation as Mutation
import Admin.Object
import Admin.Object.Candidacy
import Admin.Object.ReorientationReason
import Admin.Query as Query
import Admin.Scalar exposing (Id(..), Uuid(..))
import Api.Auth as Auth
import Api.Candidacy exposing (statusSelection)
import Api.RemoteData exposing (nothingToError)
import Api.Token exposing (Token)
import Data.Candidacy exposing (CandidacyId)
import Data.Form exposing (FormData)
import Data.Form.Archive
import Data.Referential
import Dict exposing (Dict)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import RemoteData exposing (RemoteData)


get :
    CandidacyId
    -> String
    -> Token
    -> (RemoteData (List String) (Dict String String) -> msg)
    -> Cmd msg
get candidacyId endpointGraphql token toMsg =
    let
        candidacyRequiredArgs =
            Query.GetCandidacyByIdRequiredArguments (Id <| Data.Candidacy.candidacyIdToString candidacyId)
    in
    Query.getCandidacyById candidacyRequiredArgs selection
        |> Auth.makeQuery "getCandidacyArchiveDetails" endpointGraphql token (nothingToError "Cette candidature est introuvable" >> toMsg)


archive :
    CandidacyId
    -> String
    -> Token
    -> (RemoteData (List String) () -> msg)
    -> ( Data.Candidacy.Candidacy, Data.Referential.Referential )
    -> FormData
    -> Cmd msg
archive candidacyId endpointGraphql token toMsg _ formData =
    let
        archiveData =
            Data.Form.Archive.fromDict formData

        id =
            Data.Candidacy.candidacyIdToString candidacyId
    in
    Mutation.candidacy_archiveById
        (\optionals ->
            { optionals
                | reorientationReasonId =
                    if archiveData.reorientationReasonId == "" then
                        Absent

                    else
                        Present (Uuid archiveData.reorientationReasonId)
            }
        )
        (Mutation.CandidacyArchiveByIdRequiredArguments (Id id))
        (SelectionSet.succeed ())
        |> Auth.makeMutation "archiveCandidacy" endpointGraphql token toMsg


selection : SelectionSet (Dict String String) Admin.Object.Candidacy
selection =
    let
        reorientationReasonId =
            SelectionSet.succeed identity
                |> with Admin.Object.ReorientationReason.id
    in
    SelectionSet.succeed Data.Form.Archive.archive
        |> with (Admin.Object.Candidacy.reorientationReason reorientationReasonId)
        |> with (Admin.Object.Candidacy.candidacyStatuses statusSelection)
