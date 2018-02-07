{-# LANGUAGE OverloadedStrings #-}

module Data.DriveFileUserPermission (DriveFileUserPermission (..)) where
    
  import Data.Aeson ( FromJSON (..)
                    , withObject
                    , (.:)
                    )
  
  data DriveFileUserPermission = DriveFileUserPermission { kind     :: String
                                                         , etag     :: String
                                                         , id       :: String
                                                         , selfLink :: String
                                                         , role     :: String
                                                         , fileType :: String
                                                         } deriving (Show)
  
  instance FromJSON DriveFileUserPermission where
    parseJSON = withObject "DriveFileUserPermission" $ \o -> DriveFileUserPermission
      <$> o .: "kind"
      <*> o .: "etag"
      <*> o .: "id"
      <*> o .: "selfLink"
      <*> o .: "role"
      <*> o .: "type"