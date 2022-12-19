module Data.Referential exposing (BasicSkill, Department, DropOutReason, MandatoryTraining, Referential, ReferentialGoal, ReferentialGoals, departmentToString)

import Data.Candidate
import Data.Scalar
import Dict exposing (Dict)


type alias BasicSkill =
    { id : String
    , label : String
    }


type alias DropOutReason =
    { id : String
    , label : String
    }


type alias ReferentialGoal =
    { id : String
    , label : String
    , order : Int
    , needsAdditionalInformation : Bool
    , isActive : Bool
    }


type alias ReferentialGoals =
    { goals : Dict String ReferentialGoal }


type alias MandatoryTraining =
    { id : String
    , label : String
    }


type alias Referential =
    { basicSkills : List BasicSkill
    , degrees : List Data.Candidate.Degree
    , dropOutReasons : List DropOutReason
    , goals : Dict String ReferentialGoal
    , mandatoryTrainings : List MandatoryTraining
    , vulnerabilityIndicators : List Data.Candidate.VulnerabilityIndicator
    }


type alias Department =
    { id : Data.Scalar.Id
    , code : String
    , label : String
    }


departmentToString : Department -> String
departmentToString department =
    department.label ++ " (" ++ department.code ++ ")"
