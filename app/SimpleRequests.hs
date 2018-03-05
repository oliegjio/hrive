{-# LANGUAGE OverloadedStrings #-}

module SimpleRequests ( get
                      , getH
                      , getBearer
                      , addHeader
                      , post
                      ) where

  import qualified Data.ByteString.Char8 as B8
  import Network.HTTP.Simple as HS
  import Network.HTTP.Types.Header as HTH
    
  type URL = String
  type Token = String
  
  get :: URL -> IO String
  get url = HS.parseRequest url
    >>= HS.httpBS
    >>= return . B8.unpack . HS.getResponseBody
  
  getH :: [(HTH.HeaderName, String)] -> URL -> IO String
  getH headers url = do
    request <- HS.parseRequest url
    let requestH = foldl addHeader request headers
    HS.httpBS requestH >>= return . B8.unpack . HS.getResponseBody
  
  getBearer :: Token -> URL -> IO String
  getBearer token url = getH [("Authorization", "Bearer " ++ token)] url
  
  post :: URL -> IO String
  post url = HS.parseRequest url
    >>= return . HS.setRequestMethod "POST"
    >>= HS.httpBS
    >>= return . B8.unpack . HS.getResponseBody
  
  addHeader :: Request -> (HTH.HeaderName, String) -> Request
  addHeader request (name, content) = HS.addRequestHeader name (B8.pack content) request
  
  -- download :: String -> IO ()
  -- download url = do
    