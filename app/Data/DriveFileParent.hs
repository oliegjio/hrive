{-# LANGUAGE DeriveGeneric #-}

module Data.DriveFileParent (DriveFileParent (..)) where
    
  import GHC.Generics
  import Data.Aeson (FromJSON (..))
  
  data DriveFileParent = DriveFileParent { kind       :: String
                                         , id         :: String
                                         , selfLink   :: String
                                         , parentLink :: String
                                         , isRoot     :: Bool
                                         } deriving (Generic, Show)
  
  instance FromJSON DriveFileParent where