module Main where

data Figura = Circulo Float
  | Rectangulo Float Float
  | Triangulo Float Float Float deriving (Show)

circulo1 :: Figura
circulo1 = Circulo 5.1
rectangulo1 :: Figura
rectangulo1 = Rectangulo 3.1 4.2
triangulo1 :: Figura
triangulo1 = Triangulo 3.1 4.2 5.3
figura1 :: Figura
figura1 = rectangulo1

main :: IO ()
main = do
  print (circulo1)