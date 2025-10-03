module Main where

data Configuracion = Config {
  modo :: String,
  nivel :: Int,
  activado :: Bool
}

main :: IO ()
main = procesarOpciones (Config "Normal" 5 True)      

procesarOpciones :: Configuracion -> IO Configuracion
procesarOpciones config = do
  putStrLn "Opciones disponibles:"
  putStrLn "1. Cambiar modo"
  putStrLn "2. Ajustar nivel"
  putStrLn "3. Activar/Desactivar"
  putStrLn "4. Guardar y salir"

  opcion <- getLine
  case opcion of
    "1" -> do
      nuevoModo <- cambiarModo
      procesarOpciones config {modo = nuevoModo}
    "2" -> do
      nuevoNivel <- ajustarNivel
      procesarOpciones config {nivel = nuevoNivel}
    "3" -> procesarOpciones config {activado = not (activado config)}
    "4" -> return config
    _ -> do
      putStrLn "Opción inválida"
      procesarOpciones config