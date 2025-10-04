{-# LANGUAGE OverloadedStrings #-}

import Database.HDBC
import System.Environment (getArgs)
import System.Exit (exitFailure)

-- Configuraciones
mysqlConfig :: ConnectInfo
mysqlConfig = defaultConnectInfo {
    connectHost = "localhost",
    connectPort = 3306,
    connectUser = "usuario",
    connectPassword = "contraseña",
    connectDatabase = "tienda_db"
}

postgresConfig :: String
postgresConfig = "host=localhost port=5432 user=usuario password=contraseña dbname=tienda_db"

-- Función principal con selección de BD
main :: IO ()
main = do
    args <- getArgs
    case args of
        ["mysql"] -> mainMySQL
        ["postgresql"] -> mainPostgreSQL
        _ -> do
            putStrLn "Uso: programa [mysql|postgresql]"
            exitFailure

-- Versión mejorada con manejo de errores
mainMySQL :: IO ()
mainMySQL = do
    putStrLn "Conectando a MySQL..."
    result <- try (connect mysqlConfig) :: IO (Either SomeException Connection)
    case result of
        Left ex -> do
            putStrLn $ "Error conectando a MySQL: " ++ show ex
            putStrLn "Asegúrate de que:"
            putStrLn "1. MySQL esté ejecutándose"
            putStrLn "2. La base de datos 'tienda_db' exista"
            putStrLn "3. Las credenciales sean correctas"
        Right conn -> do
            ejecutarOperacionesBD conn
            disconnect conn

mainPostgreSQL :: IO ()
mainPostgreSQL = do
    putStrLn "Conectando a PostgreSQL..."
    result <- try (connectPostgreSQL postgresConfig) :: IO (Either SomeException Connection)
    case result of
        Left ex -> do
            putStrLn $ "Error conectando a PostgreSQL: " ++ show ex
            putStrLn "Asegúrate de que:"
            putStrLn "1. PostgreSQL esté ejecutándose"
            putStrLn "2. La base de datos 'tienda_db' exista"
            putStrLn "3. Las credenciales sean correctas"
        Right conn -> do
            ejecutarOperacionesBD conn
            disconnect conn

-- Operaciones comunes a ambas bases de datos
ejecutarOperacionesBD :: Connection -> IO ()
ejecutarOperacionesBD conn = do
    crearTabla conn
    insertarProductosEjemplo conn
    mostrarProductos conn
    actualizarProducto conn 1 "Laptop Gamer" 3500.0 5
    mostrarProductos conn
    eliminarProducto conn 2
    mostrarProductos conn

crearTabla :: Connection -> IO ()
crearTabla conn = do
    putStrLn "Creando tabla productos..."
    run conn "DROP TABLE IF EXISTS productos" []
    run conn
        "CREATE TABLE productos (\
        \id SERIAL PRIMARY KEY, \
        \nombre VARCHAR(100) NOT NULL, \
        \precio NUMERIC(10,2) NOT NULL, \
        \stock INTEGER NOT NULL)"
        []
    commit conn
    putStrLn "Tabla creada exitosamente"

insertarProductosEjemplo :: Connection -> IO ()
insertarProductosEjemplo conn = do
    putStrLn "Insertando productos de ejemplo..."
    let productos = [
            ("Laptop", 2500.0, 10),
            ("Mouse", 50.0, 100),
            ("Teclado", 120.0, 50),
            ("Monitor", 800.0, 20),
            ("Impresora", 600.0, 15)
            ]
    mapM_ (insertarProducto conn) productos
    commit conn
    putStrLn "Productos insertados"

insertarProducto :: Connection -> (String, Double, Int) -> IO ()
insertarProducto conn (nombre, precio, stock) = do
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql nombre, toSql precio, toSql stock]