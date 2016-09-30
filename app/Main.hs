{-# LANGUAGE OverloadedStrings #-}
module Main where

import App
import           Data.Text                (Text)
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Network.Wai.Logger       (withStdoutLogger)
import           Servant
import           Servant.API

main :: IO ()
main = App.run

