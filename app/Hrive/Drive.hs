-- | Module that provides functions for working with Drive data structures.
module Hrive.Drive (getListOfFiles, firstByTitle, findByTitle) where

import qualified Data.ByteString.Lazy.Char8 as B8L
import Data.Maybe
import Data.Aeson

import qualified Hrive.Data.Drive.File as DF
import qualified Hrive.Data.Drive.List as DL
import Hrive.SimpleRequests

type URL = String
type Token = String
type Title = String

-- | URL that returns all user files in JSON format.
listFilesURL = "https://www.googleapis.com/drive/v2/files"

-- | Get List of Drive files of the user. Takes access token.
getListOfFiles :: Token -> IO (Maybe DL.List)
getListOfFiles token = decode . B8L.pack <$> get (listFilesURL ++ "?access_token=" ++ token)

-- | Find files with given title.
findByTitle :: [DF.File] -> Title -> [DF.File]
findByTitle files title = filter (checkTitle title) files
  where
    checkTitle title file = do
      let titleM = DF.title file
      if isNothing titleM
        then False
        else if fromJust titleM == title
          then True else False

-- | Find first file with specified title.
firstByTitle :: [DF.File] -> Title -> Maybe DF.File
firstByTitle files title = do
  let list = findByTitle files title
  if null list
    then Nothing :: Maybe DF.File
    else Just (list !! 0)
