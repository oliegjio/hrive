{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.ImageMediaMetadata where

import GHC.Generics
import Data.Aeson

import Hrive.Data.Drive.Locations

data ImageMediaMetadata = ImageMediaMetadata
                        { width            :: Maybe Int
                        , height           :: Maybe Int
                        , rotation         :: Maybe Int
                        , locations        :: Maybe Locations
                        , date             :: Maybe String
                        , cameraMake       :: Maybe String
                        , cameraModel      :: Maybe String
                        , exposureTime     :: Maybe Float
                        , aperture         :: Maybe Float 
                        , flashUsed        :: Maybe Bool
                        , focalLength      :: Maybe Float
                        , isoSpeed         :: Maybe Int
                        , meteringMode     :: Maybe String
                        , sensor           :: Maybe String
                        , exposureMode     :: Maybe String
                        , colorSpace       :: Maybe String
                        , whiteBalance     :: Maybe String
                        , exposureBias     :: Maybe Float
                        , maxApertureValue :: Maybe Float
                        , subjectDistance  :: Maybe Int
                        , lens             :: Maybe String
                        } deriving (Show, Generic)

instance FromJSON ImageMediaMetadata where
  parseJSON = withObject "ImageMediaMetadata" $ \o ->
      ImageMediaMetadata <$> o .:? "width"
                         <*> o .:? "height"
                         <*> o .:? "rotation"
                         <*> o .:? "locations"
                         <*> o .:? "date"
                         <*> o .:? "cameraMake"
                         <*> o .:? "cameraModel"
                         <*> o .:? "exposureTime"
                         <*> o .:? "aperture"
                         <*> o .:? "flashUsed"
                         <*> o .:? "focalLength"
                         <*> o .:? "isoSpeed"
                         <*> o .:? "meteringMode"
                         <*> o .:? "sensor"
                         <*> o .:? "exposureMode"
                         <*> o .:? "colorSpace"
                         <*> o .:? "whiteBalance"
                         <*> o .:? "exposureBias"
                         <*> o .:? "maxApertureValue"
                         <*> o .:? "subjectDistance"
                         <*> o .:? "lens"

instance ToJSON ImageMediaMetadata
