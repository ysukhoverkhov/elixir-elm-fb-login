module Pages.Office.Msg exposing (Msg(..))

{-| All the messages used by office page -}

import Util.Facebook exposing (LoginStatus(..))

type Msg
  = Logout
  | LogoutStatusReceived LoginStatus
