{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Hrive.Data.Drive.Parent where

import GHC.Generics
import Data.Aeson

data Parent = Parent
            { kind       :: Maybe String
            , id         :: Maybe String
            , selfLink   :: Maybe String
            , parentLink :: Maybe String
            , isRoot     :: Maybe Bool
            } deriving (Show, Generic)

instance FromJSON Parent where
  parseJSON = withObject "Parent" $ \o ->
      Parent <$> o .:? "kind"
             <*> o .:? "id"
             <*> o .:? "selfLink"
             <*> o .:? "parentLink"
             <*> o .:? "isRoot"

instance ToJSON Parent
