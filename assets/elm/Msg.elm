module Msg exposing (Msg(..))

{-| Message type for all the communications -}

import Pages.Login.Msg as Login exposing (Msg)


type Msg
  = MsgLogin Login.Msg
