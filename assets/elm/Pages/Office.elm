module Pages.Office exposing (subscriptions, update, view)

{-| All the jazz for office page
-}

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

import Ports exposing (fbLogout, fbLoginStatus)

import Transitions exposing (officeToLogin)
import Util.Facebook as FB exposing (decodeLoginStatus)

import Msg as App exposing (Msg(..))
import Pages.Office.Msg as Office exposing (..)

import Model as App exposing (Model(..))
import Pages.Office.Model as Office exposing (..)


-- UPDATE

update : Office.Msg -> Office.Model -> ( App.Model, Cmd msg )
update msg model =
  case msg of
    Logout ->
      onLogout model
    LogoutStatusReceived loginStatus ->
      onFacebookLoginStatus model loginStatus

onLogout : Office.Model -> ( App.Model, Cmd msg )
onLogout model =
  ( ModelOffice { model | state = WaitingForLogout }, fbLogout () )

onFacebookLoginStatus : Office.Model -> FB.LoginStatus -> ( App.Model, Cmd msg )
onFacebookLoginStatus model status =
  case status of
    FB.Connected ->
      ( ModelOffice { model | state = Working }, Cmd.none )
    FB.NotConnected ->
      ( officeToLogin model, Cmd.none )


-- SUBSCRIPTIONS

subscriptions : Office.Model -> Sub App.Msg
subscriptions model =
  Sub.batch
    [ fbLoginStatus (FB.decodeLoginStatus >> LogoutStatusReceived >> MsgOffice)
    ]


-- VIEW

view : Office.Model -> Html App.Msg
view model =
  div [] [
    div [] [text "OFFICE PAGE"],
    div [] [text <| "App status " ++ (toString model.state)],
    div [] [text (model.userId)],
    div [] (logoutButtonView model)
  ]

logoutButtonView : Office.Model -> List (Html App.Msg)
logoutButtonView model =
  case model.state of
    WaitingForLogout ->
      []
    _ ->
      [button [ onClick <| MsgOffice Logout ] [ text "Logout" ]]
