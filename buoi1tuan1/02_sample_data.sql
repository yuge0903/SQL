INSERT INTO categories (category_name, description) VALUES
('Science','Science books'),
('Technology','Technology books'),
('History','Historical books'),
('Literature','Literary works'),
('Education','Educational books'),
('Psychology','Psychology books'),
('Business','Business books'),
('Art','Art books'),
('Health','Health books'),
('Travel','Travel books');

INSERT INTO authors (author_name, biography) VALUES
('Stephen Hawking','Famous physicist'),
('Yuval Noah Harari','Historian and author'),
('Robert Kiyosaki','Business author'),
('J.K. Rowling','Harry Potter author'),
('Dale Carnegie','Self development author'),
('Malcolm Gladwell','Journalist and author'),
('Walter Isaacson','Biography writer'),
('Paulo Coelho','Brazilian novelist'),
('Dan Brown','Thriller writer'),
('Adam Grant','Psychology author');

INSERT INTO books (title, publish_year, quantity, category_id) VALUES
('A Brief History of Time',1988,10,1),
('Sapiens',2011,8,3),
('Rich Dad Poor Dad',1997,12,7),
('Harry Potter',1997,20,4),
('How to Win Friends',1936,9,5),
('Outliers',2008,7,6),
('Steve Jobs',2011,5,3),
('The Alchemist',1988,11,4),
('Da Vinci Code',2003,6,4),
('Think Again',2021,10,6);

INSERT INTO books (title, publish_year, quantity, category_id) VALUES
('A Brief History of Time',1988,10,1),
('Sapiens',2011,8,3),
('Rich Dad Poor Dad',1997,12,7),
('Harry Potter',1997,20,4),
('How to Win Friends',1936,9,5),
('Outliers',2008,7,6),
('Steve Jobs',2011,5,3),
('The Alchemist',1988,11,4),
('Da Vinci Code',2003,6,4),
('Think Again',2021,10,6);

INSERT INTO members (full_name,birth_date,address,phone,email,register_date,status) VALUES
('Nguyen Van A','2000-01-01','Hanoi','0900000001','a@gmail.com','2024-01-01','active'),
('Tran Van B','1999-02-02','Hanoi','0900000002','b@gmail.com','2024-01-02','active'),
('Le Van C','1998-03-03','Hanoi','0900000003','c@gmail.com','2024-01-03','active'),
('Pham Van D','2001-04-04','Hanoi','0900000004','d@gmail.com','2024-01-04','active'),
('Hoang Van E','2002-05-05','Hanoi','0900000005','e@gmail.com','2024-01-05','active'),
('Vu Van F','2000-06-06','Hanoi','0900000006','f@gmail.com','2024-01-06','active'),
('Dang Van G','2001-07-07','Hanoi','0900000007','g@gmail.com','2024-01-07','active'),
('Bui Van H','2002-08-08','Hanoi','0900000008','h@gmail.com','2024-01-08','active'),
('Do Van I','2003-09-09','Hanoi','0900000009','i@gmail.com','2024-01-09','active'),
('Ngo Van K','2004-10-10','Hanoi','0900000010','k@gmail.com','2024-01-10','active');

INSERT INTO members (full_name,birth_date,address,phone,email,register_date,status) VALUES
('Nguyen Van A','2000-01-01','Hanoi','0900000001','a@gmail.com','2024-01-01','active'),
('Tran Van B','1999-02-02','Hanoi','0900000002','b@gmail.com','2024-01-02','active'),
('Le Van C','1998-03-03','Hanoi','0900000003','c@gmail.com','2024-01-03','active'),
('Pham Van D','2001-04-04','Hanoi','0900000004','d@gmail.com','2024-01-04','active'),
('Hoang Van E','2002-05-05','Hanoi','0900000005','e@gmail.com','2024-01-05','active'),
('Vu Van F','2000-06-06','Hanoi','0900000006','f@gmail.com','2024-01-06','active'),
('Dang Van G','2001-07-07','Hanoi','0900000007','g@gmail.com','2024-01-07','active'),
('Bui Van H','2002-08-08','Hanoi','0900000008','h@gmail.com','2024-01-08','active'),
('Do Van I','2003-09-09','Hanoi','0900000009','i@gmail.com','2024-01-09','active'),
('Ngo Van K','2004-10-10','Hanoi','0900000010','k@gmail.com','2024-01-10','active');

INSERT INTO borrow (member_id, borrow_date) VALUES
(1,'2024-02-01'),
(2,'2024-02-02'),
(3,'2024-02-03'),
(4,'2024-02-04'),
(5,'2024-02-05'),
(6,'2024-02-06'),
(7,'2024-02-07'),
(8,'2024-02-08'),
(9,'2024-02-09'),
(10,'2024-02-10');

INSERT INTO borrow_details (borrow_id,book_id,due_date,return_date,fine) VALUES
(1,1,'2024-02-10','2024-02-09',0),
(2,2,'2024-02-11','2024-02-12',5),
(3,3,'2024-02-12','2024-02-12',0),
(4,4,'2024-02-13',NULL,0),
(5,5,'2024-02-14','2024-02-15',3),
(6,6,'2024-02-15',NULL,0),
(7,7,'2024-02-16','2024-02-16',0),
(8,8,'2024-02-17','2024-02-18',4),
(9,9,'2024-02-18',NULL,0),
(10,10,'2024-02-19','2024-02-19',0);

INSERT INTO book_authors (book_id, author_id) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);