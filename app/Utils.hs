module Utils (suicide) where
  
  import System.Exit as SE
  
  suicide :: String -> IO ()
  suicide m = print m >> SE.exitFailure