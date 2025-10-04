module Main where

import System.Process

-- Funcion principal
main :: IO ()
main = do
    putStrLn "Paso 1: Conectando a la base de datos..."
    
    putStrLn "Paso 2: Creando la tabla productos si no existe..."
    _ <- system "sqlite3 tienda.db 'CREATE TABLE IF NOT EXISTS productos (id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT NOT NULL, precio REAL NOT NULL, stock INTEGER NOT NULL);'"
    putStrLn "Tabla lista"

    putStrLn "Paso 3: Insertando productos de ejemplo..."
    insertarProductos
    
    putStrLn "Paso 4: Mostrando todos los productos..."
    mostrarProductos

    putStrLn "Paso 5: Actualizando un producto..."
    actualizarProducto 1 "Laptop Gamer" 3500.0 5
    mostrarProductos

    putStrLn "Paso 6: Eliminando un producto..."
    eliminarProducto 2
    mostrarProductos

    putStrLn "Paso 7: Cerrando la conexion..."
    putStrLn "Fin del programa"


-- Funcion para insertar varios productos
insertarProductos :: IO ()
insertarProductos = do
    _ <- system "sqlite3 tienda.db \"INSERT INTO productos (nombre, precio, stock) VALUES ('Laptop', 2500.0, 10);\""
    _ <- system "sqlite3 tienda.db \"INSERT INTO productos (nombre, precio, stock) VALUES ('Mouse', 50.0, 100);\""
    _ <- system "sqlite3 tienda.db \"INSERT INTO productos (nombre, precio, stock) VALUES ('Teclado', 120.0, 50);\""
    _ <- system "sqlite3 tienda.db \"INSERT INTO productos (nombre, precio, stock) VALUES ('Monitor', 800.0, 20);\""
    _ <- system "sqlite3 tienda.db \"INSERT INTO productos (nombre, precio, stock) VALUES ('Impresora', 600.0, 15);\""
    _ <- system "sqlite3 tienda.db \"INSERT INTO productos (nombre, precio, stock) VALUES ('Tablet', 1500.0, 25);\""
    _ <- system "sqlite3 tienda.db \"INSERT INTO productos (nombre, precio, stock) VALUES ('Smartphone', 2000.0, 30);\""
    _ <- system "sqlite3 tienda.db \"INSERT INTO productos (nombre, precio, stock) VALUES ('Cargador', 80.0, 60);\""
    _ <- system "sqlite3 tienda.db \"INSERT INTO productos (nombre, precio, stock) VALUES ('Audifonos', 300.0, 40);\""
    _ <- system "sqlite3 tienda.db \"INSERT INTO productos (nombre, precio, stock) VALUES ('Camara Web', 400.0, 12);\""
    putStrLn "Productos insertados"

-- Funcion para mostrar productos
mostrarProductos :: IO ()
mostrarProductos = do
    putStrLn "Consultando productos..."
    output <- readProcess "sqlite3" ["tienda.db", "SELECT id, nombre, precio, stock FROM productos;"] ""
    if null output
        then putStrLn "No hay productos"
        else putStrLn output

-- Funcion para actualizar un producto
actualizarProducto :: Int -> String -> Double -> Int -> IO ()
actualizarProducto idProd nombre precio stock = do
    let query = "UPDATE productos SET nombre = '" ++ nombre ++ "', precio = " ++ show precio ++ ", stock = " ++ show stock ++ " WHERE id = " ++ show idProd ++ ";"
    _ <- system $ "sqlite3 tienda.db \"" ++ query ++ "\""
    putStrLn $ "Producto con id " ++ show idProd ++ " actualizado"

-- Funcion para eliminar un producto
eliminarProducto :: Int -> IO ()
eliminarProducto idProd = do
    let query = "DELETE FROM productos WHERE id = " ++ show idProd ++ ";"
    _ <- system $ "sqlite3 tienda.db \"" ++ query ++ "\""
    putStrLn $ "Producto con id " ++ show idProd ++ " eliminado"
