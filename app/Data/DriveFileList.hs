{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}  

module Data.DriveFileList (DriveFileList (..)) where
    
  import GHC.Generics
  import Data.Aeson (FromJSON (..), withObject, (.:), (.:?))
  
  import qualified Data.DriveFile as DF
  
  data DriveFileList = DriveFileList { etag             :: String
                                     , items            :: [DF.DriveFile]
                                     } deriving (Generic, Show)
           
  instance FromJSON DriveFileList where
    parseJSON = withObject "DriveFileList" $ \o ->
      DriveFileList <$> o .:  "etag"
                    <*> o .:  "items"