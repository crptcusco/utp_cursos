{-# LANGUAGE OverloadedStrings #-}

import Database.HDBC
import Database.HDBC.Sqlite3

-- Funcion principal
main :: IO ()
main = do
    putStrLn "Paso 1: Conectando a la base de datos..."
    conn <- connectSqlite3 "tienda.db"

    putStrLn "Paso 2: Creando la tabla productos si no existe..."
    run conn
        "CREATE TABLE IF NOT EXISTS productos (\
        \id INTEGER PRIMARY KEY AUTOINCREMENT, \
        \nombre TEXT NOT NULL, \
        \precio REAL NOT NULL, \
        \stock INTEGER NOT NULL)"
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

    putStrLn "Paso 7: Cerrando la conexion..."
    disconnect conn
    putStrLn "Fin del programa"
    

-- Funcion para insertar varios productos
insertarProductos :: Connection -> IO ()
insertarProductos conn = do
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Laptop" :: String), toSql (2500.0 :: Double), toSql (10 :: Int)]
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Mouse" :: String), toSql (50.0 :: Double), toSql (100 :: Int)]
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Teclado" :: String), toSql (120.0 :: Double), toSql (50 :: Int)]
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Monitor" :: String), toSql (800.0 :: Double), toSql (20 :: Int)]
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Impresora" :: String), toSql (600.0 :: Double), toSql (15 :: Int)]
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Tablet" :: String), toSql (1500.0 :: Double), toSql (25 :: Int)]
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Smartphone" :: String), toSql (2000.0 :: Double), toSql (30 :: Int)]
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Cargador" :: String), toSql (80.0 :: Double), toSql (60 :: Int)]
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Audifonos" :: String), toSql (300.0 :: Double), toSql (40 :: Int)]
    run conn "INSERT INTO productos (nombre, precio, stock) VALUES (?, ?, ?)"
        [toSql ("Camara Web" :: String), toSql (400.0 :: Double), toSql (12 :: Int)]
    putStrLn "Productos insertados"

-- Funcion para mostrar productos
mostrarProductos :: Connection -> IO ()
mostrarProductos conn = do
    putStrLn "Consultando productos..."
    rows <- quickQuery' conn "SELECT id, nombre, precio, stock FROM productos" []
    mapM_ imprimirFila rows

-- Imprimir una fila
imprimirFila :: [SqlValue] -> IO ()
imprimirFila [sqlId, sqlNombre, sqlPrecio, sqlStock] = do
    putStrLn $ "ID: " ++ fromSql sqlId
             ++ " | Nombre: " ++ fromSql sqlNombre
             ++ " | Precio: " ++ show (fromSql sqlPrecio :: Double)
             ++ " | Stock: " ++ show (fromSql sqlStock :: Int)
imprimirFila _ = putStrLn "Fila con formato inesperado"

-- Funcion para actualizar un producto
actualizarProducto :: Connection -> Int -> String -> Double -> Int -> IO ()
actualizarProducto conn id nombre precio stock = do
    run conn "UPDATE productos SET nombre = ?, precio = ?, stock = ? WHERE id = ?"
        [toSql nombre, toSql precio, toSql stock, toSql id]
    putStrLn $ "Producto con id " ++ show id ++ " actualizado"

-- Funcion para eliminar un producto
eliminarProducto :: Connection -> Int -> IO ()
eliminarProducto conn id = do
    run conn "DELETE FROM productos WHERE id = ?" [toSql id]
    putStrLn $ "Producto con id " ++ show id ++ " eliminado"
