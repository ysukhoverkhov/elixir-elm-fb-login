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

import Msg as App exposing (Msg)
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

decodeFbLoginStatus : String -> LoginStatus
decodeFbLoginStatus status =
  case status of
    "connected" -> Connected
    _ -> NotConnected


update : Login.Msg -> Model -> ( Model -> a, Login.Msg -> b ) -> ( a, Cmd b )
update msg model ( modelProd, _ ) =
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

subscriptions : Model -> (Login.Msg -> msg) -> Sub msg
subscriptions model prod =
  Sub.batch
    [ appLoaded (\_ -> prod AppLoaded)
    , fbInitialized (\_ -> prod FbInitialized)
    , fbLoginStatus (\s -> prod (LoginStatusReceived(decodeFbLoginStatus s)))
    ]


-- VIEW

view : Model -> (Login.Msg -> msg) -> Html msg
view model _ =
  div [] [
    div [] [text "LOGIN APP"],
    div [] [text (toString model.appLoaded)]
  ]
