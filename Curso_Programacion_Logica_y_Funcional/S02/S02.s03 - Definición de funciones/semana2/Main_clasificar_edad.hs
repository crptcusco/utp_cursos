module Main where

clasificarPorEdad :: Int ->  String
clasificarPorEdad edad
  | edad < 11 = "Niño"
  | edad < 15 = "Adolescente"
  | edad < 18 = "Joven"
  | otherwise = "Adulto" 

main :: IO ()
main = do
  print (clasificarPorEdad 18)
