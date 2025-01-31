import "./index.css";

import { ApolloClient, ApolloProvider, InMemoryCache } from "@apollo/client";
import { startReactDsfr } from "@codegouvfr/react-dsfr/spa";
import * as Sentry from "@sentry/react";
// import { inspect } from "@xstate/inspect";
import React from "react";
import { createRoot } from "react-dom/client";

import App from "./App";
import { Keycloak } from "./contexts/keycloakContext";
import { KeycloakProvider } from "./contexts/keycloakContext";
import { MainMachineContextProvider } from "./contexts/MainMachineContext/MainMachineContext";
import reportWebVitals from "./reportWebVitals";
import * as serviceWorkerRegistration from "./serviceWorkerRegistration";

startReactDsfr({ defaultColorScheme: "light" });

const client = new ApolloClient({
  uri: process.env.REACT_APP_API_GRAPHQL || "http://localhost:8080/api/graphql",
  cache: new InMemoryCache(),
});

//// Uncomment to debug XState
// inspect({ iframe: false });

const keycloakInstance = Keycloak({
  clientId: process.env.REACT_APP_KEYCLOAK_CLIENT_ID as string,
  realm: process.env.REACT_APP_KEYCLOAK_REALM as string,
  url: process.env.REACT_APP_KEYCLOAK_URL as string,
});

Sentry.init({
  dsn: process.env.REACT_APP_SENTRY_DSN,
  integrations: [new Sentry.BrowserTracing(), new Sentry.Replay()],
});

const container = document.getElementById("root");
const root = createRoot(container!);

root.render(
  <KeycloakProvider keycloakInstance={keycloakInstance}>
    <React.StrictMode>
      <ApolloProvider client={client}>
        <MainMachineContextProvider>
          <App />
        </MainMachineContextProvider>
      </ApolloProvider>
    </React.StrictMode>
  </KeycloakProvider>
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://cra.link/PWA
serviceWorkerRegistration.unregister();

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
