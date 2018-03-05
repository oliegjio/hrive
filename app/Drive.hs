module Drive where
  
  import qualified Data.Drive.File as DF
  import qualified Data.Drive.List as DL
  import Data.Maybe
  
  findByTitle :: [DF.File] -> String -> [DF.File]
  findByTitle files title = filter (checkTitle title) files
    where
      checkTitle title file = do
        let titleM = DF.title file
        if isNothing $ titleM
        then False
        else if fromJust titleM == title
          then True
          else False
  
  firstByTitle :: [DF.File] -> String -> Maybe DF.File
  firstByTitle files title = do
    let list = findByTitle files title
    if null list
      then Nothing :: Maybe DF.File
      else Just (list !! 0)