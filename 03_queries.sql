SELECT b.title, c.category_name
FROM books b
JOIN categories c ON b.category_id = c.category_id;

SELECT b.title, a.author_name
FROM books b
JOIN book_authors ba ON b.book_id = ba.book_id
JOIN authors a ON ba.author_id = a.author_id;

SELECT m.full_name, b.title, bd.due_date
FROM members m
JOIN borrow br ON m.member_id = br.member_id
JOIN borrow_details bd ON br.borrow_id = bd.borrow_id
JOIN books b ON bd.book_id = b.book_id
WHERE bd.return_date IS NULL;

SELECT b.title, bd.due_date, bd.return_date
FROM borrow_details bd
JOIN books b ON bd.book_id = b.book_id
WHERE bd.return_date > bd.due_date;

SELECT c.category_name, COUNT(b.book_id) AS total_books
FROM categories c
LEFT JOIN books b ON c.category_id = b.category_id
GROUP BY c.category_name;