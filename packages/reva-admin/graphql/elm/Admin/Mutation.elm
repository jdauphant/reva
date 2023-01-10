-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Admin.Mutation exposing (..)

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
import Json.Decode as Decode exposing (Decoder)


type alias AccountCreateAccountOptionalArguments =
    { account : OptionalArgument Admin.InputObject.AccountInput }


account_createAccount :
    (AccountCreateAccountOptionalArguments -> AccountCreateAccountOptionalArguments)
    -> SelectionSet decodesTo Admin.Object.Account
    -> SelectionSet decodesTo RootMutation
account_createAccount fillInOptionals____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { account = Absent }

        optionalArgs____ =
            [ Argument.optional "account" filledInOptionals____.account Admin.InputObject.encodeAccountInput ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "account_createAccount" optionalArgs____ object____ Basics.identity


type alias CandidacyCreateCandidacyRequiredArguments =
    { candidacy : Admin.InputObject.CandidacyInput }


candidacy_createCandidacy :
    CandidacyCreateCandidacyRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet (Maybe decodesTo) RootMutation
candidacy_createCandidacy requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_createCandidacy" [ Argument.required "candidacy" requiredArgs____.candidacy Admin.InputObject.encodeCandidacyInput ] object____ (Basics.identity >> Decode.nullable)


type alias CandidacySubmitCandidacyRequiredArguments =
    { deviceId : Data.Scalar.Id
    , candidacyId : Data.Scalar.Id
    }


candidacy_submitCandidacy :
    CandidacySubmitCandidacyRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet (Maybe decodesTo) RootMutation
candidacy_submitCandidacy requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_submitCandidacy" [ Argument.required "deviceId" requiredArgs____.deviceId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId) ] object____ (Basics.identity >> Decode.nullable)


type alias CandidacyUpdateCertificationRequiredArguments =
    { deviceId : Data.Scalar.Id
    , candidacyId : Data.Scalar.Id
    , certificationId : Data.Scalar.Id
    , departmentId : Data.Scalar.Id
    }


candidacy_updateCertification :
    CandidacyUpdateCertificationRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet (Maybe decodesTo) RootMutation
candidacy_updateCertification requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_updateCertification" [ Argument.required "deviceId" requiredArgs____.deviceId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "certificationId" requiredArgs____.certificationId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "departmentId" requiredArgs____.departmentId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId) ] object____ (Basics.identity >> Decode.nullable)


type alias CandidacyAddExperienceOptionalArguments =
    { experience : OptionalArgument Admin.InputObject.ExperienceInput }


type alias CandidacyAddExperienceRequiredArguments =
    { deviceId : Data.Scalar.Id
    , candidacyId : Data.Scalar.Id
    }


candidacy_addExperience :
    (CandidacyAddExperienceOptionalArguments -> CandidacyAddExperienceOptionalArguments)
    -> CandidacyAddExperienceRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Experience
    -> SelectionSet (Maybe decodesTo) RootMutation
candidacy_addExperience fillInOptionals____ requiredArgs____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { experience = Absent }

        optionalArgs____ =
            [ Argument.optional "experience" filledInOptionals____.experience Admin.InputObject.encodeExperienceInput ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "candidacy_addExperience" (optionalArgs____ ++ [ Argument.required "deviceId" requiredArgs____.deviceId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId) ]) object____ (Basics.identity >> Decode.nullable)


type alias CandidacyUpdateExperienceOptionalArguments =
    { experience : OptionalArgument Admin.InputObject.ExperienceInput }


type alias CandidacyUpdateExperienceRequiredArguments =
    { deviceId : Data.Scalar.Id
    , candidacyId : Data.Scalar.Id
    , experienceId : Data.Scalar.Id
    }


candidacy_updateExperience :
    (CandidacyUpdateExperienceOptionalArguments -> CandidacyUpdateExperienceOptionalArguments)
    -> CandidacyUpdateExperienceRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Experience
    -> SelectionSet (Maybe decodesTo) RootMutation
candidacy_updateExperience fillInOptionals____ requiredArgs____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { experience = Absent }

        optionalArgs____ =
            [ Argument.optional "experience" filledInOptionals____.experience Admin.InputObject.encodeExperienceInput ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "candidacy_updateExperience" (optionalArgs____ ++ [ Argument.required "deviceId" requiredArgs____.deviceId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "experienceId" requiredArgs____.experienceId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId) ]) object____ (Basics.identity >> Decode.nullable)


type alias CandidacyRemoveExperienceRequiredArguments =
    { deviceId : Data.Scalar.Id
    , candidacyId : Data.Scalar.Id
    , experienceId : Data.Scalar.Id
    }


candidacy_removeExperience :
    CandidacyRemoveExperienceRequiredArguments
    -> SelectionSet (Maybe Data.Scalar.Void) RootMutation
candidacy_removeExperience requiredArgs____ =
    Object.selectionForField "(Maybe Data.Scalar.Void)" "candidacy_removeExperience" [ Argument.required "deviceId" requiredArgs____.deviceId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "experienceId" requiredArgs____.experienceId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId) ] (Data.Scalar.codecs |> Admin.Scalar.unwrapCodecs |> .codecVoid |> .decoder |> Decode.nullable)


