{-# LANGUAGE OverloadedStrings #-}
module ZimServerSpec where


import Test.Hspec
import Test.Hspec.Wai
import Network.Wai (Application)

import Web.Scotty (scottyApp)

import ZimServer

testFile :: FilePath
testFile = "test/wikipedia_en_ray_charles_2015-06.zim"

app :: IO Application
app = scottyApp $ zimServerApp testFile

spec :: Spec
spec = do
  with app $ do
    describe "ZimServer" $ do
      it "can get /" $ do
        get "/" `shouldRespondWith` "" {matchStatus = 302, matchHeaders = ["Location" <:> "A/index.htm"]}

      it "can get A/index.htm" $ do
        get "A/index.htm" `shouldRespondWith` 200
