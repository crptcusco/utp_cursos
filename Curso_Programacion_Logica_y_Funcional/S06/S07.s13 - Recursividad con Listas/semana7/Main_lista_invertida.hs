module Main where

-- importar el modulo invertirLista
import ListasFunciones (reverseList)

main :: IO ()
main = do
    let lista = [1 .. 10]
    let listaInvertida = reverseList lista
    putStrLn $ "Lista original: " ++ show lista
    putStrLn $ "Lista invertida: " ++ show listaInvertida