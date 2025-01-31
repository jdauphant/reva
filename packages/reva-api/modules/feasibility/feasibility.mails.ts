import mjml2html from "mjml";

import { sendGenericEmail } from "../shared/email";
import { formatFreeText } from "../shared/email/utils";
import { logger } from "../shared/logger";
import { UploadedFile } from "./feasibility.features";

const template = ({
  headline,
  content,
  labelCTA,
  url,
  hideFranceVaeLogo,
}: {
  headline?: string;
  content: string;
  labelCTA?: string;
  url?: string;
  hideFranceVaeLogo?: boolean;
}) => `
  <mjml>
    <mj-head>
      <mj-style>
        .cta a,.cta a :visited, .cta a:hover, .cta a:active {
          color: white !important;
        }
      </mj-style>
    </mj-head>
    <mj-body>
      <mj-raw>{% if ${!!hideFranceVaeLogo} != true %}</mj-raw>
        <mj-section>
          <mj-column>
          <mj-image align="center" width="92px" height="55.65px" src="${
            process.env.BASE_URL || "https://vae.gouv.fr"
          }/fvae_logo.png"></mj-image>
        </mj-column>
        </mj-section>
      <mj-raw>{% endif %}</mj-raw>
      <mj-section>
        <mj-column>
          ${
            headline &&
            `
          <mj-text font-size="20px" font-weight="bold" font-family="helvetica">${headline}</mj-text>
          `
          }
          <mj-text font-size="14px" font-family="helvetica" >
            ${content}
          </mj-text>
          ${
            labelCTA &&
            `
          <mj-button css-class="cta" border-radius="4px" font-family="Helvetica" background-color="#1E293B" color="white" href="${url}">
            ${labelCTA}
           </mj-button>
          `
          }
        </mj-column>
      </mj-section>
    </mj-body>
  </mjml>
  `;

export const sendNewFeasibilitySubmittedEmail = async ({
  email,
  feasibilityUrl,
}: {
  email: string;
  feasibilityUrl: string;
}) => {
  const htmlContent = mjml2html(
    template({
      content: `<p>Bonjour,</p><p>Un nouveau dossier de faisabilité vous a été transmis. Vous pouvez y accéder dès maintenant en cliquant sur le bouton ci-dessous.</p>
          <p>Nous vous rappelons que vous disposez d’un délai de 15 jours pour prononcer la recevabilité du dossier.</p>
          <p>L’équipe France VAE.</p>
        `,
      labelCTA: "Accéder au dossier",
      url: feasibilityUrl,
    })
  );

  if (htmlContent.errors.length > 0) {
    const errorMessage = htmlContent.errors
      .map((e) => e.formattedMessage)
      .join("\n");
    logger.error(errorMessage);
    throw new Error(errorMessage);
  }

  if (process.env.NODE_ENV !== "production") {
    logger.info("======= EMAIL CONTENT =======");
    logger.info(htmlContent.html);
    logger.info("=========================");
  }
  return sendGenericEmail({
    to: { email },
    htmlContent: htmlContent.html,
    subject: "Un nouveau dossier de faisabilité est en attente",
  });
};

export const sendFeasibilityValidatedCandidateEmail = async ({
  email,
  comment,
  certifName,
  certificationAuthorityLabel,
  infoFile,
}: {
  email: string;
  comment?: string;
  certifName: string;
  certificationAuthorityLabel: string;
  infoFile?: UploadedFile;
}) => {
  const commentInfo = comment
    ? `
        <br/>
        <p><strong>Pour votre information, voici les remarques faites par le certificateur :</strong></p>
        <p><em>${formatFreeText(comment)}</em></p>
        `
    : "";
  const htmlContent = mjml2html(
    template({
      content: `<p>Bonjour,</p>
      <br/>
      <p>Vous trouverez ci-dessous la décision de recevabilité du certificateur ${certificationAuthorityLabel} concernant votre dossier de faisabilité pour la certification <em>${certifName}</em>.</p>
      <p>Félicitations, votre dossier a été jugé recevable par le certificateur et vous pouvez désormais démarrer votre parcours VAE. Nous vous invitons à prendre contact avec votre architecte de parcours afin d’organiser la suite.</p>
      ${commentInfo}
    `,
      hideFranceVaeLogo: true,
    })
  );

  if (htmlContent.errors.length > 0) {
    const errorMessage = htmlContent.errors
      .map((e) => e.formattedMessage)
      .join("\n");
    logger.error(errorMessage);
    throw new Error(errorMessage);
  }

  if (process.env.NODE_ENV !== "production") {
    logger.info("======= EMAIL CONTENT =======");
    logger.info(htmlContent.html);
    logger.info("=========================");
  }

  const attachment = infoFile
    ? [{ name: infoFile.filename, content: infoFile.data.toString("base64") }]
    : undefined;

  return sendGenericEmail({
    to: { email },
    htmlContent: htmlContent.html,
    subject: "Votre dossier de faisabilité VAE a été examiné",
    attachment,
  });
};

