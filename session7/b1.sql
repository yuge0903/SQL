DROP TABLE IF EXISTS book;

CREATE TABLE book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(10,2),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO book (title, author, genre, price, description) VALUES
('Harry Potter 1', 'J.K. Rowling', 'Fantasy', 19.99, 'Magic school and adventure'),
('Harry Potter 2', 'J.K. Rowling', 'Fantasy', 21.99, 'Wizard world continues'),
('Game of Thrones', 'George R.R. Martin', 'Fantasy', 25.50, 'Epic fantasy story'),
('Norwegian Wood', 'Haruki Murakami', 'Drama', 15.20, 'Love and loss story'),
('Kafka on the Shore', 'Haruki Murakami', 'Drama', 18.75, 'Surreal journey'),
('Dune', 'Frank Herbert', 'Sci-Fi', 22.00, 'Desert planet and politics'),
('Foundation', 'Isaac Asimov', 'Sci-Fi', 20.00, 'Future and science'),
('Dracula', 'Bram Stoker', 'Horror', 14.99, 'Classic vampire story'),
('IT', 'Stephen King', 'Horror', 23.45, 'Scary clown horror'),
('Pride and Prejudice', 'Jane Austen', 'Romance', 12.99, 'Classic love story');

EXPLAIN ANALYZE
SELECT * FROM book WHERE genre = 'Fantasy';

EXPLAIN ANALYZE
SELECT * FROM book WHERE author ILIKE '%Rowling%';

CREATE INDEX idx_book_genre
ON book (genre);
EXPLAIN ANALYZE
SELECT * FROM book WHERE genre = 'Fantasy';

CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE INDEX idx_book_author_trgm
ON book USING GIN (author gin_trgm_ops);
EXPLAIN ANALYZE
SELECT * FROM book WHERE author ILIKE '%Rowling%';

CREATE INDEX idx_book_fulltext
ON book USING GIN (
    to_tsvector('english', title || ' ' || description)
);
EXPLAIN ANALYZE
SELECT *
FROM book
WHERE to_tsvector('english', title || ' ' || description)
      @@ to_tsquery('english', 'magic');

CREATE INDEX idx_book_genre_cluster
ON book (genre);

CLUSTER book USING idx_book_genre_cluster;