module Main where

  import System.Process

  import Data.Either.Extra
  import Data.Aeson (decode)
  import Data.ByteString.Lazy.UTF8 (fromString)

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

  import TokenResponse
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

  processListenResult :: Either e (Request r) -> (Request r -> m) -> Either e m
  processListenResult result f = case result of
    Left  err       -> Left err
    Right request   -> Right (f request)

  takeAuthCode :: Request r -> String
  takeAuthCode request = case request of
    Request uri _ _ _ -> case uri of
      URI _ _ _ query _ -> drop 6 query
    
  authApp :: Either e String -> IO (Either e String)
  authApp url = case url of
    Left  e    -> return $ Left e
    Right url  -> do
      jsonResponse <- post url
      return $ Right jsonResponse
    
  listen :: Int -> IO (Result (Request B8.ByteString))
  listen port = do
    sock   <- prepareSocket port
    conn   <- acceptConnection sock
    stream <- openStream conn :: IO (Stream B8.ByteString)
    result <- receiveRequest stream :: IO (Result (Request B8.ByteString))
    closeStream stream
    return result

  parseJSON :: String -> Maybe TokenResponse
  parseJSON = decode . fromString

  main :: IO ()
  main = do
    
    -- r <- createProcess $ proc "chromium" [url]
    -- r <- createProcess $ proc "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe" [consentURL]
    r <- createProcess $ proc "C:\\Program Files\\Mozilla Firefox\\firefox.exe" [consentURL]
    
    result <- listen localPort
  
    let authCode = processListenResult result takeAuthCode    
    let authURL = case authCode of
                    Left e     -> Left e
                    Right code -> Right ( "https://www.googleapis.com/oauth2/v4/token"
                                       ++ "?client_id="     ++ clientID
                                       ++ "&client_secret=" ++ clientSecret
                                       ++ "&grant_type="    ++ grantType
                                       ++ "&redirect_uri="  ++ redirectURI
                                       ++ "&code="          ++ code
                                        )

    authResult <- authApp authURL
    let accessData = either (\_ -> Nothing) (parseJSON) authResult
    
    print accessData
  
    return mempty