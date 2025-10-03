module Main where

sumaLista :: [Int] -> Int
sumaLista [] = 0
sumaLista (x:xs) = x + sumaLista xs

main :: IO ()
main = print (sumaLista [1..100])
