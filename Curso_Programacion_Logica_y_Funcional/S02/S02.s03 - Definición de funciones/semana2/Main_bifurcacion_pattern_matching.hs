module Main where

factorial :: Int -> Int
factorial 0 = 1 -- Caso base
factorial n = n * factorial (n - 1)

longitud :: [a] -> Int
longitud [] = 0
longitud (_:xs) = 1 + longitud xs

main :: IO ()
main = do
  print (factorial 5)
  print (longitud [1..36])