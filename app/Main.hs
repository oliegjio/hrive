{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.ByteString.Lazy.Char8 as B8L
import Data.Aeson

import Hrive.Drive
import Hrive.Auth

-- | Hrive application ID in the Google API.
clientID = "900337392594-avkns0t5472ef49johhhaor06p8qvn27.apps.googleusercontent.com"

-- | Secret key to authenticate Hrive application.
clientSecret = "UQL0tyK4MvTDlj2ZzCDIMhfR"

main :: IO ()
main = do
  token <- auth clientID clientSecret
  getListOfFiles token >>= B8L.writeFile "files-list.json" <$> encode
  return ()
