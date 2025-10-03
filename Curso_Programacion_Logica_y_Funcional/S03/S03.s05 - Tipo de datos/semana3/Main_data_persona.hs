module Main where

data Persona = Persona String Int Float deriving Show
-- Uso:
persona1 :: Persona
persona1 = Persona "Maria" 54 301.65

main :: IO ()
main = do
  print (persona1)
