{-# LANGUAGE OverloadedStrings #-}

module Data.Drive.File.Parent where
  
  import Data.Aeson
  
  data Parent = Parent
              { kind       :: Maybe String
              , id         :: Maybe String
              , selfLink   :: Maybe String
              , parentLink :: Maybe String
              , isRoot     :: Maybe Bool
              } deriving (Show)
  
  instance FromJSON Parent where
    parseJSON = withObject "Parent" $ \o ->
        Parent <$> o .:? "kind"
               <*> o .:? "id"
               <*> o .:? "selfLink"
               <*> o .:? "parentLink"
               <*> o .:? "isRoot"