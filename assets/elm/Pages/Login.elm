module Pages.Login exposing (initialModel, subscriptions, update, view)

{-| All the jazz for login page
-}

import Config as Config exposing (fb)
import Html exposing (Html, button, div, input, text)
import Ports exposing
  ( appLoaded
  , checkLoginStatus
  , fbInitialized
  , fbLoginStatus
  , initFb)

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
    appLoaded = False,
    fbInitialized = False
  }


-- UPDATE

update : Login.Msg -> Login.Model -> ( App.Model, Cmd msg )
update msg model =
  case msg of
    AppLoaded -> onAppLoaded model
    FbInitialized -> onFacebookInitialized model
    LoginStatusReceived loginStatus -> onFacebookLoginStatus model loginStatus


onAppLoaded : Login.Model -> ( App.Model, Cmd msg )
onAppLoaded model =
  ( ModelLogin { model | appLoaded = True }, initFb Config.fb )

onFacebookInitialized : Login.Model -> ( App.Model, Cmd msg )
onFacebookInitialized model =
  ( ModelLogin { model | fbInitialized = True }, checkLoginStatus () )

onFacebookLoginStatus : Login.Model -> LoginStatus -> ( App.Model, Cmd msg )
onFacebookLoginStatus model status =
  case status of
    Connected -> Debug.log ("C!") ( loginToOffice model, Cmd.none )
    NotConnected -> Debug.log (toString status) ( ModelLogin model, Cmd.none )


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

view : Login.Model -> Html msg
view model =
  div [] [
    div [] [text "LOGIN PAGE"],
    div [] [text (toString model.appLoaded)]
  ]
