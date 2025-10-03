module Main where

data Triangulo = Triangulo { base :: Float, altura :: Float }
data Cuadrado = Cuadrado { lado :: Float }
data Circulo = Circulo { radio ::  Float }

data Figuras = Triangulo | Cuadrado | Circulo deriving

main :: IO ()
main = do
  triangulo <- Triangulo 3 4
  cuadrado <- Cuadrado 5
  circulo <- Circulo
  figura1 <- triangulo