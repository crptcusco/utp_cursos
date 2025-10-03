module Main where

-- Función recursiva (factorial)
factorial 0 = 1
factorial n = n * factorial (n-1)

-- Función que suma dos números
suma :: Int -> Int -> Int
suma a b = a + b

-- funcion doble
doble :: Int -> Int
doble x = x * 2 

main :: IO ()
main = do
  print (suma 5 3)
  print (factorial 5)
  print (doble 5)