{-# LANGUAGE OverloadedStrings #-}

import Database.HDBC
import Database.HDBC.PostgreSQL

-- Configuración de conexión para PostgreSQL
postgresConfig :: String
postgresConfig = "host=localhost port=5432 user=usuario password=contraseña dbname=tienda_db"

-- Función principal para PostgreSQL
mainPostgreSQL :: IO ()
mainPostgreSQL = do
    putStrLn "Paso 1: Conectando a PostgreSQL..."
    conn <- connectPostgreSQL postgresConfig

    putStrLn "Paso 2: Creando la tabla productos si no existe..."
    run conn
        "CREATE TABLE IF NOT EXISTS productos (\
        \id SERIAL PRIMARY KEY, \
        \nombre VARCHAR(100) NOT NULL, \
        \precio NUMERIC(10,2) NOT NULL, \
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

    putStrLn "Paso 7: Cerrando la conexión..."
    disconnect conn
    putStrLn "Fin del programa"

-- Las funciones auxiliares son las mismas que en la versión MySQL