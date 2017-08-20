module Pages.Login.Model exposing (Model, State(..))

{-| Model for login state -}

type State
  = LoadingApp
  | InitializingFb
  | CheckingLoginStatus
  | WaitingForLogin
  | LoggingIn


type alias Model =
  {
    state : State
  }
