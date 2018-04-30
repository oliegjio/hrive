{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.Property where

import GHC.Generics
import Data.Aeson

data Property = Property
              { kind       :: Maybe String
              , etag       :: Maybe String
              , selfLink   :: Maybe String
              , key        :: Maybe String
              , visibility :: Maybe String
              , value      :: Maybe String
              } deriving (Show, Generic)

instance FromJSON Property where
  parseJSON = withObject "Property" $ \o ->
      Property <$> o .:? "kind"
               <*> o .:? "etag"
               <*> o .:? "selfLink"
               <*> o .:? "key"
               <*> o .:? "visibility"
               <*> o .:? "value"

instance ToJSON Property
