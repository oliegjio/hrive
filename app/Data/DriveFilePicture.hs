{-# LANGUAGE DeriveGeneric #-}

module Data.DriveFilePicture (DriveFilePicture (..)) where
    
  import GHC.Generics
  import Data.Aeson (FromJSON (..))
  
  data DriveFilePicture = DriveFilePicture { url :: String } deriving (Generic, Show)
  
  instance FromJSON DriveFilePicture where