module Utils where
  
  import System.Exit
  
  suicide :: String -> IO ()
  suicide m = print m >> exitFailure