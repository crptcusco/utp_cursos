module Main where

absoluto' :: Int -> Int
absoluto' n
  | n >= 0 = n
  | otherwise = -n

main :: IO ()
main = do
  print (absoluto' (-5))