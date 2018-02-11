module Translate exposing (..)


type Language
    = EN
    | FR
    | IT


allLanguages : List Language
allLanguages =
    [ EN, FR, IT ]


type AppString
    = DevelopedByStr
    | FeetStr
    | FramesStr
    | GaugeStr
    | ImperialStr
    | MetresStr
    | MetricStr
    | SecondsStr
    | SetOptionStr
    | TaglineStr


translate : Language -> AppString -> String
translate language appString =
    let
        translationSet =
            case appString of
                DevelopedByStr ->
                    { en = "Web app by K F Nagels"
                    , fr = "Application web par K F Nagels"
                    , it = "Applicazione web di K F Nagels"
                    }

                FeetStr ->
                    { en = "feet"
                    , fr = "pieds"
                    , it = "piedi"
                    }

                FramesStr ->
                    { en = "frames"
                    , fr = "cadres"
                    , it = "fotogramme"
                    }

                GaugeStr ->
                    { en = "Choose a gauge:"
                    , fr = "Choisir un format:"
                    , it = "Scegliere un formato:"
                    }

                ImperialStr ->
                    { en = "imperial"
                    , fr = "impérial"
                    , it = "imperiale"
                    }

                MetresStr ->
                    { en = "metres"
                    , fr = "mètres"
                    , it = "metri"
                    }

                MetricStr ->
                    { en = "metric"
                    , fr = "métrique"
                    , it = "metrico"
                    }

                SecondsStr ->
                    { en = "seconds"
                    , fr = "secondes"
                    , it = "secondi"
                    }

                SetOptionStr ->
                    { en = "Set one of the following (click to focus):"
                    , fr = "Définissez une option (cliquez pour sélectionner):"
                    , it = "Imposta un'opzione (clicca per selezionare)"
                    }

                TaglineStr ->
                    { en = "a calculator for analogue film"
                    , fr = "une calculatrice pour la pellicule"
                    , it = "un calcolatrice per la pellicola"
                    }
    in
    case language of
        EN ->
            .en translationSet

        FR ->
            .fr translationSet

        IT ->
            .it translationSet
