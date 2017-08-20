module Util.Facebook exposing (LoginStatus(..), decodeLoginStatus)

{-| All the messages used by mode than one page -}

type LoginStatus
  = Connected
  | NotConnected

decodeLoginStatus : String -> LoginStatus
decodeLoginStatus status =
  case status of
    "connected" -> Connected
    _ -> NotConnected
