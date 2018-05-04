{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.ByteString.Lazy.Char8 as B8L
import Data.Aeson.Encode.Pretty
import Control.Monad
import Data.Aeson
import Data.Maybe

import Hrive.Drive
import Hrive.Auth
import Hrive.Utils

-- | Hrive application ID in the Google API.
clientID = "900337392594-avkns0t5472ef49johhhaor06p8qvn27.apps.googleusercontent.com"

-- | Secret key to authenticate Hrive application.
clientSecret = "UQL0tyK4MvTDlj2ZzCDIMhfR"

main :: IO ()
main = do
  tokenM <- authenticate clientID clientSecret
  when (isNothing tokenM) $ suicide "Authentication error"
  let token = fromJust tokenM
  filesListM <- getListOfFiles token
  when (isNothing filesListM) $ suicide "Filed to fetch list of files"
  let filesList = fromJust filesListM
  B8L.writeFile "files-list.json" . encodePretty $ filesListM
  downloadAllFiles token "./test-download/" filesList
  return ()
