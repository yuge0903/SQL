CREATE SCHEMA library;

CREATE TABLE library.books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(50) NOT NULL,
    published_year INT,
    price REAL
);
SELECT datname FROM pg_database;

SELECT schema_name
FROM information_schema.schemata;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'books';
