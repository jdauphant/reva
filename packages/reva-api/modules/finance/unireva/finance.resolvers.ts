import { composeResolvers } from "@graphql-tools/resolvers-composition";
import { PaymentRequest } from "@prisma/client";
import mercurius from "mercurius";

import { Role } from "../../account/account.types";
import { Candidacy } from "../../candidacy/candidacy.types";
import {
  existsCandidacyWithActiveStatus,
  getCandidacyFromId,
  updateCandidacyStatus,
} from "../../candidacy/database/candidacies";
import { getAfgsuTrainingId } from "../../candidacy/database/trainings";
import { getCandidateByCandidacyId } from "../../candidate/database/candidates";
import * as fundingRequestsDb from "./database/fundingRequests";
import * as paymentRequestsDb from "./database/paymentRequest";
import * as paymentRequestBatchesDb from "./database/paymentRequestBatches";
import { confirmPaymentRequest } from "./features/confirmPaymentRequest";
import { createOrUpdatePaymentRequestForCandidacy } from "./features/createOrUpdatePaymentRequestForCandidacy";
import { getFundingRequest } from "./features/getFundingRequest";
import { getPaymentRequestByCandidacyId } from "./features/getPaymentRequestByCandidacyId";
import { resolversSecurityMap } from "./security";

const unsafeResolvers = {
  Candidacy: {
    paymentRequest: async (
      parent: Candidacy,
      _: unknown,
      context: { auth: { hasRole: (role: Role) => boolean } }
    ) => {
      const result = await getPaymentRequestByCandidacyId({
        hasRole: context.auth.hasRole,
        getPaymentRequestByCandidacyId:
          paymentRequestsDb.getPaymentRequestByCandidacyId,
      })({ candidacyId: parent.id });
      return result
        .mapLeft((error) => new mercurius.ErrorWithProps(error.message, error))
        .map((v) => v.extractNullable())
        .extract();
    },
  },
  Query: {
    candidate_getFundingRequest: async (
      _: unknown,
      params: { candidacyId: string },
      context: { auth: any }
    ) => {
      const result = await getFundingRequest({
        hasRole: context.auth.hasRole,
        getCandidacyFromId,
        getFundingRequestFromCandidacyId: fundingRequestsDb.getFundingRequest,
      })({ candidacyId: params.candidacyId });

      return result
        .map((fundingRequestInformations: any) => {
          return {
            fundingRequest: fundingRequestInformations.fundingRequest,
            training: {
              ...fundingRequestInformations.training,
              mandatoryTrainings:
                fundingRequestInformations.training.mandatoryTrainings,
            },
          };
        })
        .mapLeft((error) => new mercurius.ErrorWithProps(error.message, error))
        .extract();
    },
  },
  Mutation: {
    candidacy_createOrUpdatePaymentRequest: async (
      _: unknown,
      {
        candidacyId,
        paymentRequest,
      }: { candidacyId: string; paymentRequest: PaymentRequest }
    ) => {
      const result = await createOrUpdatePaymentRequestForCandidacy({
        getCandidateByCandidacyId,
        getFundingRequestByCandidacyId: fundingRequestsDb.getFundingRequest,
        getPaymentRequestByCandidacyId:
          paymentRequestsDb.getPaymentRequestByCandidacyId,
        createPaymentRequest: paymentRequestsDb.createPaymentRequest,
        updatePaymentRequest: paymentRequestsDb.updatePaymentRequest,
        getAfgsuTrainingId: getAfgsuTrainingId,
      })({
        candidacyId,
        paymentRequest,
      });

      return result
        .mapLeft((error) => new mercurius.ErrorWithProps(error.message, error))
        .extract();
    },
    candidacy_confirmPaymentRequest: async (
      _: unknown,
      { candidacyId }: { candidacyId: string },
      context: { auth: { hasRole: (role: Role) => boolean } }
    ) => {
      const result = await confirmPaymentRequest({
        hasRole: context.auth.hasRole,
        existsCandidacyWithActiveStatus,
        getPaymentRequestByCandidacyId:
          paymentRequestsDb.getPaymentRequestByCandidacyId,
        updateCandidacyStatus,
        createPaymentRequestBatch:
          paymentRequestBatchesDb.createPaymentRequestBatch,
        getFundingRequestByCandidacyId: fundingRequestsDb.getFundingRequest,
        getCandidacyFromId,
      })({
        candidacyId: candidacyId,
      });

      return result
        .mapLeft((error) => new mercurius.ErrorWithProps(error.message, error))
        .extract();
    },
  },
};

export const financeResolvers = composeResolvers(
  unsafeResolvers,
  resolversSecurityMap
);
