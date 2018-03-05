{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.IndexableText where
    
  import Data.Aeson
  
  data IndexableText = IndexableText
                     { text :: Maybe String
                     } deriving (Show)
  
  instance FromJSON IndexableText where
    parseJSON = withObject "IndexableText" $ \o ->
        IndexableText <$> o .:? "text"