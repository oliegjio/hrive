{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.Locations (Locations (..)) where
    
  import Data.Aeson (FromJSON (..), withObject, (.:?))
  
  data Locations = Locations { latitude  :: Maybe Double
                             , longitude :: Maybe Double
                             , altitude  :: Maybe Double
                             } deriving (Show)
  
  instance FromJSON Locations where
    parseJSON = withObject "Locations" $ \o ->
        Locations <$> o .:? "latitude"
                  <*> o .:? "longitude"
                  <*> o .:? "altitude"