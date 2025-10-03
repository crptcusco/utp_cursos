module Main where

-- lista pares
listaPares :: [Int] -> [Int]
listaPares [] = []
listaPares (x:xs)
  | x `mod` 2 == 0 = x : listaPares xs
  | otherwise      = listaPares xs

-- suma n primeros numeros recursivo
sumaN :: Int -> Int
sumaN 0 = 0
sumaN 1 = 1
sumaN n = n + sumaN (n-1)

-- cantidad de elementos de una lista
cantidad :: [Int] -> Int
cantidad [] = 0
cantidad (x:xs) = 1 + cantidad xs

-- invertir una lista
invertir :: [Int] -> [Int]
invertir [] = []
invertir (x:xs) = invertir xs ++ [x]

main :: IO ()
main = print (invertir [1,3,3,6,7])
