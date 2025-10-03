module Main where

type Nombre = String
type Edad = Int
type Altura = Float
type Persona = (Nombre, Edad, Altura) 

personaEjemplo :: Persona
personaEjemplo = ("Juan", 25, 1.75)

main :: IO ()
main = do
  print (personaEjemplo)