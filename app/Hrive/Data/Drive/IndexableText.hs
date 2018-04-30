{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.IndexableText where

import GHC.Generics
import Data.Aeson

data IndexableText = IndexableText
                   { text :: Maybe String
                   } deriving (Show, Generic)

instance FromJSON IndexableText where
  parseJSON = withObject "IndexableText" $ \o ->
      IndexableText <$> o .:? "text"

instance ToJSON IndexableText
