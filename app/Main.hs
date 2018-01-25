{-# LANGUAGE OverloadedStrings #-}

module Main where

  import System.Process
  import System.Exit

  import qualified Data.ByteString.Char8 as B8
  import           Data.Aeson hiding (Result)
  import           Data.Maybe

  import Control.Monad.IO.Class
  import Control.Monad.Catch

  import Network.HTTP.Simple hiding (Request)
  import Network.Stream      hiding (Stream)
  import Network.TCP                (HStream)
  import Network.HTTP.Listen
  import Network.HTTP.Base
  import Network.HTTP.Headers
  import Network.URI

  import AccessTokenResponse
  import SimpleRequests
  
  listener :: Listener B8.ByteString IO
  listener request = print request >> return Nothing

  localPort    = 8999 :: Int
  clientID     = "900337392594-avkns0t5472ef49johhhaor06p8qvn27.apps.googleusercontent.com"
  clientSecret = "UQL0tyK4MvTDlj2ZzCDIMhfR"
  redirectURI  = "http://127.0.0.1:" ++ show localPort
  scope        = "https://www.googleapis.com/auth/drive.readonly"
  responseType = "code"
  grantType    = "authorization_code"

  consentURL = "https://accounts.google.com/o/oauth2/v2/auth"
            ++ "?client_id="     ++ clientID
            ++ "&redirect_uri="  ++ redirectURI
            ++ "&response_type=" ++ responseType
            ++ "&scope="         ++ scope

  processListenResult :: Either e (Request r) -> (Request r -> m) -> Maybe m
  processListenResult result f = case result of
    Left  _       -> Nothing
    Right request -> Just (f request)

  takeAuthCode :: Request r -> String
  takeAuthCode request = case request of
    Request uri _ _ _ -> case uri of
      URI _ _ _ query _ -> drop 6 query
    
  authApp :: String -> IO (Maybe AccessTokenResponse)
  authApp url = post url >>= return . decodeStrict . B8.pack
    
  listen :: Int -> IO (Result (Request B8.ByteString))
  listen port = do
    sock   <- prepareSocket port
    conn   <- acceptConnection sock
    stream <- openStream conn :: IO (Stream B8.ByteString)
    result <- receiveRequest stream :: IO (Result (Request B8.ByteString))
    closeStream stream
    return result

  suicide :: String -> IO ()
  suicide m = print m >> exitFailure

  main :: IO ()
  main = do
    
    -- r <- createProcess $ proc "chromium" [url]
    -- r <- createProcess $ proc "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe" [consentURL]
    r <- createProcess $ proc "C:\\Program Files\\Mozilla Firefox\\firefox.exe" [consentURL]
    
    result <- listen localPort
  
    let authCode = processListenResult result takeAuthCode
    if isNothing authCode then suicide "Couldn't receive response from consent screen!"
                          else print   "Received response from consent screen."
    let authURL = "https://www.googleapis.com/oauth2/v4/token"
               ++ "?client_id="     ++ clientID
               ++ "&client_secret=" ++ clientSecret
               ++ "&grant_type="    ++ grantType
               ++ "&redirect_uri="  ++ redirectURI
               ++ "&code="          ++ code
               where code = fromJust authCode

    authResult <- authApp authURL
    if isNothing authResult then suicide "Wrong application authentication data!"
                            else print   "Application authenticated."
    let accessData = fromJust authResult
    
    print accessData
  
    return mempty