module Main where

-- Tipo Maybe ya tiene instancia de Functor
ejemploMaybe :: Maybe Int -> Maybe Int
ejemploMaybe = fmap (+1)
-- Tipo Either ya tiene instancia de Functor
ejemploEither :: Either String Int -> Either String Int
ejemploEither = fmap (*2)
-- Crea tu propio tipo y su instancia de Functor
data Resultado a = Exito a | Error String deriving Show

instance Functor Resultado where
  fmap f (Exito x) = Exito (f x)
  fmap _ (Error msg) = Error msg

-- Crea una función que transforme una lista de Resultados
transformar :: (a -> b) -> [Resultado a] -> [Resultado b]
transformar _ [] = []
transformar f (x:xs) = fmap f x : transformar f xs

main :: IO ()
main = do
  -- Los ejemplos que ya tenías
  putStrLn "--- Ejemplos con fmap ---"
  print (fmap (+1) (Exito 5))
  print (fmap (+1) (Error "problema"))

  -- --- Uso de la función transformar ---

  putStrLn "\n--- Ejemplo con transformar ---"

  -- 1. Creamos una lista que mezcla éxitos y errores
  let miLista :: [Resultado Int]
      miLista = [Exito 10, Error "Fallo de red", Exito 25, Exito 99, Error "Valor no encontrado"]

  -- 2. Imprimimos la lista original
  putStrLn "Lista original:"
  print miLista

  -- 3. Usamos la función 'transformar' y mostramos el resultado
  putStrLn "\nLista transformada:"
  print (transformar (+1) miLista)