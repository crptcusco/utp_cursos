module Main where

clasificarNota :: Int ->  String
clasificarNota nota
  | nota < 11 = "Desaprobado"
  | nota < 15 = "Regular"
  | nota < 18 = "Bueno"
  | otherwise = "Excelente" 

main :: IO ()
main = do
  print (clasificarNota 10)