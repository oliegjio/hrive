{-# LANGUAGE OverloadedStrings #-}

module Main where

import Network.HTTP.Simple
import qualified Data.ByteString.Char8 as B8
import qualified Data.ByteString.Lazy as B
import Control.Monad.IO.Class
import Control.Monad.Catch
import System.Process
import Network.HTTP.Listen

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

listener :: Listener B.ByteString IO
listener request = print request >> return Nothing

clientID     = "900337392594-4u7k4k2mabrnsl5ju9ghde47oj3lhh5b.apps.googleusercontent.com"
redirectURI  = "urn:ietf:wg:oauth:2.0:oob"
scope        = "https://www.googleapis.com/auth/drive.readonly"
responseType = "code"
url = "https://accounts.google.com/o/oauth2/v2/auth"
      ++ "?client_id="     ++ clientID
      ++ "&redirect_uri="  ++ redirectURI
      ++ "&response_type=" ++ responseType
      ++ "&scope="         ++ scope

main :: IO ()
main = do
  readProcess "chromium" [url] ""

  -- run 8999 listener

  print True
