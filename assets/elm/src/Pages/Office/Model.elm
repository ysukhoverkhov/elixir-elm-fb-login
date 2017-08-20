module Pages.Office.Model exposing (Model, State(..))

{-| Model for Office state -}

type State
  = Working
  | WaitingForLogout

type alias Model =
  {
    state : State,
    userId : String
  }
