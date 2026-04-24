DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    email TEXT,
    username TEXT
);

INSERT INTO Users (email, username) VALUES
('a@gmail.com', 'user1'),
('b@gmail.com', 'user2'),
('example@example.com', 'user3'),
('d@gmail.com', 'user4'),
('e@gmail.com', 'user5'),
('f@gmail.com', 'user6'),
('g@gmail.com', 'user7'),
('h@gmail.com', 'user8'),
('i@gmail.com', 'user9'),
('j@gmail.com', 'user10');

CREATE INDEX idx_users_email_hash
ON Users USING HASH (email);

ANALYZE Users;

EXPLAIN
SELECT * 
FROM Users
WHERE email = 'example@example.com';