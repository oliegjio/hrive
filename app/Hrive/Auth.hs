{-# LANGUAGE OverloadedStrings #-}

-- | Module that provide functions to authenticate Hrive application.
module Hrive.Auth (authenticate) where

-- Auth flow:
-- 1. Opens up a web browser with consent screen. There a user
--    authenticates to Google Account and gives Hrive Application
--    access to its Google Drive.
-- 2. If the previous point is successful then Google will return
--    URL with auth code to localhost.
-- 3. Hrive App fetches auth code from localhost request.
-- 4. Composing auth url with fetched auth code and some other data.
-- 5. Makes a GET request with auth url to Google.
-- 6. If successful, Google will return a response with access data.
--    Access data contains access token.
-- 7. Feching access token from access data and using it to do actions
--    on a clients Google Drive.

import qualified Data.ByteString.Lazy.Char8 as B8L
import qualified Network.Stream as S
import Network.HTTP.Listen
import Network.HTTP.Base
import Network.URI
import Data.Aeson
import Data.Maybe

import Hrive.Utils
import Hrive.SimpleRequests

type ClientID = String
type ClientSecret = String

data AuthResponse = AuthResponse
                  { accessToken :: String
                  , tokenType   :: String
                  , expiresIn   :: Int
                  } deriving (Show)

instance FromJSON AuthResponse where
  parseJSON = withObject "AuthResponse" $ \o ->
    AuthResponse <$> o .: "access_token"
                 <*> o .: "token_type"
                 <*> o .: "expires_in"

-- | Takes a result and a handler.
--   Executes a given handler on a given result.
--   Result could contain either connection error or connection
--   data, if successful.
handleListenResult :: (Request r -> m) -> Either e (Request r) -> Maybe m
handleListenResult f result = case result of
  Left  _       -> Nothing
  Right request -> Just (f request)

-- | Listen given port for a connection.
--   If connected returns a connection result.
--   Result could either error or connection data.
listenOnce :: Int -> IO (S.Result (Request B8L.ByteString))
listenOnce port = do
  sock   <- prepareSocket port
  conn   <- acceptConnection sock
  stream <- openStream conn :: IO (Stream B8L.ByteString)
  result <- receiveRequest stream :: IO (S.Result (Request B8L.ByteString))
  closeStream stream
  return result

-- | Fetches auth code from URL.
--   Auth code is used in URL parameter to authenticate
--   the application.
fetchAuthCode :: Request r -> String
fetchAuthCode request = case request of
  Request uri _ _ _ -> case uri of
    URI _ _ _ query _ -> drop 6 query

-- | Takes a properly formatted URL, sends GET request to this URL
--   and returns JSON with some auth data.
makeAuthRequest :: String -> IO (Maybe AuthResponse)
makeAuthRequest url = fmap decodeStrict (post url)

localPort = 8999 :: Int
redirectURL = "http://127.0.0.1:" ++ show localPort
responseType = "code"
grantType = "authorization_code"
scopeURL = "https://www.googleapis.com/auth/drive.readonly"

-- | Authenticates Hrive application with given client ID and client secret key.
authenticate :: ClientID -> ClientSecret -> IO (Maybe String)
authenticate clientID clientSecret = do
  openBrowser ChromiumLinux consentURL
  authCode <- handleListenResult fetchAuthCode <$> listenOnce localPort
  if isNothing authCode then return Nothing
    else do
      authResult <- makeAuthRequest $ getAuthURL $ fromJust authCode
      if isNothing authResult then return Nothing
        else return $ Just (accessToken $ fromJust authResult)
    where
      getAuthURL authCode = "https://www.googleapis.com/oauth2/v4/token"
                ++ "?client_id="     ++ clientID
                ++ "&client_secret=" ++ clientSecret
                ++ "&grant_type="    ++ grantType
                ++ "&redirect_uri="  ++ redirectURL
                ++ "&code="          ++ authCode
      consentURL = "https://accounts.google.com/o/oauth2/v2/auth"
                ++ "?client_id="     ++ clientID
                ++ "&redirect_uri="  ++ redirectURL
                ++ "&response_type=" ++ responseType
                ++ "&scope="         ++ scopeURL
