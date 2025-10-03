module Main where

-- lista pares
listaPares :: [Int] -> [Int]
listaPares [] = []
listaPares (x:xs)
  | x `mod` 2 == 0 = x : listaPares xs
  | otherwise      = listaPares xs

main :: IO ()
main = print (listaPares [1..100])
