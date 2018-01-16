{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Process

import Data.Either.Extra

import qualified Data.ByteString.Char8 as B8
import qualified Data.ByteString.Lazy as B

import Control.Monad.IO.Class
import Control.Monad.Catch

import Network.HTTP.Simple hiding (Request)
import Network.HTTP.Listen
import Network.HTTP.Base
import Network.Stream hiding (Stream)
import Network.TCP (HStream)
import Network.HTTP.Headers
import Network.URI

type URL  = String

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
    
authURL' = "https://www.googleapis.com/oauth2/v4/token"
         ++ "?client_id="     ++ clientID
         ++ "&client_secret=" ++ clientSecret
         ++ "&grant_type="    ++ grantType
         ++ "&redirect_uri="    ++ redirectURI

handleResult :: Either e (Request r) -> (Request r -> m) -> Either e m
handleResult result f = case result of
  Left  err       -> Left err
  Right request   -> Right (f request)

takeAuthCode :: Request r -> String
takeAuthCode request = case request of
  Request uri _ _ _ -> case uri of
    URI _ _ _ query _ -> drop 6 query
  
authApp :: Either e String -> IO (Either e String)
authApp codeE = case codeE of
  Left  e    -> return $ Left e
  Right code -> do
    let authURL = authURL' ++ "&code=" ++ code
    jsonResponse <- post authURL
    return $ Right jsonResponse
  
listen :: Int -> IO (Result (Request B.ByteString))
listen port = do
  sock   <- prepareSocket port
  conn   <- acceptConnection sock
  stream <- openStream conn :: IO (Stream B.ByteString)
  result <- receiveRequest stream :: IO (Result (Request B.ByteString))
  closeStream stream
  return result

main :: IO ()
main = do
  -- r <- createProcess $ proc "chromium" [url]
  r <- createProcess $ proc "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe" [consentURL]
  
  result <- listen localPort
  let authCode = handleResult result takeAuthCode
  authResult <- authApp authCode
  case authResult of
    Left  _        -> print False
    Right response -> print response
  