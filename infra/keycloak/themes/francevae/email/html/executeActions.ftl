<#import "email-template.ftl" as layout>
<@layout.emailLayout ; section>
    <#if section = "title">
      Votre compte professionnel France VAE
    <#elseif section = "intro">
      <p>Nous vous remercions pour votre référencement sur la plateforme France VAE. Pour finaliser la création de votre compte, nous vous invitions à cliquer sur le bouton ci-dessous et vous laisser guider.</p>
    <#elseif section = "actionButton">
      <a href="${link}" style="display:inline-block;background:#1c38b0;color:#ffffff;font-family:Arial, sans-serif;font-size:14px;font-weight:normal;line-height:120%;margin:0;text-decoration:none;text-transform:none;padding:10px 25px 10px 25px;mso-padding-alt:0px;border-radius:3px;" target="_blank"><span style="font-size:14px;">Créer mon compte</span></a>
    <#elseif section = "outro">
      <p class="text-build-content" data-testid="I0ETIbJm4" style="margin: 10px 0; margin-top: 10px;">
        Vous pourrez ainsi compléter votre espace professionnel à l’aide de la documentation mise à disposition.
      </p>
      <p>N'hésitez pas à nous contacter via la messagerie instantanée présente dans votre espace personnel ou par email à support@vae.gouv.fr</p>
      <p>Cordialement,</p>
      <p>L’équipe France VAE.</p>
    </#if>
</@layout.emailLayout>