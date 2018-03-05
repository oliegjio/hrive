{-# LANGUAGE OverloadedStrings #-}

module SimpleRequests ( get
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
  
  get :: URL -> IO String
  get url = parseRequest url
    >>= httpBS
    >>= return . BC.unpack . getResponseBody
  
  getH :: [(HeaderName, String)] -> URL -> IO String
  getH headers url = do
    request <- parseRequest url
    let requestH = foldl addHeader request headers
    httpBS requestH >>= return . BC.unpack . getResponseBody
  
  getBearer :: Token -> URL -> IO String
  getBearer token url = getH [("Authorization", "Bearer " ++ token)] url
  
  post :: URL -> IO String
  post url = parseRequest url
    >>= return . setRequestMethod "POST"
    >>= httpBS
    >>= return . BC.unpack . getResponseBody
  
  addHeader :: Request -> (HeaderName, String) -> Request
  addHeader request (name, content) = addRequestHeader name (BC.pack content) request
    