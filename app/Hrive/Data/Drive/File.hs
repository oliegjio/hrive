{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.File where

import GHC.Generics
import Data.Aeson
import Data.HashMap.Lazy

import Hrive.Data.Drive.Labels
import Hrive.Data.Drive.IndexableText
import Hrive.Data.Drive.Permission
import Hrive.Data.Drive.Parent
import Hrive.Data.Drive.ImageMediaMetadata
import Hrive.Data.Drive.Thumbnail
import Hrive.Data.Drive.User
import Hrive.Data.Drive.Property
import Hrive.Data.Drive.VideoMediaMetadata
import Hrive.Data.Drive.Capabilities

data File = File
          { kind                    :: Maybe String
          , id                      :: Maybe String
          , etag                    :: Maybe String
          , selfLink                :: Maybe String
          , title                   :: Maybe String
          , mimeType                :: Maybe String
          , description             :: Maybe String
          , labels                  :: Maybe Labels
          , createdDate             :: Maybe String
          , modifiedDate            :: Maybe String
          , modifiedByMeDate        :: Maybe String
          , downloadUrl             :: Maybe String
          , indexableText           :: Maybe IndexableText
          , userPermission          :: Maybe Permission
          , fileExtension           :: Maybe String
          , md5Checksum             :: Maybe String
          , fileSize                :: Maybe String
          , alternateLink           :: Maybe String
          , embedLink               :: Maybe String
          , sharedWithMeDate        :: Maybe String
          , parents                 :: Maybe [Parent]
          , exportLinks             :: Maybe (HashMap String String)
          , originalFilename        :: Maybe String
          , quotaBytesUsed          :: Maybe String
          , ownerNames              :: Maybe [String]
          , lastModifyingUserName   :: Maybe String
          , editable                :: Maybe Bool
          , writersCanShare         :: Maybe Bool
          , thumbnailLink           :: Maybe String
          , lastViewedByMeDate      :: Maybe String
          , webContentLink          :: Maybe String
          , explicitlyTrashed       :: Maybe Bool
          , imageMediaMetadata      :: Maybe ImageMediaMetadata
          , thumbnail               :: Maybe Thumbnail
          , webViewLink             :: Maybe String
          , iconLink                :: Maybe String
          , shared                  :: Maybe Bool
          , owners                  :: Maybe [User]
          , lastModifyingUser       :: Maybe User
          , appDataContents         :: Maybe Bool
          , openWithLinks           :: Maybe (HashMap String String)
          , defaultOpenWithLink     :: Maybe String
          , headRevisionId          :: Maybe String
          , copyable                :: Maybe Bool
          , properties              :: Maybe [Property]
          , markedViewedByMeDate    :: Maybe String
          , version                 :: Maybe String
          , sharingUser             :: Maybe User
          , permissions             :: Maybe [Permission]
          , videoMediaMetadata      :: Maybe VideoMediaMetadata
          , folderColorRgb          :: Maybe String
          , fullFileExtension       :: Maybe String
          , ownedByMe               :: Maybe Bool
          , canComment              :: Maybe Bool
          , shareable               :: Maybe Bool
          , spaces                  :: Maybe [String]
          , canReadRevisions        :: Maybe Bool
          , isAppAuthorized         :: Maybe Bool
          , hasThumbnail            :: Maybe Bool
          , thumbnailVersion        :: Maybe String
          , hasAugmentedPermissions :: Maybe Bool
          , teamDriveId             :: Maybe String
          , capabilities            :: Maybe Capabilities
          , trashingUser            :: Maybe User
          , trashedDate             :: Maybe String
          , permissionIds           :: Maybe [String]
          } deriving (Show, Generic)

instance FromJSON File where
  parseJSON = withObject "File" $ \o ->
      File <$> o .:? "kind"
           <*> o .:? "id"
           <*> o .:? "etag"
           <*> o .:? "selfLink"
           <*> o .:? "title"
           <*> o .:? "mimeType"
           <*> o .:? "description"
           <*> o .:? "labels"
           <*> o .:? "createdDate"
           <*> o .:? "modifiedDate"
           <*> o .:? "modifiedByMeDate"
           <*> o .:? "downloadUrl"
           <*> o .:? "indexableText"
           <*> o .:? "userPermission"
           <*> o .:? "fileExtension"
           <*> o .:? "md5Checksum"
           <*> o .:? "fileSize"
           <*> o .:? "alternateLink"
           <*> o .:? "embedLink"
           <*> o .:? "sharedWithMeDate"
           <*> o .:? "parents"
           <*> o .:? "exportLinks"
           <*> o .:? "originalFilename"
           <*> o .:? "quotaBytesUsed"
           <*> o .:? "ownerNames"
           <*> o .:? "lastModifyingUserName"
           <*> o .:? "editable"
           <*> o .:? "writersCanShare"
           <*> o .:? "thumbnailLink"
           <*> o .:? "lastViewedByMeDate"
           <*> o .:? "webContentLink"
           <*> o .:? "explicitlyTrashed"
           <*> o .:? "imageMediaMetadata"
           <*> o .:? "thumbnail"
           <*> o .:? "webViewLink"
           <*> o .:? "iconLink"
           <*> o .:? "shared"
           <*> o .:? "owners"
           <*> o .:? "lastModifyingUser"
           <*> o .:? "appDataContents"
           <*> o .:? "openWithLinks"
           <*> o .:? "defaultOpenWithLink"
           <*> o .:? "headRevisionId"
           <*> o .:? "copyable"
           <*> o .:? "properties"
           <*> o .:? "markedViewedByMeDate"
           <*> o .:? "version"
           <*> o .:? "sharingUser"
           <*> o .:? "permissions"
           <*> o .:? "videoMediaMetadata"
           <*> o .:? "folderColorRgb"
           <*> o .:? "fullFileExtension"
           <*> o .:? "ownedByMe"
           <*> o .:? "canComment"
           <*> o .:? "shareable"
           <*> o .:? "spaces"
           <*> o .:? "canReadRevisions"
           <*> o .:? "isAppAuthorized"
           <*> o .:? "hasThumbnail"
           <*> o .:? "thumbnailVersion"
           <*> o .:? "hasAugmentedPermissions"
           <*> o .:? "teamDriveId"
           <*> o .:? "capabilities"
           <*> o .:? "trashingUser"
           <*> o .:? "trashedDate"
           <*> o .:? "permissionIds"

instance ToJSON File
