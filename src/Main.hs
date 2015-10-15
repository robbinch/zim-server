{-# LANGUAGE OverloadedStrings #-}

import Control.Monad.IO.Class (liftIO)
import Data.Text.Lazy (toStrict, fromStrict)
import Data.Text.Encoding (decodeUtf8, encodeUtf8)
import System.Environment (getArgs)
import Network.HTTP.Types.Status (status404)
import Web.Scotty
import Codec.Archive.Zim.Parser (getZimMainPageUrl, getZimUrlContent)

main :: IO ()
main = do
    [fp] <- getArgs
    scotty 3000 $ do
      get "/" (redirectToZimMainPage fp)
      get (regex "^/(./.*)$") (serveZimUrl fp)
      notFound $ text "Invalid URL!"

redirectToZimMainPage :: FilePath -> ActionM ()
redirectToZimMainPage fp = do
    res <- liftIO $ getZimMainPageUrl fp
    case res of
      Nothing -> do
        status status404
        text "This ZIM file has no main page specified!"
      Just url -> redirect . fromStrict $ decodeUtf8 url

serveZimUrl :: FilePath -> ActionM ()
serveZimUrl fp = do
    url <- (encodeUtf8 . toStrict) <$> param "1"
    res <- liftIO $ getZimUrlContent fp url
    case res of
      Nothing -> do
        liftIO . putStrLn $ "Invalid URL: " ++ show url
        status status404
        text $ "Invalid URL!"
      Just (mimeType, content) -> do
        liftIO . putStrLn $ "Serving: " ++ show url
        setHeader "Content-Type" (fromStrict $ decodeUtf8 mimeType)
        raw content

