module Drive ( findByTitle
             , firstByTitle
             ) where
  
  import Data.Drive.File as DF
  import Data.Drive.List as DL
  import Data.Maybe
  
  checkTitle :: String -> DF.File -> Bool
  checkTitle title file = do
    let fileM = DF.title file
    if isNothing $ fileM
      then False
      else if fromJust fileM == title
        then True
        else False
  
  findByTitle :: [DF.File] -> String -> Maybe [DF.File]
  findByTitle files title = do
    let list = filter (checkTitle title) files
    if null list
      then Nothing :: Maybe [DF.File]
      else Just list
  
  firstByTitle :: [DF.File] -> String -> Maybe DF.File
  firstByTitle files title = do
    let list = findByTitle files title
    if null list
      then Nothing :: Maybe DF.File
      else Just (fromJust list !! 0)