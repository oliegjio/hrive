{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File (File (..)) where
  
  import Data.Aeson (FromJSON (..), withObject, (.:?))
  import Data.HashMap.Lazy as HML
    
  import qualified Data.Drive.File.Labels             as DFL
  import qualified Data.Drive.File.IndexableText      as DFIT
  import qualified Data.Drive.File.Permission         as DFPe
  import qualified Data.Drive.File.Parent             as DFPa
  import qualified Data.Drive.File.ImageMediaMetadata as DFIMM
  import qualified Data.Drive.File.Thumbnail          as DFT
  import qualified Data.Drive.File.User               as DFU
  import qualified Data.Drive.File.Property           as DFPr
  import qualified Data.Drive.File.VideoMediaMetadata as DFVMM
  import qualified Data.Drive.File.Capabilities       as DFC
  
  data File = File
            { kind                    :: Maybe String
            , id                      :: Maybe String
            , etag                    :: Maybe String
            , selfLink                :: Maybe String
            , title                   :: Maybe String
            , mimeType                :: Maybe String
            , description             :: Maybe String
            , labels                  :: Maybe DFL.Labels
            , createdDate             :: Maybe String
            , modifiedDate            :: Maybe String
            , modifiedByMeDate        :: Maybe String
            , downloadUrl             :: Maybe String
            , indexableText           :: Maybe DFIT.IndexableText
            , userPermission          :: Maybe DFPe.Permission
            , fileExtension           :: Maybe String
            , md5Checksum             :: Maybe String
            , fileSize                :: Maybe String
            , alternateLink           :: Maybe String
            , embedLink               :: Maybe String
            , sharedWithMeDate        :: Maybe String
            , parents                 :: Maybe [DFPa.Parent]
            , exportLinks             :: Maybe (HML.HashMap String String)
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
            , imageMediaMetadata      :: Maybe DFIMM.ImageMediaMetadata
            , thumbnail               :: Maybe DFT.Thumbnail
            , webViewLink             :: Maybe String
            , iconLink                :: Maybe String
            , shared                  :: Maybe Bool
            , owners                  :: Maybe [DFU.User]
            , lastModifyingUser       :: Maybe DFU.User
            , appDataContents         :: Maybe Bool
            , openWithLinks           :: Maybe (HML.HashMap String String)
            , defaultOpenWithLink     :: Maybe String
            , headRevisionId          :: Maybe String
            , copyable                :: Maybe Bool
            , properties              :: Maybe [DFPr.Property]
            , markedViewedByMeDate    :: Maybe String
            , version                 :: Maybe String
            , sharingUser             :: Maybe DFU.User
            , permissions             :: Maybe [DFPe.Permission]
            , videoMediaMetadata      :: Maybe DFVMM.VideoMediaMetadata
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
            , capabilities            :: Maybe DFC.Capabilities
            , trashingUser            :: Maybe DFU.User
            , trashedDate             :: Maybe String
            , permissionIds           :: Maybe [String]
            } deriving (Show)
  
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