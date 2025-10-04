{-# LANGUAGE OverloadedStrings #-}

import Database.HDBC
import Database.HDBC.MySQL

-- Configuración de conexión para MySQL
mysqlConfig :: ConnectInfo
mysqlConfig = defaultConnectInfo {
    connectHost = "localhost",
    connectPort = 3306,
    connectUser = "usuario",
    connectPassword = "contraseña",
    connectDatabase = "tienda_db"
}

-- Función principal para MySQL
mainMySQL :: IO ()
mainMySQL = do
    putStrLn "Paso 1: Conectando a MySQL..."
    conn <- connect mysqlConfig

    putStrLn "Paso 2: Creando la tabla productos si no existe..."
    run conn
        "CREATE TABLE IF NOT EXISTS productos (\
        \id INT AUTO_INCREMENT PRIMARY KEY, \
        \nombre VARCHAR(100) NOT NULL, \
        \precio DECIMAL(10,2) NOT NULL, \
        \stock INT NOT NULL)"
        []
    commit conn
    putStrLn "Tabla lista"

    putStrLn "Paso 3: Insertando productos de ejemplo..."
    insertarProductos conn
    commit conn

    putStrLn "Paso 4: Mostrando todos los productos..."
    mostrarProductos conn

    putStrLn "Paso 5: Actualizando un producto..."
    actualizarProducto conn 1 "Laptop Gamer" 3500.0 5
    commit conn
    mostrarProductos conn

    putStrLn "Paso 6: Eliminando un producto..."
    eliminarProducto conn 2
    commit conn
    mostrarProductos conn

    putStrLn "Paso 7: Cerrando la conexión..."
    disconnect conn
    putStrLn "Fin del programa"

-- Funciones auxiliares (iguales para MySQL y PostgreSQL)
insertarProductos :: Connection -> IO ()
insertarProductos conn = do
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Laptop" :: String), toSql (2500.0 :: Double), toSql (10 :: Int)]
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Mouse" :: String), toSql (50.0 :: Double), toSql (100 :: Int)]
    -- ... resto de inserciones igual que antes
    putStrLn "Productos insertados"

mostrarProductos :: Connection -> IO ()
mostrarProductos conn = do
    putStrLn "Consultando productos..."
    rows <- quickQuery' conn "SELECT id, nombre, precio, stock FROM productos ORDER BY id" []
    mapM_ imprimirFila rows

imprimirFila :: [SqlValue] -> IO ()
imprimirFila [sqlId, sqlNombre, sqlPrecio, sqlStock] = do
    putStrLn $ "ID: " ++ fromSql sqlId
             ++ " | Nombre: " ++ fromSql sqlNombre
             ++ " | Precio: " ++ show (fromSql sqlPrecio :: Double)
             ++ " | Stock: " ++ show (fromSql sqlStock :: Int)
imprimirFila _ = putStrLn "Fila con formato inesperado"

actualizarProducto :: Connection -> Int -> String -> Double -> Int -> IO ()
actualizarProducto conn id nombre precio stock = do
    run conn "UPDATE productos SET nombre = ?, precio = ?, stock = ? WHERE id = ?"
        [toSql nombre, toSql precio, toSql stock, toSql id]
    putStrLn $ "Producto con id " ++ show id ++ " actualizado"

eliminarProducto :: Connection -> Int -> IO ()
eliminarProducto conn id = do
    run conn "DELETE FROM productos WHERE id = ?" [toSql id]
    putStrLn $ "Producto con id " ++ show id ++ " eliminado"