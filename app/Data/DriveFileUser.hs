{-# LANGUAGE DeriveGeneric #-}

module Data.DriveFileUser (DriveFileUser (..)) where
    
  import GHC.Generics
  import Data.Aeson (FromJSON (..))
  
  import qualified Data.DriveFilePicture as DFP
  
  data DriveFileUser = DriveFileUser { kind                :: String
                                     , displayName         :: String
                                     , picture             :: DFP.DriveFilePicture
                                     , isAuthenticatedUser :: Bool
                                     , permissionId        :: Int
                                     , emailAddress        :: String
                                     } deriving (Generic, Show)
  
  instance FromJSON DriveFileUser where