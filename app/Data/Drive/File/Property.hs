{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.Property (Property (..)) where
    
  import Data.Aeson (FromJSON (..), withObject, (.:?))
  
  data Property = Property { kind       :: Maybe String
                           , etag       :: Maybe String
                           , selfLink   :: Maybe String
                           , key        :: Maybe String
                           , visibility :: Maybe String
                           , value      :: Maybe String
                           } deriving (Show)
  
  instance FromJSON Property where
    parseJSON = withObject "Property" $ \o ->
        Property <$> o .:? "kind"
                 <*> o .:? "etag"
                 <*> o .:? "selfLink"
                 <*> o .:? "key"
                 <*> o .:? "visibility"
                 <*> o .:? "value"