type alias CandidacyUpdateGoalsRequiredArguments =
    { deviceId : Data.Scalar.Id
    , candidacyId : Data.Scalar.Id
    , goals : List Admin.InputObject.CandidateGoalInput
    }


candidacy_updateGoals :
    CandidacyUpdateGoalsRequiredArguments
    -> SelectionSet Int RootMutation
candidacy_updateGoals requiredArgs____ =
    Object.selectionForField "Int" "candidacy_updateGoals" [ Argument.required "deviceId" requiredArgs____.deviceId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "goals" requiredArgs____.goals (Admin.InputObject.encodeCandidateGoalInput |> Encode.list) ] Decode.int


type alias CandidacyUpdateContactOptionalArguments =
    { email : OptionalArgument String
    , phone : OptionalArgument String
    }


type alias CandidacyUpdateContactRequiredArguments =
    { deviceId : Data.Scalar.Id
    , candidacyId : Data.Scalar.Id
    }


candidacy_updateContact :
    (CandidacyUpdateContactOptionalArguments -> CandidacyUpdateContactOptionalArguments)
    -> CandidacyUpdateContactRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet (Maybe decodesTo) RootMutation
candidacy_updateContact fillInOptionals____ requiredArgs____ object____ =
    let
        filledInOptionals____ =
            fillInOptionals____ { email = Absent, phone = Absent }

        optionalArgs____ =
            [ Argument.optional "email" filledInOptionals____.email Encode.string, Argument.optional "phone" filledInOptionals____.phone Encode.string ]
                |> List.filterMap Basics.identity
    in
    Object.selectionForCompositeField "candidacy_updateContact" (optionalArgs____ ++ [ Argument.required "deviceId" requiredArgs____.deviceId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId) ]) object____ (Basics.identity >> Decode.nullable)


type alias CandidacyArchiveByIdRequiredArguments =
    { candidacyId : Data.Scalar.Id }


candidacy_archiveById :
    CandidacyArchiveByIdRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet decodesTo RootMutation
candidacy_archiveById requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_archiveById" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId) ] object____ Basics.identity


type alias CandidacyDeleteByIdRequiredArguments =
    { candidacyId : Data.Scalar.Id }


candidacy_deleteById :
    CandidacyDeleteByIdRequiredArguments
    -> SelectionSet String RootMutation
candidacy_deleteById requiredArgs____ =
    Object.selectionForField "String" "candidacy_deleteById" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId) ] Decode.string


type alias CandidacyUpdateAppointmentInformationsRequiredArguments =
    { candidacyId : Data.Scalar.Id
    , candidateTypologyInformations : Admin.InputObject.CandidateTypologyInformationsInput
    , appointmentInformations : Admin.InputObject.AppointmentInformationsInput
    }


candidacy_updateAppointmentInformations :
    CandidacyUpdateAppointmentInformationsRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet decodesTo RootMutation
candidacy_updateAppointmentInformations requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_updateAppointmentInformations" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId), Argument.required "candidateTypologyInformations" requiredArgs____.candidateTypologyInformations Admin.InputObject.encodeCandidateTypologyInformationsInput, Argument.required "appointmentInformations" requiredArgs____.appointmentInformations Admin.InputObject.encodeAppointmentInformationsInput ] object____ Basics.identity


type alias CandidacyTakeOverRequiredArguments =
    { candidacyId : Data.Scalar.Id }


candidacy_takeOver :
    CandidacyTakeOverRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet decodesTo RootMutation
candidacy_takeOver requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_takeOver" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecId) ] object____ Basics.identity


type alias CandidacySelectOrganismRequiredArguments =
    { candidacyId : Data.Scalar.Uuid
    , organismId : Data.Scalar.Uuid
    }


candidacy_selectOrganism :
    CandidacySelectOrganismRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet decodesTo RootMutation
candidacy_selectOrganism requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_selectOrganism" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecUuid), Argument.required "organismId" requiredArgs____.organismId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecUuid) ] object____ Basics.identity


type alias CandidacySubmitTrainingFormRequiredArguments =
    { candidacyId : Data.Scalar.Uuid
    , training : Admin.InputObject.TrainingInput
    }


candidacy_submitTrainingForm :
    CandidacySubmitTrainingFormRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet decodesTo RootMutation
candidacy_submitTrainingForm requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_submitTrainingForm" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecUuid), Argument.required "training" requiredArgs____.training Admin.InputObject.encodeTrainingInput ] object____ Basics.identity


type alias CandidacyConfirmTrainingFormRequiredArguments =
    { candidacyId : Data.Scalar.Uuid }


candidacy_confirmTrainingForm :
    CandidacyConfirmTrainingFormRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet decodesTo RootMutation
candidacy_confirmTrainingForm requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_confirmTrainingForm" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecUuid) ] object____ Basics.identity


