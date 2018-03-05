{-# LANGUAGE OverloadedStrings #-}

module Main where

  import System.Process
  import System.IO as IO

  import qualified Data.ByteString.Char8      as B8
  import qualified Data.ByteString.Lazy.Char8 as B8L
  import           Data.Aeson                 hiding (Result)
  import           Data.Maybe

  import Network.HTTP.Simple hiding (Request)
  import Network.Stream      hiding (Stream)
  import Network.HTTP.Listen
  import Network.HTTP.Types.Header
  import Network.HTTP.Base
  import Network.URI

  import qualified Data.Drive.List as DL
  import qualified Data.Drive.File as DF
  import qualified Drive as D
  import           Data.AuthResponse
  import           SimpleRequests
  import           Config
  import           Utils

  -- | Takes a result and a handler.
  --   Executes a given handler on a given result.
  --   Result could contain either connection error or connection
  --   data, if successful.
  handleListenResult :: Either e (Request r) -> (Request r -> m) -> Maybe m
  handleListenResult result f = case result of
    Left  _       -> Nothing
    Right request -> Just (f request)

  -- | Fetches auth code from URL.
  --   Auth code is used in URL parameter to authenticate
  --   the application.
  takeAuthCode :: Request r -> String
  takeAuthCode request = case request of
    Request uri _ _ _ -> case uri of
      URI _ _ _ query _ -> drop 6 query
  
  -- | Takes a properly formatted URL, sends GET request to this URL
  --   and returns JSON with some auth data.
  authApp :: String -> IO (Maybe AuthResponse)
  authApp url = post url >>= return . decodeStrict . B8.pack
  
  -- | Listen given port for a connection.
  --   If connected returns a connection result.
  --   Result could either error or connection data.
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
    
    filesListJSON <- get (listFilesURL ++ "?access_token=" ++ token)
    B8.writeFile "files-list.json" (B8.pack filesListJSON)
  
    let filesListResult = decodeStrict (B8.pack filesListJSON) :: Maybe DL.List
    if isNothing filesListResult then suicide "Filed to fetch Drive files list!"
                                 else print   "Fetched Drive files list."
    let filesList = fromJust filesListResult
    
    let filesM = DL.items filesList
    if isNothing filesM then suicide "There is no files!"
                        else print   "Files fetched."
    let files = fromJust filesM
    
    let chloeURL = fromJust $ DF.downloadUrl $
                   fromJust $ D.firstByTitle files "chloe-grace-moretz.jpg"
    
    chloeData <- getBearer token chloeURL
    
    B8.writeFile "chloe.jpg" (B8.pack chloeData)
    
    -- print chloeData
    
    -- let someFileURL = fromJust $ DF.downloadUrl $ (fromJust $ DL.items filesList) !! 1
    -- let someFileTitle = fromJust $ DF.title $ (fromJust $ DL.items filesList) !! 1
    
    -- print someFileTitle
    -- print someFileURL  
    
    return mempty