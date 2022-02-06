module Main where

import Tokens

main :: IO ()
main = do
  s <- getContents
  print (alexScanTokens s)
