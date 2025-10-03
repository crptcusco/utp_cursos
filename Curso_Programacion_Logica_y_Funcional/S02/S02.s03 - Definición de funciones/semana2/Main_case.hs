module Main where

-- Usando case
mensaje x = case x of
  1 -> "Uno"
  2 -> "Dos"
  _ -> "Otro número"

main :: IO ()
main = do
  print (mensaje 2)