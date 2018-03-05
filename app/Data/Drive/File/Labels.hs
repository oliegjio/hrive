{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.Labels where
    
  import Data.Aeson

  data Labels = Labels
              { starred    :: Maybe Bool
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

