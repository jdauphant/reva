module Api.Form.Feasibility exposing (..)

import Api.Feasibility
import Api.Token exposing (Token)
import Data.Candidacy exposing (CandidacyId)
import Data.Feasibility exposing (Decision(..), Feasibility)
import Data.Form exposing (FormData)
import Data.Form.Feasibility
import Data.Referential
import Http
import RemoteData exposing (RemoteData(..))
import Task


submit :
    CandidacyId
    -> String
    -> String
    -> Token
    -> (RemoteData (List String) () -> msg)
    -> ( Data.Candidacy.Candidacy, Data.Referential.Referential )
    -> FormData
    -> Cmd msg
submit candidacyId restApiEndpoint _ token toMsg ( _, _ ) formData =
    let
        keys =
            Data.Form.Feasibility.keys

        feasibilityFiles =
            Data.Form.getFiles keys.feasibilityFile formData
                |> List.map (\( _, file ) -> ( keys.feasibilityFile, file ))

        documentaryProofFiles =
            Data.Form.getFiles keys.documentaryProofFile formData
                |> List.map (\( _, file ) -> ( keys.documentaryProofFile, file ))

        certificateOfAttendanceFiles =
            Data.Form.getFiles keys.certificateOfAttendanceFile formData
                |> List.map (\( _, file ) -> ( keys.certificateOfAttendanceFile, file ))

        certificationAuthorityId =
            Data.Form.get keys.certificationAuthorityId formData
                |> Maybe.withDefault ""

        withFiles files body =
            files
                |> List.map (\( name, file ) -> Http.filePart name file)
                |> (++) body

        post files =
            Http.request
                { method = "POST"
                , headers = [ Http.header "authorization" ("Bearer " ++ Api.Token.toString token) ]
                , url = restApiEndpoint ++ "/feasibility/upload-feasibility-file"
                , body =
                    [ Http.stringPart "candidacyId" (Data.Candidacy.candidacyIdToString candidacyId)
                    , Http.stringPart "certificationAuthorityId" certificationAuthorityId
                    ]
                        |> withFiles files
                        |> Http.multipartBody
                , expect = mayExpectError (RemoteData.fromResult >> toMsg)
                , timeout = Nothing
                , tracker = Nothing
                }

        error msg =
            Task.succeed (RemoteData.Failure [ msg ])
                |> Task.perform toMsg
    in
    if certificationAuthorityId == "" then
        error "Veuillez choisir une autorité de certification."

    else
        case ( feasibilityFiles, documentaryProofFiles, certificateOfAttendanceFiles ) of
            ( [], _, _ ) ->
                error "Veuillez choisir un dossier de faisabilité."

            ( [ feasibilityFile ], [ documentaryProofFile ], [ certificateOfAttendanceFile ] ) ->
                post [ feasibilityFile, documentaryProofFile, certificateOfAttendanceFile ]

            ( [ feasibilityFile ], [ documentaryProofFile ], [] ) ->
                post [ feasibilityFile, documentaryProofFile ]

            ( [ feasibilityFile ], [], [ certificateOfAttendanceFile ] ) ->
                post [ feasibilityFile, certificateOfAttendanceFile ]

            ( [ feasibilityFile ], _, _ ) ->
                post [ feasibilityFile ]

            ( _, _, _ ) ->
                error "Vous ne pouvez pas envoyer plus d'un dossier de faisabilité et plus d'une autre pièce jointe."


submitDecision :
    String
    -> Token
    -> (RemoteData (List String) () -> msg)
    -> Feasibility
    -> FormData
    -> Cmd msg
submitDecision endpointGraphql token toMsg feasibility formData =
    let
        decision =
            Data.Form.Feasibility.fromDict formData
    in
    case decision of
        Admissible reason ->
            Api.Feasibility.validate endpointGraphql token toMsg feasibility.id reason

        Rejected reason ->
            Api.Feasibility.reject endpointGraphql token toMsg feasibility.id reason

        Pending ->
            Cmd.none


mayExpectError : (Result (List String) () -> msg) -> Http.Expect msg
mayExpectError toMsg =
    Http.expectStringResponse toMsg <|
        \response ->
            case response of
                Http.BadStatus_ metadata errorBody ->
                    if metadata.statusCode == 413 then
                        Err [ "Le fichier que vous tentez d'envoyer est trop volumineux. Veuillez soumettre un fichier d'une taille inférieure à 10 Mo." ]

                    else
                        Err [ errorBody ]

                Http.GoodStatus_ _ _ ->
                    Ok ()

                _ ->
                    Err [ "Une erreur est survenue" ]