type alias CandidacyDropOutRequiredArguments =
    { candidacyId : Data.Scalar.Uuid
    , dropOut : Admin.InputObject.DropOutInput
    }


candidacy_dropOut :
    CandidacyDropOutRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet decodesTo RootMutation
candidacy_dropOut requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_dropOut" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecUuid), Argument.required "dropOut" requiredArgs____.dropOut Admin.InputObject.encodeDropOutInput ] object____ Basics.identity


type alias CandidacyUpdateAdmissibilityRequiredArguments =
    { candidacyId : Data.Scalar.Uuid
    , admissibility : Admin.InputObject.AdmissibilityInput
    }


candidacy_updateAdmissibility :
    CandidacyUpdateAdmissibilityRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Admissibility
    -> SelectionSet decodesTo RootMutation
candidacy_updateAdmissibility requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_updateAdmissibility" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecUuid), Argument.required "admissibility" requiredArgs____.admissibility Admin.InputObject.encodeAdmissibilityInput ] object____ Basics.identity


type alias CandidacyCreateOrUpdatePaymentRequestRequiredArguments =
    { candidacyId : Data.Scalar.Uuid
    , paymentRequest : Admin.InputObject.PaymentRequestInput
    }


candidacy_createOrUpdatePaymentRequest :
    CandidacyCreateOrUpdatePaymentRequestRequiredArguments
    -> SelectionSet decodesTo Admin.Object.PaymentRequest
    -> SelectionSet decodesTo RootMutation
candidacy_createOrUpdatePaymentRequest requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_createOrUpdatePaymentRequest" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecUuid), Argument.required "paymentRequest" requiredArgs____.paymentRequest Admin.InputObject.encodePaymentRequestInput ] object____ Basics.identity


type alias CandidacyConfirmPaymentRequestRequiredArguments =
    { candidacyId : Data.Scalar.Uuid }


candidacy_confirmPaymentRequest :
    CandidacyConfirmPaymentRequestRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidacy
    -> SelectionSet decodesTo RootMutation
candidacy_confirmPaymentRequest requiredArgs____ object____ =
    Object.selectionForCompositeField "candidacy_confirmPaymentRequest" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecUuid) ] object____ Basics.identity


type alias CandidateAskForRegistrationRequiredArguments =
    { candidate : Admin.InputObject.CandidateInput }


candidate_askForRegistration :
    CandidateAskForRegistrationRequiredArguments
    -> SelectionSet String RootMutation
candidate_askForRegistration requiredArgs____ =
    Object.selectionForField "String" "candidate_askForRegistration" [ Argument.required "candidate" requiredArgs____.candidate Admin.InputObject.encodeCandidateInput ] Decode.string


type alias CandidateAskForLoginRequiredArguments =
    { email : String }


candidate_askForLogin :
    CandidateAskForLoginRequiredArguments
    -> SelectionSet String RootMutation
candidate_askForLogin requiredArgs____ =
    Object.selectionForField "String" "candidate_askForLogin" [ Argument.required "email" requiredArgs____.email Encode.string ] Decode.string


type alias CandidateLoginRequiredArguments =
    { token : String }


candidate_login :
    CandidateLoginRequiredArguments
    -> SelectionSet decodesTo Admin.Object.CandidateLogged
    -> SelectionSet decodesTo RootMutation
candidate_login requiredArgs____ object____ =
    Object.selectionForCompositeField "candidate_login" [ Argument.required "token" requiredArgs____.token Encode.string ] object____ Basics.identity


type alias CandidateCreateFundingRequestRequiredArguments =
    { candidacyId : Data.Scalar.Uuid
    , fundingRequest : Admin.InputObject.FundingRequestInput
    }


candidate_createFundingRequest :
    CandidateCreateFundingRequestRequiredArguments
    -> SelectionSet decodesTo Admin.Object.FundingRequest
    -> SelectionSet decodesTo RootMutation
candidate_createFundingRequest requiredArgs____ object____ =
    Object.selectionForCompositeField "candidate_createFundingRequest" [ Argument.required "candidacyId" requiredArgs____.candidacyId (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecUuid), Argument.required "fundingRequest" requiredArgs____.fundingRequest Admin.InputObject.encodeFundingRequestInput ] object____ Basics.identity


type alias CandidateUpdateCandidateRequiredArguments =
    { id : Data.Scalar.Uuid
    , candidate : Admin.InputObject.FullCandidateInput
    }


candidate_updateCandidate :
    CandidateUpdateCandidateRequiredArguments
    -> SelectionSet decodesTo Admin.Object.Candidate
    -> SelectionSet decodesTo RootMutation
candidate_updateCandidate requiredArgs____ object____ =
    Object.selectionForCompositeField "candidate_updateCandidate" [ Argument.required "id" requiredArgs____.id (Data.Scalar.codecs |> Admin.Scalar.unwrapEncoder .codecUuid), Argument.required "candidate" requiredArgs____.candidate Admin.InputObject.encodeFullCandidateInput ] object____ Basics.identity
