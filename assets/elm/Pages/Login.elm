module Pages.Login exposing (initialModel, subscriptions, update, view)

{-| All the jazz for login page
-}

import Config as Config exposing (fb)
import Html exposing (Html, button, div, input, text)
import Html.Events exposing (onClick)

import Ports exposing
  ( appLoaded
  , fbCheckLoginStatus
  , fbInitialized
  , fbLoginStatus
  , fbInit
  , fbLogin)

import Transitions exposing (loginToOffice)

import Msg as App exposing (Msg(..))
import Pages.Login.Msg as Login exposing (..)

import Model as App exposing (Model(..))
import Pages.Login.Model as Login exposing (..)


-- MODEL

{-| This is the starting model for this state
-}
initialModel : App.Model
initialModel =
  ModelLogin {
    state = LoadingApp
  }


-- UPDATE

update : Login.Msg -> Login.Model -> ( App.Model, Cmd msg )
update msg model =
  case msg of
    AppLoaded -> onAppLoaded model
    FbInitialized -> onFacebookInitialized model
    LoginStatusReceived loginStatus -> onFacebookLoginStatus model loginStatus
    Login -> onLogin model


onAppLoaded : Login.Model -> ( App.Model, Cmd msg )
onAppLoaded model =
  ( ModelLogin { model | state = InitializingFb }, fbInit Config.fb )

onFacebookInitialized : Login.Model -> ( App.Model, Cmd msg )
onFacebookInitialized model =
  ( ModelLogin { model | state = CheckingLoginStatus }, fbCheckLoginStatus () )

onFacebookLoginStatus : Login.Model -> LoginStatus -> ( App.Model, Cmd msg )
onFacebookLoginStatus model status =
  case status of
    Connected ->
      ( loginToOffice model, Cmd.none )
    NotConnected ->
      ( ModelLogin { model | state = WaitingForLogin }, Cmd.none )

onLogin : Login.Model -> ( App.Model, Cmd msg )
onLogin model =
  ( ModelLogin { model | state = LoggingIn }, fbLogin ())


-- SUBSCRIPTIONS

subscriptions : Login.Model -> Sub App.Msg
subscriptions model =
  Sub.batch
    [ appLoaded (MsgLogin AppLoaded |> always)
    , fbInitialized (MsgLogin FbInitialized |> always)
    , fbLoginStatus (decodeFbLoginStatus >> LoginStatusReceived >> MsgLogin)
    ]

decodeFbLoginStatus : String -> LoginStatus
decodeFbLoginStatus status =
  case status of
    "connected" -> Connected
    _ -> NotConnected


-- VIEW

view : Login.Model -> Html App.Msg
view model =
  div [] [
    div [] [text "LOGIN PAGE"],
    div [] [text <| "App status " ++ (toString model.state)],
    div [] (loginView model)
  ]

loginView : Login.Model -> List (Html App.Msg)
loginView model =
  case model.state of
    WaitingForLogin ->
      [button [ onClick <| MsgLogin Login ] [ text "Login" ]]
    _ ->
      []
