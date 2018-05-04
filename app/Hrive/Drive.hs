-- | Module that provides functions for working with Drive data structures.
module Hrive.Drive (
  getListOfFiles,
  firstByTitle,
  findByTitle,
  downloadAllFiles,
  downloadFile
) where

import qualified Data.ByteString.Char8 as BS
import System.Directory
import Data.Maybe
import Data.Aeson

import qualified Hrive.Data.Drive.File as DF
import qualified Hrive.Data.Drive.List as DL
import Hrive.SimpleRequests

type URL = String
type Token = String
type Title = String
type Path = String

-- | URL that returns all user files in JSON format.
filesURL = "https://www.googleapis.com/drive/v2/files"

-- | Get List of Drive files of the user. Takes access token.
getListOfFiles :: Token -> IO (Maybe DL.List)
getListOfFiles token = decodeStrict <$> getBearer token filesURL

-- | Find files with given title.
findByTitle :: [DF.File] -> Title -> [DF.File]
findByTitle files title = filter (checkTitle title) files
  where
    checkTitle title file = DF.title file == Just title

-- | Find first file with specified title.
firstByTitle :: [DF.File] -> Title -> Maybe DF.File
firstByTitle files title = do
  let list = findByTitle files title
  if null list then Nothing :: Maybe DF.File
    else Just (head list)

downloadFile :: Token -> Path -> DF.File -> IO Bool
downloadFile token path file = do
  let id = DF.id file
  let title = DF.title file
  if isNothing id || isNothing title then return False
    else do
      fileData <- getBearer token $ filesURL ++ fromJust id ++ "?alt=media"
      createDirectoryIfMissing True path
      BS.writeFile (path ++ fromJust title) fileData
      return True

downloadAllFiles :: Token -> Path -> DL.List -> IO Bool
downloadAllFiles token path list = do
  let items = DL.items list
  if isNothing items then return False
    else do
      mapM_ (downloadFile token path) (fromJust items)
      return True