export const sendFeasibilityRejectedCandidateEmail = async ({
  email,
  comment,
  certificationAuthorityLabel,
  infoFile,
}: {
  email: string;
  comment?: string;
  certificationAuthorityLabel: string;
  infoFile?: UploadedFile;
}) => {
  const commentInfo = comment
    ? `
        <br/>
        <p><strong>Voici les remarques faites par le certificateur</strong> (ces préconisations pourront être reprises avec votre architecte accompagnateur de parcours) :</p>
        <p><em>${formatFreeText(comment)}</em></p>
        `
    : "";

  const htmlContent = mjml2html(
    template({
      content: `<p>Bonjour,</p>
        <br/>
        <p>Vous trouverez ci-dessous la décision du certificateur ${certificationAuthorityLabel} concernant votre dossier de faisabilité.</p>
        <p>Malheureusement, votre dossier a été jugé non recevable par le certificateur. Nous vous invitons à prendre contact avec votre architecte de parcours pour comprendre cette décision et échanger ensemble sur les suites à donner à votre parcours.</p>
        ${commentInfo}
      `,
      hideFranceVaeLogo: true,
    })
  );

  if (htmlContent.errors.length > 0) {
    const errorMessage = htmlContent.errors
      .map((e) => e.formattedMessage)
      .join("\n");
    logger.error(errorMessage);
    throw new Error(errorMessage);
  }

  if (process.env.NODE_ENV !== "production") {
    logger.info("======= EMAIL CONTENT =======");
    logger.info(htmlContent.html);
    logger.info("=========================");
  }
  const attachment = infoFile
    ? [{ name: infoFile.filename, content: infoFile.data.toString("base64") }]
    : undefined;

  return sendGenericEmail({
    to: { email },
    htmlContent: htmlContent.html,
    subject: "Votre dossier de faisabilité",
    attachment,
  });
};

export const sendFeasibilityDecisionTakenToAAPEmail = async ({
  email,
  feasibilityUrl,
}: {
  email: string;
  feasibilityUrl: string;
}) => {
  const htmlContent = mjml2html(
    template({
      content: `<p>Bonjour,</p><p>Un nouvel avis de recevabilité est disponible via le lien ci-dessous.</p>
          <p>L’équipe France VAE.</p>
        `,
      labelCTA: "Accéder à la notification de recevabilité",
      url: feasibilityUrl,
    })
  );

  if (htmlContent.errors.length > 0) {
    const errorMessage = htmlContent.errors
      .map((e) => e.formattedMessage)
      .join("\n");
    logger.error(errorMessage);
    throw new Error(errorMessage);
  }

  if (process.env.NODE_ENV !== "production") {
    logger.info("======= EMAIL CONTENT =======");
    logger.info(htmlContent.html);
    logger.info("=========================");
  }
  return sendGenericEmail({
    to: { email },
    htmlContent: htmlContent.html,
    subject: "Un nouvel avis de recevabilité est disponible",
  });
};

export const sendFeasibilityIncompleteMailToAAP = async ({
  email,
  feasibilityUrl,
}: {
  email: string;
  feasibilityUrl: string;
}) => {
  const htmlContent = mjml2html(
    template({
      content: `<p>Bonjour,</p><p>Un dossier transmis par vos soins a été noté comme incomplet par le certificateur.</p>
      <p>Vous trouverez le détail des éléments manquants dans la page du dossier.</p>
      <p>Nous vous invitons à le compléter et à le renvoyer au certificateur dans les meilleurs délais.</p>
        `,
      labelCTA: "Accéder au dossier",
      url: feasibilityUrl,
    })
  );

  if (htmlContent.errors.length > 0) {
    const errorMessage = htmlContent.errors
      .map((e) => e.formattedMessage)
      .join("\n");
    logger.error(errorMessage);
    throw new Error(errorMessage);
  }

  if (process.env.NODE_ENV !== "production") {
    logger.info("======= EMAIL CONTENT =======");
    logger.info(htmlContent.html);
    logger.info("=========================");
  }
  return sendGenericEmail({
    to: { email },
    htmlContent: htmlContent.html,
    subject: "Un dossier de recevabilité a été marqué comme incomplet",
  });
};
