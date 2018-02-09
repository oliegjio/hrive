{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.Labels (Labels (..)) where
    
  import Data.Aeson (FromJSON (..), withObject, (.:?))

  data Labels = Labels { starred    :: Maybe Bool
                       , hidden     :: Maybe Bool
                       , trashed    :: Maybe Bool
                       , restricted :: Maybe Bool
                       , viewed     :: Maybe Bool
                       } deriving (Show)
  
  instance FromJSON Labels where
    parseJSON = withObject "Labels" $ \o ->
      Labels <$> o .:? "starred"
             <*> o .:? "hidden"
             <*> o .:? "trashed"
             <*> o .:? "restricted"
             <*> o .:? "viewed"

