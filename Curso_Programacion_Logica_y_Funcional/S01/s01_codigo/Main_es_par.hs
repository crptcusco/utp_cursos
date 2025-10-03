module Main where

-- Funcion para determinar si un numero es par
esPar :: Int -> Bool
esPar n = even n 

main :: IO ()
main = print (esPar 5)
