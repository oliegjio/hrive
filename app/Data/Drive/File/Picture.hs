{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.Picture (Picture (..)) where
    
  import Data.Aeson (FromJSON (..), withObject, (.:?))
  
  data Picture = Picture { url :: Maybe String } deriving (Show)
  
  instance FromJSON Picture where
    parseJSON = withObject "Picture" $ \o ->
        Picture <$> o .:? "url"