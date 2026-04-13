
ALTER TABLE library.Books
ADD COLUMN genre VARCHAR(100);


ALTER TABLE library.Books
RENAME COLUMN available TO is_available;

ALTER TABLE library.Members
DROP COLUMN email;

DROP TABLE sales.OrderDetails;