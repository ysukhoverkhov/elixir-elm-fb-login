module Main exposing (main)

{-| Just playing
@docs main
-}

import Html exposing (Html, button, div, input, text)
import Pages.Login as Login exposing (Model, initialModel, subscriptions, update, view)
import Msg exposing (Msg(..))

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
-- TODO: move me to App Page.


type alias AppModel =
  { userId : String
  }


type Model
  = ModelLogin Login.Model
  | ModelApp AppModel


initialModel : Model
initialModel =
  ModelLogin Login.initialModel


init : ( Model, Cmd msg )
init =
  ( initialModel, Cmd.none )



-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case ( msg, model ) of
    ( MsgLogin lmsg, ModelLogin lmodel ) ->
      Login.update lmsg lmodel ModelLogin

    _ ->
      -- TODO: Fatal error model here.
      ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  case model of
    ModelLogin m ->
      Login.subscriptions m

    ModelApp _ ->
      Sub.none



-- VIEW


view : Model -> Html Msg
view model =
  case model of
    ModelLogin m ->
      Login.view m

    ModelApp _ ->
      text "APP"
