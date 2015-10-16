import System.Environment (getArgs)

import Web.Scotty
import ZimServer

main :: IO ()
main = do
    [fp] <- getArgs
    scotty 3000 $ zimServerApp fp

