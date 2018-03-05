{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.User where
  
  import Data.Aeson
  
  import Data.Drive.File.Picture
  
  data User = User
            { kind                :: Maybe String
            , displayName         :: Maybe String
            , picture             :: Maybe Picture
            , isAuthenticatedUser :: Maybe Bool
            , permissionId        :: Maybe String
            , emailAddress        :: Maybe String
            } deriving (Show)
  
  instance FromJSON User where
    parseJSON = withObject "User" $ \o ->
        User <$> o .:? "kind"
             <*> o .:? "displayName"
             <*> o .:? "picture"
             <*> o .:? "isAuthenticatedUser"
             <*> o .:? "permissionId"
             <*> o .:? "emailAddress"