module Pages.Login exposing
    ( Model
    , initialModel
    , subscriptions
    , update
    , view
    )

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

import Msg as App exposing (Msg(..))
import Pages.Login.Msg as Login exposing (..)

-- MODEL


type alias Model =
  { appLoaded : Bool
  , fbInitialized : Bool
  }


{-| This is the starting model for this state
-}
initialModel : Model
initialModel =
  { appLoaded = False
  , fbInitialized = False
  }



-- UPDATE

update : Login.Msg -> Model -> ( Model -> a) -> ( a, Cmd msg )
update msg model modelProd =
  let
    result =
      case msg of
        AppLoaded -> onAppLoaded model
        FbInitialized -> onFacebookInitialized model
        LoginStatusReceived loginStatus -> onFacebookLoginStatus model loginStatus
  in
    Tuple.mapFirst modelProd result


onAppLoaded : Model -> ( Model, Cmd msg )
onAppLoaded model =
  ( { model | appLoaded = True }, initFb Config.fb )

onFacebookInitialized : Model -> ( Model, Cmd msg )
onFacebookInitialized model =
  ( { model | fbInitialized = True }, checkLoginStatus () )

onFacebookLoginStatus : Model -> LoginStatus -> ( Model, Cmd msg )
onFacebookLoginStatus model status =
  Debug.log (toString status) ( model, Cmd.none )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub App.Msg
subscriptions model =
  Sub.batch
    [ appLoaded (\_ -> MsgLogin AppLoaded)
    , fbInitialized (\_ -> MsgLogin FbInitialized)
    , fbLoginStatus (\s -> MsgLogin (LoginStatusReceived(decodeFbLoginStatus s)))
    ]

decodeFbLoginStatus : String -> LoginStatus
decodeFbLoginStatus status =
  case status of
    "connected" -> Connected
    _ -> NotConnected


-- VIEW

view : Model -> Html msg
view model =
  div [] [
    div [] [text "LOGIN APP"],
    div [] [text (toString model.appLoaded)]
  ]
