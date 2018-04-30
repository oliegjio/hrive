{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.Picture where

import GHC.Generics
import Data.Aeson

data Picture = Picture
             { url :: Maybe String
             } deriving (Show, Generic)

instance FromJSON Picture where
  parseJSON = withObject "Picture" $ \o ->
      Picture <$> o .:? "url"

instance ToJSON Picture
