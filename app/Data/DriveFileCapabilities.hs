{-# LANGUAGE DeriveGeneric #-}

module Data.DriveFileCapabilities (DriveFileCapabilities (..)) where
    
  import GHC.Generics
  import Data.Aeson (FromJSON (..))
  
  data DriveFileCapabilities = DriveFileCapabilities { canCopy :: Bool
                                                     , canEdit :: Bool
                                                     } deriving (Generic, Show)
  
  instance FromJSON DriveFileCapabilities where