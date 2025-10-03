module Main where

-- suma n primeros numeros recursivo
sumaN :: Int -> Int
sumaN 0 = 0
sumaN 1 = 0
sumaN n = n + sumaN (n-1)

main :: IO ()
main = print (SumaN 10)