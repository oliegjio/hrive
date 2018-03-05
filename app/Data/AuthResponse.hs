{-# LANGUAGE OverloadedStrings #-}

module Data.AuthResponse where
    
  import Data.Aeson
  
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