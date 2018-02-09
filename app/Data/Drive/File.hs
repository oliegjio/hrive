{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File (File (..)) where
  
  import Data.Aeson (FromJSON (..), withObject, (.:?))
  import Data.HashMap.Lazy (HashMap (..))
    
  import qualified Data.Drive.File.Labels             as DFL
  import qualified Data.Drive.File.IndexableText      as DFIT
  import qualified Data.Drive.File.Permission         as Pe
  import qualified Data.Drive.File.Parent             as DFP
  import qualified Data.Drive.File.ImageMediaMetadata as IMM
  import qualified Data.Drive.File.Thumbnail          as Th
  import qualified Data.Drive.File.User               as Us
  import qualified Data.Drive.File.Properties         as Pr
  import qualified Data.Drive.File.VideoMediaMetadata as VMM
  import qualified Data.Drive.File.Capabilities       as Ca
  
  data File = File { kind                  :: Maybe String
                   , id                    :: Maybe String
                   , etag                  :: Maybe String
                   , selfLink              :: Maybe String
                   , title                 :: Maybe String
                   , mimeType              :: Maybe String
                   , description           :: Maybe String
                   , labels                :: Maybe DFL.Labels
                   , createdDate           :: Maybe String
                   , modifiedDate          :: Maybe String
                   , modifiedByMeDate      :: Maybe String
                   , downloadUrl           :: Maybe String
                   , indexableText         :: Maybe DFIT.IndexableText
                   , userPermission        :: Maybe Pe.Permission
                   , fileExtension         :: Maybe String
                   , md5Checksum           :: Maybe String
                   , fileSize              :: Maybe Int
                   , alternateLink         :: Maybe String
                   , embedLink             :: Maybe String
                   , sharedWithMeDate      :: Maybe String
                   , parents               :: Maybe [DFP.DriveFileParent]
                   , exportLinks           :: Maybe (HashMap String String)
                   , originalFilename      :: Maybe String
                   , quotaBytesUsed        :: Maybe Int
                   , ownerNames            :: Maybe [String]
                   , lastModifyingUserName :: Maybe String
                   , editable              :: Maybe Bool
                   , writersCanShare       :: Maybe Bool
                   , thumbnailLink         :: Maybe String
                   , lastViewedByMeDate    :: Maybe String
                   , webContentLink        :: Maybe String
                   , explicitlyTrashed     :: Maybe Bool
                   , imageMediaMetadata    :: Maybe IMM.ImageMediaMetadata
                   , thumbnail             :: Maybe Th.Thumbnail
                   , webViewLink           :: Maybe String
                   , iconLink              :: Maybe String
                   , shared                :: Maybe Bool
                   , owners                :: Maybe [Us.User]
                   , lastModifyingUser     :: Maybe Us.User
                   , appDataContents       :: Maybe Bool
                   , openWithLinks         :: Maybe (HashMap String String)
                   , defaultOpenWithLink   :: Maybe String
                   , headRevisionId        :: Maybe String
                   , copyable              :: Maybe Bool
                   , properties            :: Maybe [Pr.Property]
                   , markedViewedByMeDate  :: Maybe String
                   , version               :: Maybe Int
                   , sharingUser           :: Maybe Us.User
                   , permissions           :: Maybe [Pe.Permission]
                   , videoMediaMetadata    :: Maybe VMM.VideoMediaMetadata
                   , folderColorRgb        :: Maybe String
                   , fullFileExtension     :: Maybe String
                   , ownedByMe             :: Maybe Bool
                   , canComment            :: Maybe Bool
                   , shareable             :: Maybe Bool
                   , spaces                :: Maybe [String]
                   , canReadRevisions      :: Maybe Bool
                   , isAppAuthorized       :: Maybe Bool
                   , hasThumbnail          :: Maybe Bool
                   , thumbnailVersion      :: Maybe Int
                   , hasAugmentedPermissions :: Maybe Bool
                   , teamDriveId             :: Maybe String
                   , capabilities            :: Maybe Ca.Capabilities
                   , trashingUser            :: Maybe Us.User
                   , trashedDate             :: Maybe String
                   , permissionIds           :: Maybe [String]
                   } deriving (Show)
  
  instance FromJSON File where
    parseJSON = withObject "File" $ \o ->
        File <$> o .:? "id"
             <*> o .:? "etag"
             <*> o .:? "downloadUrl"
             <*> o .:? "title"