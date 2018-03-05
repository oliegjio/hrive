{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.Thumbnail where
    
  import Data.Aeson
  
  data Thumbnail = Thumbnail
                 { image    :: Maybe String
                 , mimeType :: Maybe String
                 } deriving (Show)
  
  instance FromJSON Thumbnail where
    parseJSON = withObject "Thumbnail" $ \o ->
        Thumbnail <$> o .:? "image"
                  <*> o .:? "mimeType"