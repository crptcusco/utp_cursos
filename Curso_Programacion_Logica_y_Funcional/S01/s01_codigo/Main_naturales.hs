module Main where

main :: IO ()
main = do
  let naturales = [0..] -- Define the infinite list of natural numbers starting from 0
  print (take 5 naturales) -- Print the first 5 elements