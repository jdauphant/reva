import "@/styles/globals.css";
import "@/styles/dsfr-theme-tac.min.css";
import "@/styles/dsfr-theme-tac-extra.css";

import init from "@/components/analytics/matomo-tracker/matomoTracker";
import { MATOMO } from "@/config/config";
import { createNextDsfrIntegrationApi } from "@codegouvfr/react-dsfr/next-pagesdir";
import type { AppProps } from "next/app";
import Link from "next/link";
import { useEffect } from "react";

declare module "@codegouvfr/react-dsfr/next-pagesdir" {
  interface RegisterLink {
    Link: typeof Link;
  }
}

const { withDsfr, dsfrDocumentApi } = createNextDsfrIntegrationApi({
  defaultColorScheme: "light",
  Link,
});

export { dsfrDocumentApi };

function App({ Component, pageProps }: AppProps) {
  useEffect(() => {
    if (MATOMO.URL && MATOMO.SITE_ID) {
      init({
        url: MATOMO.URL,
        siteId: MATOMO.SITE_ID,
        jsTrackerFile: `js/container_${MATOMO.CONTAINER_NAME}.js`,
      });
    }
  }, []);

  return <Component {...pageProps} />;
}

export default withDsfr(App);
