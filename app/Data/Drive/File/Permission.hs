{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.Permission (Permission (..)) where
    
  import Data.Aeson (FromJSON (..), withObject, (.:?))
  
  import Data.Drive.File.PermissionDetails as DFPD
  
  data Permission = Permission { kind                       :: Maybe String
                               , etag                       :: Maybe String
                               , id                         :: Maybe String
                               , selfLink                   :: Maybe String
                               , name                       :: Maybe String
                               , role                       :: Maybe String
                               , additionalRoles            :: Maybe [String]
                               , type_                      :: Maybe String
                               , authKey                    :: Maybe String
                               , withLink                   :: Maybe Bool
                               , photoLink                  :: Maybe String
                               , value                      :: Maybe String
                               , emailAddress               :: Maybe String
                               , domain                     :: Maybe String
                               , expirationDate             :: Maybe String
                               , teamDrivePermissionDetails :: Maybe [DFPD.PermissionDetails]
                               , deleted                    :: Maybe Bool
                               } deriving (Show)
  
  instance FromJSON Permission where
    parseJSON = withObject "Permission" $ \o ->
      Permission <$> o .:? "kind"
                 <*> o .:? "etag"
                 <*> o .:? "id"
                 <*> o .:? "selfLink"
                 <*> o .:? "name"
                 <*> o .:? "role"
                 <*> o .:? "additionalRoles"
                 <*> o .:? "type"
                 <*> o .:? "authKey"
                 <*> o .:? "withLink"
                 <*> o .:? "photoLink"
                 <*> o .:? "value"
                 <*> o .:? "emailAddress"
                 <*> o .:? "domain"
                 <*> o .:? "expirationDate"
                 <*> o .:? "teamDrivePermissionDetails"
                 <*> o .:? "deleted"