{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Text (Text)
import Data.Aeson as A
import Network.Curl.Aeson
import Network.Curl.Opts
import Data.Time.Clock.POSIX
import Secret (auth)

 -- UUID for unique random numbers 

newtype PlainTextMessage = PLM String

instance A.ToJSON PlainTextMessage where
  --toJSON str =
  toJSON (PLM str) =
    A.object ["msgtype".= ("m.text" :: Text), "body" .= str]

main = undefined

send :: String -> IO ()
send str = do
  putStrLn "Started"
  time <- show <$> getPOSIXTime
  print time

  let val = PLM str

  resp <- curlAeson A.parseJSON "PUT" (url' time) [CurlHttpHeaders ["Authorization: Bearer " ++ auth]] (Just val)
  print (resp::A.Value)

url' s = "https://jkl.hacklab.fi:8448/_matrix/client/r0/rooms/!RtlwJVOHzddeloiByq%3Aliittovaltio.fi/send/m.room.message/" ++ s







