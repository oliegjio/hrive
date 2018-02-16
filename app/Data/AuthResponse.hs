{-# LANGUAGE OverloadedStrings #-}

module Data.AuthResponse (AuthResponse (..)) where
    
  import GHC.Generics
  import Data.Aeson (FromJSON (..), withObject, (.:))
  
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