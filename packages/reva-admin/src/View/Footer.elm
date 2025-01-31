module View.Footer exposing (..)

import Accessibility exposing (a, div, footer, li, p, text, ul)
import Accessibility.Aria
import Html.Attributes exposing (alt, attribute, class, height, href, id, target, width)
import Route
import View


view : { a | baseUrl : String } -> Accessibility.Html msg
view context =
    footer
        [ class "fr-footer"
        , attribute "role" "contentinfo"
        , id "footer"
        ]
        [ div
            [ class "fr-container" ]
            [ div
                [ class "fr-footer__body" ]
                [ div
                    [ class "fr-footer__brand fr-enlarge-link" ]
                    [ View.logo
                    , a
                        [ class "fr-footer__brand-link"
                        , attribute "title" "Accueil - Espace professionnel"
                        , Route.href context.baseUrl Route.Home
                        ]
                        [ View.image
                            [ alt "France VAE"
                            , width 225
                            , height 138
                            ]
                            context.baseUrl
                            "fvae_logo.svg"
                        ]
                    ]
                , div
                    [ class "fr-footer__content" ]
                    [ p
                        [ class "fr-footer__content-desc" ]
                        [ text "France VAE est le portail officiel du service public qui vise à transformer la VAE avec nos partenaires." ]
                    , ul
                        [ class "fr-footer__content-list" ]
                        [ li
                            [ class "fr-footer__content-item"
                            ]
                            [ a
                                [ class "fr-footer__content-link"
                                , target "_blank"
                                , href "https://legifrance.gouv.fr"
                                , Accessibility.Aria.label "legifrance.gouv.fr nouvelle page"
                                ]
                                [ text "legifrance.gouv.fr" ]
                            ]
                        , li
                            [ class "fr-footer__content-item" ]
                            [ a
                                [ class "fr-footer__content-link"
                                , target "_blank"
                                , href "https://gouvernement.fr"
                                , Accessibility.Aria.label "gouvernement.fr nouvelle page"
                                ]
                                [ text "gouvernement.fr" ]
                            ]
                        , li
                            [ class "fr-footer__content-item" ]
                            [ a
                                [ class "fr-footer__content-link"
                                , target "_blank"
                                , href "https://service-public.fr"
                                , Accessibility.Aria.label "service-public.fr nouvelle page"
                                ]
                                [ text "service-public.fr" ]
                            ]
                        , li
                            [ class "fr-footer__content-item" ]
                            [ a
                                [ class "fr-footer__content-link"
                                , target "_blank"
                                , href "https://data.gouv.fr"
                                , Accessibility.Aria.label "data.gouv.fr nouvelle page"
                                ]
                                [ text "data.gouv.fr" ]
                            ]
                        ]
                    ]
                ]
            , div
                [ class "fr-footer__bottom" ]
                [ ul
                    [ class "fr-footer__bottom-list" ]
                    [ li
                        [ class "fr-footer__bottom-item"
                        ]
                        [ a
                            [ class "fr-footer__bottom-link"
                            , target "_parent"
                            , Route.href context.baseUrl <|
                                Route.SiteMap
                            ]
                            [ text "Plan du site" ]
                        ]
                    , li
                        [ class "fr-footer__bottom-item" ]
                        [ a
                            [ class "fr-footer__bottom-link"
                            , target "_parent"
                            , href "/declaration-accessibilite/"
                            ]
                            [ text "Accessibilité : partiellement conforme" ]
                        ]
                    , li
                        [ class "fr-footer__bottom-item"
                        ]
                        [ a
                            [ class "fr-footer__bottom-link"
                            , target "_parent"
                            , href "/mentions-legales/"
                            ]
                            [ text "Mentions légales" ]
                        ]
                    , li
                        [ class "fr-footer__bottom-item" ]
                        [ a
                            [ class "fr-footer__bottom-link"
                            , target "_parent"
                            , href "/confidentialite/"
                            ]
                            [ text "Données personnelles" ]
                        ]
                    , li
                        [ class "fr-footer__bottom-item" ]
                        [ a
                            [ class "fr-footer__bottom-link"
                            , href "mailto:support@vae.gouv.fr"
                            ]
                            [ text "Nous contacter" ]
                        ]
                    ]
                , div
                    [ class "fr-footer__bottom-copy" ]
                    [ p []
                        [ text "Sauf mention contraire, tous les contenus de ce site sont sous "
                        , a
                            [ href "https://github.com/etalab/licence-ouverte/blob/master/LO.md"
                            , target "_blank"
                            , Accessibility.Aria.label "licence etalab-2.0 nouvelle page"
                            ]
                            [ text "licence etalab-2.0" ]
                        ]
                    ]
                ]
            ]
        ]
