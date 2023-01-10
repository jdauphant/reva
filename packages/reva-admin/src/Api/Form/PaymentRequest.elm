module Api.Form.PaymentRequest exposing (create, get)

import Admin.InputObject
import Admin.Mutation as Mutation
import Admin.Object
import Admin.Object.Candidacy
import Admin.Object.FundingRequestInformations
import Admin.Object.PaymentRequest
import Admin.Query as Query
import Admin.Scalar exposing (Id(..), Timestamp(..), Uuid(..))
import Api.Auth as Auth
import Api.Form.FundingRequest
import Api.Token exposing (Token)
import Data.Candidacy exposing (Candidacy, CandidacyId)
import Data.Form.PaymentRequest
import Data.Referential
import Dict exposing (Dict)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet, with)
import RemoteData exposing (RemoteData(..))


create :
    CandidacyId
    -> String
    -> Token
    -> (RemoteData String () -> msg)
    -> ( Data.Candidacy.Candidacy, Data.Referential.Referential )
    -> Dict String String
    -> Cmd msg
create candidacyId endpointGraphql token toMsg ( candidacy, referential ) dict =
    let
        payment =
            Data.Form.PaymentRequest.fromDict dict

        paymentInput =
            Admin.InputObject.PaymentRequestInput
                payment.diagnosisHourCount
                payment.postExamHourCount
                payment.individualHourCount
                payment.collectiveHourCount
                payment.mandatoryTrainingsHourCount
                payment.basicSkillsHourCount
                payment.certificateSkillsHourCount
                payment.examHourCount

        paymentRequiredArg =
            Mutation.CandidacyCreateOrUpdatePaymentRequestRequiredArguments
                (Uuid <| Data.Candidacy.candidacyIdToString candidacyId)
                paymentInput
    in
    Mutation.candidacy_createOrUpdatePaymentRequest paymentRequiredArg SelectionSet.empty
        |> Auth.makeMutation endpointGraphql token toMsg


get :
    CandidacyId
    -> String
    -> Token
    -> (RemoteData String (Dict String String) -> msg)
    -> Cmd msg
get candidacyId endpointGraphql token toMsg =
    let
        fundingInfoRequiredArg =
            Query.CandidateGetFundingRequestRequiredArguments (Uuid <| Data.Candidacy.candidacyIdToString candidacyId)

        paymentInfoRequiredArg =
            Query.GetCandidacyByIdRequiredArguments (Id <| Data.Candidacy.candidacyIdToString candidacyId)

        fundingRequestSelection =
            Admin.Object.FundingRequestInformations.fundingRequest Api.Form.FundingRequest.selection

        paymentRequestSelection =
            Admin.Object.Candidacy.paymentRequest selection
    in
    SelectionSet.succeed Data.Form.PaymentRequest.maybePaymentRequest
        |> with (Query.candidate_getFundingRequest fundingInfoRequiredArg fundingRequestSelection)
        |> with (Query.getCandidacyById paymentInfoRequiredArg paymentRequestSelection)
        |> Auth.makeQuery endpointGraphql token toMsg


selection : SelectionSet Data.Form.PaymentRequest.PaymentRequestInput Admin.Object.PaymentRequest
selection =
    SelectionSet.succeed Data.Form.PaymentRequest.PaymentRequestInput
        |> with Admin.Object.PaymentRequest.diagnosisEffectiveHourCount
        |> with Admin.Object.PaymentRequest.postExamEffectiveHourCount
        |> with Admin.Object.PaymentRequest.individualEffectiveHourCount
        |> with Admin.Object.PaymentRequest.collectiveEffectiveHourCount
        |> with Admin.Object.PaymentRequest.basicSkillsEffectiveHourCount
        |> with Admin.Object.PaymentRequest.mandatoryTrainingsEffectiveHourCount
        |> with Admin.Object.PaymentRequest.certificateSkillsEffectiveHourCount
        |> with Admin.Object.PaymentRequest.examEffectiveHourCount
