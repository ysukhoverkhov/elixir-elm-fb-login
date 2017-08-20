module Transitions exposing (loginToOffice)

{-| Transitions from one to another model state -}

import Model as App exposing (Model(..))
import Pages.Login.Model as Login exposing (Model)


loginToOffice : Login.Model -> App.Model
loginToOffice login =
  App.ModelOffice { userId = "VASIA" }
