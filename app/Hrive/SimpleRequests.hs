{-# LANGUAGE OverloadedStrings #-}

-- | Module that allows to do simple GET and POST requests.
module Hrive.SimpleRequests ( get
                            , getH
                            , getBearer
                            , addHeader
                            , post
                            ) where

import qualified Data.ByteString.Char8 as BS
import Network.HTTP.Simple
import Network.HTTP.Types.Header

type URL = String
type Token = String
type HeaderValue = BS.ByteString

-- | Make GET request to a given url. Return result as a string.
get :: URL -> IO BS.ByteString
get url = fmap getResponseBody (parseRequest url >>= httpBS)

-- | Make GET request to a given URL with specified headers. Return string as a result.
getH :: [(HeaderName, HeaderValue)] -> URL -> IO BS.ByteString
getH headers url = do
  request <- parseRequest url
  let requestH = foldl addHeader request headers
  fmap getResponseBody (httpBS requestH)

-- | Make GET request to a given URL and authenticate with given Bearer token. Return string as a result.
getBearer :: Token -> URL -> IO BS.ByteString
getBearer token = getH [("Authorization", BS.pack $ "Bearer " ++ token)]

-- | Make POST request to a given URL. Return string as a result.
post :: URL -> IO BS.ByteString
post url = fmap getResponseBody $
  fmap (setRequestMethod "POST") (parseRequest url) >>= httpBS

-- | Adds up given header to the given request. Return request with header appended.
addHeader :: Request -> (HeaderName, HeaderValue) -> Request
addHeader request (name, value) = addRequestHeader name value request
