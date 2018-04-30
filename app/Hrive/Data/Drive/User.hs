{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.User where

import GHC.Generics
import Data.Aeson

import Hrive.Data.Drive.Picture

data User = User
          { kind                :: Maybe String
          , displayName         :: Maybe String
          , picture             :: Maybe Picture
          , isAuthenticatedUser :: Maybe Bool
          , permissionId        :: Maybe String
          , emailAddress        :: Maybe String
          } deriving (Show, Generic)

instance FromJSON User where
  parseJSON = withObject "User" $ \o ->
      User <$> o .:? "kind"
           <*> o .:? "displayName"
           <*> o .:? "picture"
           <*> o .:? "isAuthenticatedUser"
           <*> o .:? "permissionId"
           <*> o .:? "emailAddress"

instance ToJSON User
