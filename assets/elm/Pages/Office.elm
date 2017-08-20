module Pages.Office exposing (subscriptions, update, view)

{-| All the jazz for login page
-}

import Html exposing (Html, button, div, input, text)

-- import Msg as App exposing (Msg(..))
import Pages.Office.Msg as Office exposing (..)

import Model as App exposing (Model(..))
import Pages.Office.Model as Office exposing (..)


-- UPDATE

update : Office.Msg -> Office.Model -> ( App.Model, Cmd msg )
update msg model = ( ModelOffice model, Cmd.none)
  -- case msg of
  --   AppLoaded -> onAppLoaded model
  --   FbInitialized -> onFacebookInitialized model
  --   LoginStatusReceived loginStatus -> onFacebookLoginStatus model loginStatus


-- SUBSCRIPTIONS

subscriptions : Office.Model -> Sub msg
subscriptions model =
  Sub.none


-- VIEW

view : Office.Model -> Html msg
view model =
  div [] [
    div [] [text "OFFICE PAGE"],
    div [] [text (model.userId)]
  ]
