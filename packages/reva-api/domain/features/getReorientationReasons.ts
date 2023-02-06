import { Either, EitherAsync } from "purify-ts";

import { ReorientationReason } from "../types/candidacy";
import { FunctionalCodeError, FunctionalError } from "../types/functionalError";

interface GetReorientationReasonsDeps {
  getReorientationReasons: () => Promise<Either<string, ReorientationReason[]>>;
}

export const getReorientationReasons =
  (deps: GetReorientationReasonsDeps) => async () =>
    EitherAsync.fromPromise(() => deps.getReorientationReasons()).mapLeft(
      () =>
        new FunctionalError(
          FunctionalCodeError.TECHNICAL_ERROR,
          "Erreur lors de la récupération des raisons de réorientation"
        )
    );
