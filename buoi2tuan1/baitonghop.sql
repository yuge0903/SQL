DROP TABLE IF EXISTS borrowing_items CASCADE;
DROP TABLE IF EXISTS borrowings CASCADE;
DROP TABLE IF EXISTS book_authors CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS authors CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS publishers CASCADE;
DROP TABLE IF EXISTS members CASCADE;

CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    address TEXT,
    status VARCHAR(10) CHECK (status IN ('active','inactive')) NOT NULL,
    join_date DATE NOT NULL
);

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    biography TEXT
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,
    publisher_name VARCHAR(150) NOT NULL
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(200) NOT NULL,
    published_year INTEGER,
    publisher_id INTEGER,
    category_id INTEGER,
    total_copies INTEGER NOT NULL,
    available_copies INTEGER NOT NULL,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE book_authors (
    book_id INTEGER,
    author_id INTEGER,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

CREATE TABLE borrowings (
    borrowing_id SERIAL PRIMARY KEY,
    member_id INTEGER NOT NULL,
    borrow_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE borrowing_items (
    borrowing_item_id SERIAL PRIMARY KEY,
    borrowing_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    FOREIGN KEY (borrowing_id) REFERENCES borrowings(borrowing_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO members (full_name, email, phone, birth_date, address, status, join_date)
VALUES
('Nguyen Van A', 'vana@email.com', '0901234567', '1995-03-10', 'Ha Noi', 'active', '2024-01-10'),
('Tran Thi B', 'thib@email.com', '0912345678', '1998-07-21', 'Da Nang', 'active', '2024-02-05'),
('Le Van C', 'vanc@email.com', '0923456789', '1992-11-15', 'Ho Chi Minh', 'inactive', '2024-03-01');

INSERT INTO authors (author_name, biography)
VALUES
('J.K. Rowling', 'Author of Harry Potter'),
('George Orwell', 'Author of 1984'),
('Haruki Murakami', 'Japanese novelist');

INSERT INTO categories (category_name, description)
VALUES
('Fantasy', 'Fantasy books'),
('Dystopian', 'Dystopian fiction'),
('Novel', 'General novels');

INSERT INTO publishers (publisher_name)
VALUES
('Bloomsbury'),
('Penguin Books'),
('Vintage');

INSERT INTO books (isbn, title, published_year, publisher_id, category_id, total_copies, available_copies)
VALUES
('9780747532743', 'Harry Potter and the Philosopher''s Stone', 1997, 1, 1, 10, 8),
('9780451524935', '1984', 1949, 2, 2, 7, 5),
('9780099448761', 'Kafka on the Shore', 2002, 3, 3, 5, 5);

INSERT INTO book_authors (book_id, author_id)
VALUES
(1,1),
(2,2),
(3,3);

INSERT INTO borrowings (member_id, borrow_date, due_date, return_date)
VALUES
(1, '2024-04-01', '2024-04-15', NULL),
(2, '2024-04-03', '2024-04-17', NULL),
(3, '2024-04-05', '2024-04-19', '2024-04-10');

INSERT INTO borrowing_items (borrowing_id, book_id)
VALUES
(1,1),
(1,2),
(2,3),
(3,2);

SELECT * FROM members;