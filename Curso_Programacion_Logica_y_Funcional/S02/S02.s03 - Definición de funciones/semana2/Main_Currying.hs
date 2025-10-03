module Main where

-- Funciones con múltiples parámetros (Currying):
suma :: Int -> Int -> Int
suma a b = a + b

-- Aplicación parcial
suma5 :: Int -> Int
suma5 = suma 5 

main :: IO ()
main = do
  print (suma5 15)