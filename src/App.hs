{-# LANGUAGE OverloadedStrings #-}

module App where

import GHC.Generics (Generic)
import Data.Text hiding (minimum)
import Network.Google.Resource.Compute.Instances.Insert
import Control.Lens ((&), (.~), (<&>), (?~))
import qualified Network.Google as Google
import Network.Google
import qualified Network.Google.Compute as Compute
import Network.Google.Compute
import Network.Google.Compute.Types
import System.IO (stdout)
import qualified Data.Text as T

run :: IO ()
run = do
  putStrLn "start"
  lgr  <- Google.newLogger Google.Debug stdout
  env  <- Google.newEnv <&> (Google.envLogger .~ lgr) . (Google.envScopes .~ Compute.computeScope)
  a <- runResourceT . Google.runGoogle env $ do
    Google.send $ instancesList "shokohara-157622" "asia-northeast1-a"
  --return $ putStrLn a
--  runResourceT . Google.runGoogle env $ do
--    Google.send $ instancesInsert "shokohara-157622" "asia-northeast1-a" (instance' & insnName ?~ "instance-4" & insnMachineType ?~ "zones/asia-northeast1-a/machineTypes/n1-standard-1" & insnNetworkInterfaces .~ [networkInterface & niName ?~ "global/networks/default"] & insnDisks .~ [attachedDisk & adBoot ?~ True & adInitializeParams ?~ (attachedDiskInitializeParams & adipSourceImage ?~ "projects/debian-cloud/global/images/family/debian-8")])
--    Google.send $ instancesDelete "shokohara-157622" "asia-northeast1-a" (T.pack $ show a)
  return ()
