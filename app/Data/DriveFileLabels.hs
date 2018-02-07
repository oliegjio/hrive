{-# LANGUAGE DeriveGeneric #-}

module Data.DriveFileLabels (DriveFileLabels (..)) where
    
  import GHC.Generics
  import Data.Aeson (FromJSON (..))

  data DriveFileLabels = DriveFileLabels { starred    :: Bool
                                         , hidden     :: Bool
                                         , trashed    :: Bool
                                         , restricted :: Bool
                                         , viewed     :: Bool
                                         } deriving (Generic, Show)
  
  instance FromJSON DriveFileLabels where

