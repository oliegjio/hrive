{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.VideoMediaMetadata where
    
  import Data.Aeson
  
  data VideoMediaMetadata = VideoMediaMetadata
                          { width          :: Maybe Int
                          , height         :: Maybe Int
                          , durationMillis :: Maybe Int
                          } deriving (Show)
  
  instance FromJSON VideoMediaMetadata where
    parseJSON = withObject "VideoMediaMetadata" $ \o ->
        VideoMediaMetadata <$> o .:? "width"
                           <*> o .:? "height"
                           <*> o .:? "durationMillis"