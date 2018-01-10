{-# LANGUAGE OverloadedStrings #-}

module Main where

-- import System.Directory
-- import Network.HTTP.Base
-- import Network.HTTP.Headers
import Network.HTTP.Simple
import qualified Data.ByteString.Char8 as B8
import Control.Monad.IO.Class
import Control.Monad.Catch
import System.Process

type URL = String

get :: URL -> IO String
get url = parseRequest url
  >>= httpBS
  >>= return . B8.unpack . getResponseBody

post :: URL -> IO String
post url = parseRequest url
  >>= return . setRequestMethod "POST"
  >>= httpBS
  >>= return . B8.unpack . getResponseBody

main :: IO ()
main = do

  let url = "https://accounts.google.com/o/oauth2/v2/auth?client_id=900337392594-4u7k4k2mabrnsl5ju9ghde47oj3lhh5b.apps.googleusercontent.com&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code&scope=https://www.googleapis.com/auth/drive.readonly"
  -- request <- parseRequest url >>= return . setRequestMethod "POST"

  -- resp <- post url

  readProcess "chromium" [url] ""

  print True
