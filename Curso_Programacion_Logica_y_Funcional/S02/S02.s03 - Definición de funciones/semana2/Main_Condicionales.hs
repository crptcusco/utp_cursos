module Main where

-- Función que devuelve el mayor de dos números
mayorEdad :: Int -> String
mayorEdad edad = if edad >= 18 then "Adulto" else "Menor" 

-- Función que devuelve el valor absoluto de un número
absoluto :: Int -> Int
absoluto n = if n >= 0 then n else -n 

main :: IO ()
main = do
  print (absoluto (-5))
  print (mayorEdad 17)