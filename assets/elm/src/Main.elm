module Main exposing (main)

{-| Just playing
@docs main
-}

import Html exposing (Html, button, div, input, text)

import Msg exposing (Msg(..))
import Model exposing (Model(..))

import Pages.Login as Login exposing (initialModel, subscriptions, update, view)
import Pages.Office as Office exposing (subscriptions, update, view)

{-| The main
-}
main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

init : ( Model, Cmd msg )
init =
  ( Login.initialModel, Cmd.none )


-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case ( msg, model ) of
    ( MsgLogin lmsg, ModelLogin lmodel ) ->
      Login.update lmsg lmodel

    ( MsgOffice lmsg, ModelOffice lmodel ) ->
      Office.update lmsg lmodel

    _ ->
      -- TODO: Fatal error model here.
      ( model, Cmd.none )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  case model of
    ModelLogin m ->
      Login.subscriptions m

    ModelOffice m ->
      Office.subscriptions m


-- VIEW

view : Model -> Html Msg
view model =
  case model of
    ModelLogin m ->
      Login.view m

    ModelOffice m ->
      Office.view m
