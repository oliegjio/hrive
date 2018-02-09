{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.IndexableText (IndexableText (..)) where
    
  import Data.Aeson (FromJSON (..), withObject, (.:?))
  
  data IndexableText = IndexableText { text :: Maybe String } deriving (Show)
  
  instance FromJSON IndexableText where
    parseJSON = withObject "IndexableText" $ \o ->
        IndexableText <$> o .:? "text"