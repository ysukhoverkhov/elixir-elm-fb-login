port module Ports exposing (..)

{-|

@docs initFb
@docs appLoaded
@docs fbInitialized
-}


{-| Triggered when all scripts in JS app are loaded
-}
port appLoaded : (() -> msg) -> Sub msg

{-| Triggered when Facebook initialized
-}
port fbInitialized : (() -> msg) -> Sub msg

{-| Triggered when Facebook knows our login status
-}
port fbLoginStatus : (String -> msg) -> Sub msg


{-| Initializes FB with provided App information
-}
port fbInit : { appId : String, sdkVersion : String } -> Cmd msg

{-| Asks FB about status of login
-}
port fbCheckLoginStatus : () -> Cmd msg

{-| Asks FB to logout current user
-}
port fbLogout : () -> Cmd msg

{-| Asks FB to login current user
-}
port fbLogin : () -> Cmd msg
