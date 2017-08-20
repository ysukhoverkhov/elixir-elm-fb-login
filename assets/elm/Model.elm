module Model exposing (Model(..))

{-| Model type for all the pages of our SPA -}

import Pages.Login.Model as Login exposing (Model)


-- TODO: move me to App Page.
type alias AppModel =
  { userId : String
  }


type Model
  = ModelLogin Login.Model
  | ModelApp AppModel
