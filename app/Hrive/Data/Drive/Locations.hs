{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.Locations where

import GHC.Generics
import Data.Aeson

data Locations = Locations
               { latitude  :: Maybe Double
               , longitude :: Maybe Double
               , altitude  :: Maybe Double
               } deriving (Show, Generic)

instance FromJSON Locations where
  parseJSON = withObject "Locations" $ \o ->
      Locations <$> o .:? "latitude"
                <*> o .:? "longitude"
                <*> o .:? "altitude"

instance ToJSON Locations
