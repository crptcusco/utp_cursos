module Main where

main :: IO ()
main = menuMatematicas

menuMatematicas :: IO ()
menuMatematicas = do
  putStrLn "\n=== CALCULADORA RECURSIVA==="
  putStrLn "1. Factorial"
  putStrLn "2. Fibonacci"
  putStrLn "3. Sumatoria"
  putStrLn "4. Salir"
  putStr "Opción: "
  opcion <- getLine

  case opcion of
    "1" -> do calcularFactorial; menuMatematicas
    "2" -> do calcularFibonacci; menuMatematicas
    "3" -> do calcularSumatoria; menuMatematicas
    "4" -> putStrLn "Fin del programa"
    _ -> do putStrLn "Error: opción no válida";
            menuMatematicas

calcularFactorial :: IO ()
calcularFactorial = do
  putStr "Ingrese número: "
  n <- readLn
  putStrLn $ "Factorial: " ++ show (factorial n)

factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)

calcularFibonacci :: IO ()
calcularFibonacci = do
  putStr "Calcular Fibonacci: "

calcularSumatoria :: IO ()
calcularSumatoria = do
  putStr "Calcular Sumatoria: "