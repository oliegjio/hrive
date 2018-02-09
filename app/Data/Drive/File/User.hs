{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.User (User (..)) where
  
  import Data.Aeson (FromJSON (..), withObject, (.:?))
  
  import qualified Data.Drive.File.Picture as DFP
  
  data User = User { kind                :: Maybe String
                   , displayName         :: Maybe String
                   , picture             :: Maybe DFP.Picture
                   , isAuthenticatedUser :: Maybe Bool
                   , permissionId        :: Maybe Int
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