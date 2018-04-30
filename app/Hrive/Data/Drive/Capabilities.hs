{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.Capabilities where

import GHC.Generics
import Data.Aeson

data Capabilities = Capabilities
                  { canAddChildren              :: Maybe Bool
                  , canChangeRestrictedDownload :: Maybe Bool
                  , canComment                  :: Maybe Bool
                  , canCopy                     :: Maybe Bool
                  , canDelete                   :: Maybe Bool
                  , canDownload                 :: Maybe Bool
                  , canEdit                     :: Maybe Bool
                  , canListChildren             :: Maybe Bool
                  , canMoveItemIntoTeamDrive    :: Maybe Bool
                  , canMoveTeamDriveItem        :: Maybe Bool
                  , canReadRevisions            :: Maybe Bool
                  , canReadTeamDrive            :: Maybe Bool
                  , canRemoveChildren           :: Maybe Bool
                  , canRename                   :: Maybe Bool
                  , canShare                    :: Maybe Bool
                  , canTrash                    :: Maybe Bool
                  , canUntrash                  :: Maybe Bool
                  } deriving (Show, Generic)

instance FromJSON Capabilities where
  parseJSON = withObject "Capabilities" $ \o ->
      Capabilities <$> o .:? "canAddChildren"
                   <*> o .:? "canChangeRestrictedDownload"
                   <*> o .:? "canComment"
                   <*> o .:? "canCopy"
                   <*> o .:? "canDelete"
                   <*> o .:? "canDownload"
                   <*> o .:? "canEdit"
                   <*> o .:? "canListChildren"
                   <*> o .:? "canMoveItemIntoTeamDrive"
                   <*> o .:? "canMoveTeamDriveItem"
                   <*> o .:? "canReadRevisions"
                   <*> o .:? "canReadTeamDrive"
                   <*> o .:? "canRemoveChildren"
                   <*> o .:? "canRename"
                   <*> o .:? "canShare"
                   <*> o .:? "canTrash"
                   <*> o .:? "canUntrash"

instance ToJSON Capabilities
