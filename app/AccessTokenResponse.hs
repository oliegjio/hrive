{-# LANGUAGE DeriveGeneric #-}

module AccessTokenResponse where
    
  import GHC.Generics
  import Data.Aeson ( ToJSON   (..)
                    , FromJSON (..)
                    , genericToEncoding
                    , defaultOptions
                    )
  
  data AccessTokenResponse = AccessTokenResponse { access_token :: String
                                                 , token_type   :: String
                                                 , expires_in   :: Int
                                                 } deriving (Generic, Show)    
                                           
  instance FromJSON AccessTokenResponse where
  
  instance ToJSON AccessTokenResponse where
    toEncoding = genericToEncoding defaultOptions