/**
 * @jest-environment ./test/fastify-test-env.ts
 */

import { LegalStatus } from "@prisma/client";

import { authorizationHeaderForUser } from "../../../../test/helpers/authorization-helper";
import { injectGraphql } from "../../../../test/helpers/graphql-helper";
import { prismaClient } from "../../../database/postgres/client";

const subreqSampleMin = {
  companySiret: "1234888",
  companyLegalStatus: LegalStatus.SAS,
  companyName: "Jojo formation",
  companyBillingContactFirstname: "Josette",
  companyBillingContactLastname: "Lacomptable",
  companyBillingEmail: "billingjosette@jojo-formation.fr",
  companyBillingPhoneNumber: "03214556789",
  companyBic: "1232131",
  companyIban: "234345343",
  accountFirstname: "Jojo",
  accountLastname: "Landouille",
  accountEmail: "contact@jojo-formation.fr",
  accountPhoneNumber: "03214556789",
  typology: "generaliste" as const,
};

const subreqSampleAddress = {
  companyAddress: "64 boulevard du Général Leclerc",
  companyZipCode: "35660",
  companyCity: "Fougères",
};

const subreqSampleFull = Object.assign(
  {},
  subreqSampleMin,
  subreqSampleAddress
);

let subreq1Id: string, subreq2Id: string;

beforeAll(async () => {
  const subreq = await prismaClient.subscriptionRequest.create({
    data: subreqSampleFull,
  });
  subreq2Id = subreq.id;
});

afterAll(async () => {
  await prismaClient.subscriptionRequest.deleteMany({
    where: {
      id: { in: [subreq1Id, subreq2Id] },
    },
  });
});

test("Should fail to create a subscription request with missing address fields", async () => {
  const resp = await injectGraphql({
    fastify: (global as any).fastify,
    authorization: authorizationHeaderForUser({
      role: "manage_candidacy",
      keycloakId: "blabla",
    }),
    payload: {
      requestType: "mutation",
      endpoint: "subscription_createSubscriptionRequest",
      arguments: { subscriptionRequest: subreqSampleMin },
      enumFields: ["companyLegalStatus"],
      returnFields:
        "{ id, companySiret, companyLegalStatus, companyName, companyAddress, companyZipCode, companyCity, companyBillingContactFirstname, companyBillingContactLastname, companyBillingEmail, companyBillingPhoneNumber, companyBic, companyIban, accountFirstname, accountLastname, accountEmail, accountPhoneNumber }",
    },
  });
  expect(resp.statusCode).toEqual(200);
  expect(resp.json()).toHaveProperty("errors");
});

test("Should create a subscription request", async () => {
  const resp = await injectGraphql({
    fastify: (global as any).fastify,
    authorization: authorizationHeaderForUser({
      role: "manage_candidacy",
      keycloakId: "blabla",
    }),
    payload: {
      requestType: "mutation",
      endpoint: "subscription_createSubscriptionRequest",
      arguments: { subscriptionRequest: subreqSampleFull },
      enumFields: ["companyLegalStatus", "typology"],
      returnFields:
        "{ id, companySiret, companyLegalStatus, companyName, companyAddress, companyZipCode, companyCity, companyBillingContactFirstname, companyBillingContactLastname, companyBillingEmail, companyBillingPhoneNumber, companyBic, companyIban, accountFirstname, accountLastname, accountEmail, accountPhoneNumber }",
    },
  });
  expect(resp.statusCode).toEqual(200);
  expect(resp.json()).not.toHaveProperty("errors");
  const subreq = resp.json().data.subscription_createSubscriptionRequest;
  subreq1Id = subreq.id;

  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  const { typology, ...subRequestWithoutTypology } = subreqSampleFull;
  expect(subreq).toMatchObject(subRequestWithoutTypology);
});
