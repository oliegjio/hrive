{-# LANGUAGE OverloadedStrings #-}  

module Data.Drive.List where
    
  import Data.Aeson
  
  import qualified Data.Drive.File as DF
  
  data List = List
            { kind             :: Maybe String
            , etag             :: Maybe String
            , selfLink         :: Maybe String
            , nextPageToken    :: Maybe String
            , nextLink         :: Maybe String
            , incompleteSearch :: Maybe Bool
            , items            :: Maybe [DF.File]
            } deriving (Show)
           
  instance FromJSON List where
    parseJSON = withObject "List" $ \o ->
      List <$> o .:? "kind"
           <*> o .:? "etag"
           <*> o .:? "selfLink"
           <*> o .:? "nextPageToken"
           <*> o .:? "nextLink"
           <*> o .:? "incompleteSearch"
           <*> o .:? "items"