module Main where

fibs :: [Integer]
fibs = 0 : 1 : zipWith(+) fibs (tail fibs)

main :: IO ()
main = print (take 15 fibs)