{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Data.DriveFile (DriveFile (..)) where
    
  import GHC.Generics
  import Data.Aeson (FromJSON (..), withObject, (.:))
  
  -- import qualified Data.DriveFileUserPermission as DFUP
  -- import qualified Data.DriveFileLabels         as DFL
  -- import qualified Data.DriveFileParent         as DFP
  -- import qualified Data.DriveFileUser           as DFU
  -- import qualified Data.DriveFileCapabilities   as DFC
  
  data DriveFile = DriveFile { id                    :: String
                             , etag                  :: String
                             } deriving (Generic, Show)
  
  instance FromJSON DriveFile where
    parseJSON = withObject "DriveFile" $ \o ->
        DriveFile <$> o .: "id"
                  <*> o .: "etag"