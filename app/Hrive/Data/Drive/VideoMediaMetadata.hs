{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.VideoMediaMetadata where

import GHC.Generics
import Data.Aeson

data VideoMediaMetadata = VideoMediaMetadata
                        { width          :: Maybe Int
                        , height         :: Maybe Int
                        , durationMillis :: Maybe Int
                        } deriving (Show, Generic)

instance FromJSON VideoMediaMetadata where
  parseJSON = withObject "VideoMediaMetadata" $ \o ->
      VideoMediaMetadata <$> o .:? "width"
                         <*> o .:? "height"
                         <*> o .:? "durationMillis"

instance ToJSON VideoMediaMetadata
