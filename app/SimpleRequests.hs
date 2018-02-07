{-# LANGUAGE OverloadedStrings #-}

module SimpleRequests where

  import qualified Data.ByteString.Char8 as B8
  import Network.HTTP.Simple
  import Network.HTTP.Types.Header
    
  type URL = String
      
  get :: URL -> IO String
  get url = parseRequest url
    >>= httpBS
    >>= return . B8.unpack . getResponseBody
  
  getH :: URL -> [(HeaderName, String)] -> IO String
  getH url headers = do
    request <- parseRequest url
    let requestH = foldl addHeader request headers
    httpBS requestH >>= return . B8.unpack . getResponseBody
    
  post :: URL -> IO String
  post url = parseRequest url
    >>= return . setRequestMethod "POST"
    >>= httpBS
    >>= return . B8.unpack . getResponseBody
  
  addHeader :: Request -> (HeaderName, String) -> Request
  addHeader request (name, content) = addRequestHeader name (B8.pack content) request