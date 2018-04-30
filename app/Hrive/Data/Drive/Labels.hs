{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.Labels where

import GHC.Generics
import Data.Aeson

data Labels = Labels
            { starred    :: Maybe Bool
            , hidden     :: Maybe Bool
            , trashed    :: Maybe Bool
            , restricted :: Maybe Bool
            , viewed     :: Maybe Bool
            } deriving (Show, Generic)

instance FromJSON Labels where
  parseJSON = withObject "Labels" $ \o ->
    Labels <$> o .:? "starred"
           <*> o .:? "hidden"
           <*> o .:? "trashed"
           <*> o .:? "restricted"
           <*> o .:? "viewed"

instance ToJSON Labels

