{-# LANGUAGE OverloadedStrings #-}

module SimpleRequests where

  import qualified Data.ByteString.Char8 as B8
  import Network.HTTP.Simple
    
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