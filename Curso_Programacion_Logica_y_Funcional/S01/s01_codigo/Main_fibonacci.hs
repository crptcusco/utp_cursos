module Main where

-- evaluacion perezoza
-- Fibonacci como lista infinita
fibs :: [Integer]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

main :: IO ()
main = print (take 3 fibs)