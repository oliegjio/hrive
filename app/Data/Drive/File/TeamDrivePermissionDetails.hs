{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.TeamDrivePermissionDetails (TeamDrivePermissionDetails (..)) where
    
  import Data.Aeson (FromJSON (..), withObject, (.:?))
  
  data TeamDrivePermissionDetails = TeamDrivePermissionDetails
                                  { teamDrivePermissionType :: Maybe String
                                  , role                    :: Maybe String
                                  , additionalRoles         :: Maybe [String]
                                  , inheritedFrom           :: Maybe String
                                  , inherited               :: Maybe Bool
                                  } deriving (Show)
  
  instance FromJSON TeamDrivePermissionDetails where
    parseJSON = withObject "TeamDrivePermissionDetails" $ \o ->
        TeamDrivePermissionDetails <$> o .:? "teamDrivePermissionType"
                                   <*> o .:? "role"
                                   <*> o .:? "additionalRoles"
                                   <*> o .:? "inheritedFrom"
                                   <*> o .:? "inherited"