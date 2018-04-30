{-# LANGUAGE OverloadedStrings #-}

-- | Module that allows to do simple GET and POST requests.
module Hrive.SimpleRequests ( get
                            , getH
                            , getBearer
                            , addHeader
                            , post
                            ) where

import qualified Data.ByteString.Char8 as BC
import Network.HTTP.Simple
import Network.HTTP.Types.Header

type URL = String
type Token = String
type HeaderValue = String

-- | Make GET request to a given url. Return result as a string.
get :: URL -> IO String
get url = parseRequest url
  >>= httpBS
  >>= return . BC.unpack . getResponseBody

-- | Make GET request to a given URL with specified headers. Return string as a result.
getH :: [(HeaderName, HeaderValue)] -> URL -> IO String
getH headers url = do
  request <- parseRequest url
  let requestH = foldl addHeader request headers
  httpBS requestH >>= return . BC.unpack . getResponseBody

-- | Make GET request to a given URL and authenticate with given Bearer token. Return string as a result.
getBearer :: Token -> URL -> IO String
getBearer token url = getH [("Authorization", "Bearer " ++ token)] url

-- | Make POST request to a given URL. Return string as a result.
post :: URL -> IO String
post url = parseRequest url
  >>= return . setRequestMethod "POST"
  >>= httpBS
  >>= return . BC.unpack . getResponseBody

-- | Adds up given header to the given request. Return request with header appended.
addHeader :: Request -> (HeaderName, HeaderValue) -> Request
addHeader request (name, content) = addRequestHeader name (BC.pack content) request

