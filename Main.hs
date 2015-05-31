{-# LANGUAGE OverloadedStrings #-}
module Main where

import           Control.Applicative ((<$>))
import           Control.Concurrent  (forkIO, threadDelay)
import           Control.Monad       (forever)
import           Data.Default        (def)
import           Data.Text           (Text, pack)
import           FRP.Sodium
import           JavaScript.JQuery   hiding (Event)


main :: IO ()
main = do
  body <- select "body"

  -- a button
  (btn, btnE) <- mkBtnE "Click"
  appendJQuery btn body


  -- a behavior: counter - increment when btnE (button event) arrive
  counterB <- sync $ accum 0 (const (+1) <$> btnE)


  -- a div with the counter value
  counterView <- mkDiv $ fmap (pack . show) counterB
  appendJQuery counterView body


  -- wait -> nothing changed
  -- forkIO $ forever (threadDelay 1000000000)
  return ()




mkBtn :: Text -> IO JQuery
mkBtn label = select "<button/>" >>= setText label


mkBtnE :: Text -> IO (JQuery, Event ())
mkBtnE label = do
  (e, t) <- sync newEvent
  btn <- mkBtn label
  on (const $ sync $ t ()) "click" def btn
  return (btn, e)


mkDiv :: Behaviour Text -> IO JQuery
mkDiv b = do
  div <- select "<div/>"
  sync $ listen (value b) (\t -> setText t div >> return ())
  return div

