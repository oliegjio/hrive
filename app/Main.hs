{-# LANGUAGE OverloadedStrings #-}

module Main where

  import System.Process
  import System.IO as IO

  import qualified Data.ByteString.Char8      as B8
  import qualified Data.ByteString.Lazy.Char8 as B8L
  import           Data.Aeson hiding (Result)
  import           Data.Maybe

  import Network.HTTP.Simple hiding (Request)
  import Network.Stream      hiding (Stream)
  import Network.TCP                (HStream)
  import Network.HTTP.Listen
  import Network.HTTP.Base
  import Network.URI
  
  import Text.Regex

  import qualified Data.DriveFileList as DFL
  import           Data.AuthResponse
  import SimpleRequests
  import Config
  import Utils

  handleListenResult :: Either e (Request r) -> (Request r -> m) -> Maybe m
  handleListenResult result f = case result of
    Left  _       -> Nothing
    Right request -> Just (f request)

  takeAuthCode :: Request r -> String
  takeAuthCode request = case request of
    Request uri _ _ _ -> case uri of
      URI _ _ _ query _ -> drop 6 query
    
  authApp :: String -> IO (Maybe AuthResponse)
  authApp url = post url >>= return . decodeStrict . B8.pack
    
  listen :: Int -> IO (Result (Request B8.ByteString))
  listen port = do
    sock   <- prepareSocket port
    conn   <- acceptConnection sock
    stream <- openStream conn :: IO (Stream B8.ByteString)
    result <- receiveRequest stream :: IO (Result (Request B8.ByteString))
    closeStream stream
    return result

  main :: IO ()
  main = do
    
    -- r <- createProcess $ proc "chromium" [consentURL]
    r <- createProcess $ proc "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe" [consentURL]
    -- r <- createProcess $ proc "C:\\Program Files\\Mozilla Firefox\\firefox.exe" [consentURL]
    
    result <- listen localPort
  
    let authCode = handleListenResult result takeAuthCode
    
    if isNothing authCode then suicide "Couldn't receive response from consent screen!"
                          else print   "Received response from consent screen."
    let authURL = "https://www.googleapis.com/oauth2/v4/token"
               ++ "?client_id="     ++ clientID
               ++ "&client_secret=" ++ clientSecret
               ++ "&grant_type="    ++ grantType
               ++ "&redirect_uri="  ++ redirectURL
               ++ "&code="          ++ code
               where code = fromJust authCode

    authResult <- authApp authURL
    
    if isNothing authResult then suicide "Wrong application authentication data!"
                            else print   "Application authenticated."
    let accessData = fromJust authResult

    print accessData
    
    let token = accessToken accessData
    
    filesList <- get (listFilesURL ++ "?access_token=" ++ token)
    
    B8.writeFile "files-list.json" (B8.pack filesList)
  
    print (decodeStrict (B8.pack filesList) :: Maybe DFL.DriveFileList)
  
    return mempty