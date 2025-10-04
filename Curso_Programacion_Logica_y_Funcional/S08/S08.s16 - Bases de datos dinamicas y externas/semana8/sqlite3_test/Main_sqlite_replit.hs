module Main where

import System.Process
import System.Exit
import Control.Exception (try, SomeException)

-- Simple SQLite connection example using system calls
-- This approach uses the system's sqlite3 command-line tool
main :: IO ()
main = do
  putStrLn "=== Simple SQLite Connection Example ==="
  putStrLn "Using system sqlite3 command-line tool\n"

  -- Check if sqlite3 is available
  result <- try $ readProcess "sqlite3" ["--version"] ""
  case result :: Either SomeException String of
    Left _ -> putStrLn "❌ SQLite is not available on this system"
    Right version -> do
      putStrLn $ "✓ SQLite version: " ++ init version

      -- Create a simple database and table
      putStrLn "\n--- Creating database and table ---"
      _ <- system "sqlite3 example.db 'CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT, email TEXT);'"
      putStrLn "✓ Created users table"

      -- Insert sample data
      putStrLn "\n--- Inserting sample data ---"
      _ <- system "sqlite3 example.db \"INSERT OR REPLACE INTO users (id, name, email) VALUES (1, 'Alice Johnson', 'alice@example.com');\""
      _ <- system "sqlite3 example.db \"INSERT OR REPLACE INTO users (id, name, email) VALUES (2, 'Bob Smith', 'bob@example.com');\""
      _ <- system "sqlite3 example.db \"INSERT OR REPLACE INTO users (id, name, email) VALUES (3, 'Carol Davis', 'carol@example.com');\""
      putStrLn "✓ Inserted sample users"

      -- Query data
      putStrLn "\n--- Querying all users ---"
      output <- readProcess "sqlite3" ["example.db", "SELECT * FROM users;"] ""
      putStrLn output

      -- Count users
      countOutput <- readProcess "sqlite3" ["example.db", "SELECT COUNT(*) FROM users;"] ""
      putStrLn $ "Total users: " ++ init countOutput

      putStrLn "\n✓ SQLite connection example completed successfully!"
      putStrLn "Database file 'example.db' has been created in the current directory."

-- Helper to demonstrate more advanced Haskell SQLite patterns
-- (for when you have access to sqlite-simple library)
sqliteConnectionInfo :: IO ()
sqliteConnectionInfo = do
  putStrLn "\n=== For Production Haskell SQLite Development ==="
  putStrLn "To use a proper Haskell SQLite library, add to your .cabal file:"
  putStrLn "  build-depends: sqlite-simple >= 0.4.18.0"
  putStrLn "                , text >= 1.2"
  putStrLn ""
  putStrLn "Then import: import Database.SQLite.Simple"
  putStrLn ""
  putStrLn "Example code:"
  putStrLn "  conn <- open \"database.db\""
  putStrLn "  execute conn \"CREATE TABLE users (id INTEGER, name TEXT)\" ()"
  putStrLn "  execute conn \"INSERT INTO users VALUES (?, ?)\" (1 :: Int, \"Alice\" :: String)"
  putStrLn "  users <- query_ conn \"SELECT * FROM users\" :: IO [(Int, String)]"
  putStrLn "  close conn"