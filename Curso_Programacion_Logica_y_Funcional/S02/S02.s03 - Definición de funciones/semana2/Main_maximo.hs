module Main where

maximo :: [Int] -> Int
maximo  [x] = x
maximo (x:xs) = max x ( maximo xs )

main :: IO ()
main = do
  print (maximo [3 ,8 ,2 ,5])