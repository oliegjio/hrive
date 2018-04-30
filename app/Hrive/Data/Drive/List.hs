{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.List where

import GHC.Generics
import Data.Aeson

import qualified Hrive.Data.Drive.File as DF

data List = List
          { kind             :: Maybe String
          , etag             :: Maybe String
          , selfLink         :: Maybe String
          , nextPageToken    :: Maybe String
          , nextLink         :: Maybe String
          , incompleteSearch :: Maybe Bool
          , items            :: Maybe [DF.File]
          } deriving (Generic, Show)

instance FromJSON List where
  parseJSON = withObject "List" $ \o ->
    List <$> o .:? "kind"
         <*> o .:? "etag"
         <*> o .:? "selfLink"
         <*> o .:? "nextPageToken"
         <*> o .:? "nextLink"
         <*> o .:? "incompleteSearch"
         <*> o .:? "items"

instance ToJSON List
