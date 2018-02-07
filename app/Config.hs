module Config where
    
  localPort    = 8999 :: Int
  
  clientID     = "900337392594-avkns0t5472ef49johhhaor06p8qvn27.apps.googleusercontent.com"
  
  clientSecret = "UQL0tyK4MvTDlj2ZzCDIMhfR"
  
  responseType = "code"
  
  grantType    = "authorization_code"

  -- =========================
  --          URLs:
  -- =========================

  redirectURL  = "http://127.0.0.1:" ++ show localPort

  scopeURL     = "https://www.googleapis.com/auth/drive.readonly"

  consentURL   = "https://accounts.google.com/o/oauth2/v2/auth"
              ++ "?client_id="     ++ clientID
              ++ "&redirect_uri="  ++ redirectURL
              ++ "&response_type=" ++ responseType
              ++ "&scope="         ++ scopeURL
              
  listFilesURL = "https://www.googleapis.com/drive/v2/files"