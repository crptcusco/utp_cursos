module Main where

-- Calcula la suma de cuadrados de una lista
-- sumaCuadrados :: [Int] -> Int
-- sumaCuadrados xs = sum (map (^2) xs)

sumaCuadrados :: [Int] -> Int
sumaCuadrados [] = 0
sumaCuadrados (x:xs) = (x * x) + sumaCuadrados xs

main :: IO ()
main = print (sumaCuadrados [1, 2, 3, 4, 5])
