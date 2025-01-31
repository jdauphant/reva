import { Either, EitherAsync, Left, Maybe } from "purify-ts";

import { Role } from "../../account/account.types";
import {
  FunctionalCodeError,
  FunctionalError,
} from "../../shared/error/functionalError";
import { ExamInfo } from "../candidacy.types";

interface GetExamInfoDeps {
  hasRole: (role: Role) => boolean;
  getExamInfoFromCandidacyId: (params: {
    candidacyId: string;
  }) => Promise<Either<string, Maybe<ExamInfo>>>;
}

export const getExamInfo =
  (deps: GetExamInfoDeps) =>
  async (params: {
    candidacyId: string;
  }): Promise<Either<FunctionalError, Maybe<ExamInfo>>> => {
    if (!deps.hasRole("admin") && !deps.hasRole("manage_candidacy")) {
      return Left(
        new FunctionalError(
          FunctionalCodeError.NOT_AUTHORIZED,
          `Vous n'avez pas accès aux information jury de cette candidature`
        )
      );
    }

    return EitherAsync.fromPromise(() =>
      deps.getExamInfoFromCandidacyId({ candidacyId: params.candidacyId })
    ).mapLeft(
      () =>
        new FunctionalError(
          FunctionalCodeError.TECHNICAL_ERROR,
          `Erreur pendant la récupération des informations jury de la candidature`
        )
    );
  };
