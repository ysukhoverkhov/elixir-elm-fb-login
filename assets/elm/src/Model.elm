module Model exposing (Model(..))

{-| Model type for all the pages of our SPA -}

import Pages.Login.Model as Login exposing (Model)
import Pages.Office.Model as Office exposing (Model)


type Model
  = ModelLogin Login.Model
  | ModelOffice Office.Model
