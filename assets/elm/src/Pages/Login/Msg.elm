module Pages.Login.Msg exposing (Msg(..))

{-| All the messages used by Login page -}

import Util.Facebook exposing (LoginStatus(..))

type Msg
  = AppLoaded
  | FbInitialized
  | LoginStatusReceived LoginStatus
  | Login
