module Pages.Office exposing (subscriptions, update, view)

{-| All the jazz for office page
-}

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

import Ports exposing (fbLogout)

import Transitions exposing (officeToLogin)

import Msg as App exposing (Msg(..))
import Pages.Office.Msg as Office exposing (..)

import Model as App exposing (Model(..))
import Pages.Office.Model as Office exposing (..)


-- UPDATE

update : Office.Msg -> Office.Model -> ( App.Model, Cmd msg )
update msg model =
  case msg of
    Logout -> onLogout model

onLogout : Office.Model -> ( App.Model, Cmd msg )
onLogout model =
  ( officeToLogin model, fbLogout () )


-- SUBSCRIPTIONS

subscriptions : Office.Model -> Sub msg
subscriptions model =
  Sub.none


-- VIEW

view : Office.Model -> Html App.Msg
view model =
  div [] [
    div [] [text "OFFICE PAGE"],
    div [] [text (model.userId)],
    div [] [button [ onClick <| MsgOffice Logout ] [ text "Logout" ]]
  ]
