module Msg exposing (Msg(..))

{-| Message type for all the communications -}

import Pages.Login.Msg as Login exposing (Msg)
import Pages.Office.Msg as Office exposing (Msg)


type Msg
  = MsgLogin Login.Msg
  | MsgOffice Office.Msg
