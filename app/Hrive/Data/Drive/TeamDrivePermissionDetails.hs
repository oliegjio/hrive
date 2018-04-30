{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.TeamDrivePermissionDetails where

import GHC.Generics
import Data.Aeson

data TeamDrivePermissionDetails = TeamDrivePermissionDetails
                                { teamDrivePermissionType :: Maybe String
                                , role                    :: Maybe String
                                , additionalRoles         :: Maybe [String]
                                , inheritedFrom           :: Maybe String
                                , inherited               :: Maybe Bool
                                } deriving (Show, Generic)

instance FromJSON TeamDrivePermissionDetails where
  parseJSON = withObject "TeamDrivePermissionDetails" $ \o ->
      TeamDrivePermissionDetails <$> o .:? "teamDrivePermissionType"
                                 <*> o .:? "role"
                                 <*> o .:? "additionalRoles"
                                 <*> o .:? "inheritedFrom"
                                 <*> o .:? "inherited"

instance ToJSON TeamDrivePermissionDetails
