{-# LANGUAGE DeriveGeneric #-}

module TokenResponse where
    
  import GHC.Generics
  import Data.Aeson ( ToJSON   (..)
                    , FromJSON (..)
                    , genericToEncoding
                    , defaultOptions
                    )
  
  data TokenResponse = TokenResponse { access_token :: String
                                     , token_type   :: String
                                     , expires_in   :: Int
                                     } deriving (Generic, Show)    
                                           
  instance FromJSON TokenResponse where
  
  instance ToJSON TokenResponse where
    toEncoding = genericToEncoding defaultOptions