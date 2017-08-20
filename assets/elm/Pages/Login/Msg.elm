module Pages.Login.Msg exposing (Msg(..), LoginStatus(..))

{-| All the messages used by Login page -}

type LoginStatus
  = Connected
  | NotConnected

type Msg
  = AppLoaded
  | FbInitialized
  | LoginStatusReceived LoginStatus
