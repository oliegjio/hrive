{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.Thumbnail where

import GHC.Generics
import Data.Aeson

data Thumbnail = Thumbnail
               { image    :: Maybe String
               , mimeType :: Maybe String
               } deriving (Show, Generic)

instance FromJSON Thumbnail where
  parseJSON = withObject "Thumbnail" $ \o ->
      Thumbnail <$> o .:? "image"
                <*> o .:? "mimeType"

instance ToJSON Thumbnail
