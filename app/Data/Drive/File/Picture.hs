{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.Picture where
    
  import Data.Aeson
  
  data Picture = Picture
               { url :: Maybe String
               } deriving (Show)
  
  instance FromJSON Picture where
    parseJSON = withObject "Picture" $ \o ->
        Picture <$> o .:? "url"