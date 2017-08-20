module Pages.Login.Model exposing (Model)

{-| Model for login state -}

type alias Model =
  { appLoaded : Bool
  , fbInitialized : Bool
  }
