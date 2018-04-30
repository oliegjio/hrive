-- | Module that provide some additional functionaliy.
module Hrive.Utils where
  
import System.Exit
import System.Process

data Browser = GoogleChromeWindows
             | ChromiumLinux
             | FirefoxLinux
             | FirefoxWindows
             deriving (Show, Read, Eq)

-- | Opens up a browser specified as first parameter with given URL in the second parameter.
openBrowser :: Browser -> String -> IO ()
openBrowser browser url = case browser of
  GoogleChromeWindows -> open "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe"
  ChromiumLinux       -> open "chromium"
  FirefoxWindows      -> open "C:\\Program Files\\Mozilla Firefox\\firefox.exe"
  FirefoxLinux        -> open "firefox"
  where
    open path = (createProcess $ proc path [url]) >> return ()

-- | Print error message and exit with error.
suicide :: String -> IO ()
suicide m = print m >> exitFailure
