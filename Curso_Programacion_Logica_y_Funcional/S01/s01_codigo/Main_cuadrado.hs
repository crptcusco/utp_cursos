module Main where

main :: IO ()
main = do

  let 
    cuadrado :: Int -> Int
    cuadrado x = x * 2

  print (cuadrado 5)