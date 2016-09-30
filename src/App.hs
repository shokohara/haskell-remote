{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module App where

import Network.Wreq
import Control.Lens
import Data.Maybe
import Data.Aeson (FromJSON, decode)
import OpenSSL.Session (context)
import Network.HTTP.Client.OpenSSL
import Network.HTTP.Client (defaultManagerSettings, managerResponseTimeout)
import GHC.Generics (Generic)
import Data.Text hiding (minimum)
import Js (Js)
import qualified Js
import Tf (Tf)
import qualified Tf
--import MinTf (MinTf)
--import qualified MinTf

opt = defaults & manager .~ Left (opensslManagerSettings context)

instance FromJSON Js
instance FromJSON Tf

minn :: Tf -> Int
minn a = minimum $ fmap (\f -> f a) [Tf.carNo1, Tf.carNo2, Tf.carNo3, Tf.carNo4, Tf.carNo5, Tf.carNo6, Tf.carNo7, Tf.carNo8, Tf.carNo9, Tf.carNo10, Tf.carNo11]

run :: IO ()
run = do
  r <- withOpenSSL $ getWith opt "https://rp.cloudrail.jp/tw02/jreast_app/fb/feedback/feedback/?accessTime=2330&accessDayCd=4&direction=0"
  print $ (fmap minn . trainFeedbackList) <$> (decode (r ^. responseBody) :: Maybe Js)

-- min :: Js -> [MinTf]
-- min js = fmap trainFeedbackList


-- 外回り direction=0
-- 内回り direction=1
-- 日曜日 accessDayCd=1
-- 土曜日            =7
-- 月曜日            =2
-- 時間帯 accessTime=0400, 2330, 0000
-- first=true or empty 更新ボタンを押したときのみfirst=trueがつく
-- _=unixtime
