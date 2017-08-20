module Transitions exposing (loginToOffice, officeToLogin)

{-| Transitions from one to another model state -}

import Model as App exposing (Model(..))
import Pages.Login.Model as Login exposing (Model)
import Pages.Office.Model as Office exposing (Model)


loginToOffice : Login.Model -> App.Model
loginToOffice login =
  App.ModelOffice { state = Office.Working, userId = "VASIA" }

officeToLogin : Office.Model -> App.Model
officeToLogin login =
  App.ModelLogin { state = Login.WaitingForLogin }
