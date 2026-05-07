--1 tạo bảng
--Xóa bảng nếu đã tồn tại
DROP TABLE IF EXISTS Transactions CASCADE;
DROP TABLE IF EXISTS Tickets CASCADE;
DROP TABLE IF EXISTS Passengers CASCADE;
DROP TABLE IF EXISTS Trains CASCADE;

--Tạo bảng Passengers
CREATE TABLE Passengers (
    passenger_id VARCHAR(5) PRIMARY KEY,
    passenger_full_name VARCHAR(100) NOT NULL,
    passenger_email VARCHAR(100) NOT NULL UNIQUE,
    passenger_phone VARCHAR(15) NOT NULL,
    passenger_cccd VARCHAR(20) NOT NULL
);

--Tạo bảng Trains
CREATE TABLE Trains (
    train_id VARCHAR(5) PRIMARY KEY,
    train_name VARCHAR(100) NOT NULL,
    train_type VARCHAR(10) NOT NULL,
    total_seats INT NOT NULL
);

--Tạo bảng Tickets
CREATE TABLE Tickets (
    ticket_id VARCHAR(5) PRIMARY KEY,
    passenger_id VARCHAR(5) NOT NULL,
    train_id VARCHAR(5) NOT NULL,
    departure_date DATE NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_ticket_passenger
        FOREIGN KEY (passenger_id)
        REFERENCES Passengers(passenger_id),

    CONSTRAINT fk_ticket_train
        FOREIGN KEY (train_id)
        REFERENCES Trains(train_id)
);

--Tạo bảng Transactions
CREATE TABLE Transactions (
    transaction_id VARCHAR(5) PRIMARY KEY,
    ticket_id VARCHAR(5) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    transaction_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_transaction_ticket
        FOREIGN KEY (ticket_id)
        REFERENCES Tickets(ticket_id)
);

--2 chèn dữ liệu
INSERT INTO Passengers VALUES
('P001', 'Nguyen Van An', 'an.nguyen@example.com', '0912345678', '001234567890'),
('P002', 'Tran Thi Binh', 'binh.tran@example.com', '0923456789', '002345678901'),
('P003', 'Le Minh Chau', 'chau.le@example.com', '0934567890', '003456789012'),
('P004', 'Pham Quoc Dat', 'dat.pham@example.com', '0945678901', '004567890123'),
('P005', 'Vo Thanh Em', 'em.vo@example.com', '0956789012', '005678901234');
INSERT INTO Passengers VALUES
('P006', 'Nguyen Tu Anh', 'TuAnh@example.com', '0967890123', '001203456724');

INSERT INTO Trains VALUES
('T001', 'Tau Thong Nhat 1', 'SE', 500),
('T002', 'Tau Thong Nhat 2', 'TN', 450),
('T003', 'Tau Sai Gon - Hue', 'SE', 400),
('T004', 'Tau Ha Noi - Lao Cai', 'TN', 350),
('T005', 'Tau Da Nang Express', 'SE', 300);

INSERT INTO Tickets VALUES
('TK001', 'P001', 'T001', '2025-06-10', 'A01', 850000),
('TK002', 'P002', 'T002', '2025-06-11', 'B05', 650000),
('TK003', 'P003', 'T003', '2025-06-12', 'C10', 720000),
('TK004', 'P004', 'T004', '2025-06-13', 'D12', 500000),
('TK005', 'P005', 'T005', '2025-06-14', 'E08', 900000);
INSERT INTO Tickets VALUES
('TK006', 'P006', 'T001', '2025-06-14', 'A01', 900000),
('TK007', 'P006', 'T001', '2025-07-18', 'A02', 850000),
('TK008', 'P006', 'T002', '2025-04-15', 'B10', 1000000),
('TK009', 'P006', 'T002', '2025-05-15', 'B11', 1000000),
INSERT INTO Tickets VALUES
('TK010', 'P006', 'T002', '2025-06-15', 'B10', 1500000),
('TK011', 'P006', 'T002', '2025-06-15', 'B12', 1500000);



INSERT INTO Transactions VALUES
('TR001', 'TK001', 'Credit Card', '2025-06-01', 850000),
('TR002', 'TK002', 'Cash', '2025-06-02', 650000),
('TR003', 'TK003', 'Bank Transfer', '2025-06-03', 720000),
('TR004', 'TK004', 'E-Wallet', '2025-06-04', 500000),
('TR005', 'TK005', 'Credit Card', '2025-06-05', 900000);

INSERT INTO Transactions VALUES
('TR006', 'TK006', 'Credit Card', '2025-06-01', 900000),
('TR007', 'TK007', 'Bank Transfer', '2025-06-02', 850000),
('TR008', 'TK008', 'E-Wallet', '2025-04-14', 1500000),
('TR009', 'TK009', 'Bank Transfer', '2025-06-7', 1000000),
('TR011', 'TK011', 'E-Wallet', '2025-06-14', 1500000)
('TR010', 'TK010', 'E-Wallet', '2025-06-14', 1500000);

--cập nhập dữ liệu
UPDATE Tickets 
SET ticket_price = ticket_price * 0.85
WHERE departure_date < '2025-05-01'

SELECT  * FROM Tickets
WHERE departure_date < '2025-05-01';

--4 xóa dữ liệu
DELETE FROM Transactions
WHERE payment_method = 'E-Wallet'
AND amount < 2000000;

SELECT * FROM Transactions
WHERE payment_method = 'E-Wallet';

--5 Thông tin hành khách sắp xếp tên giảm dần
SELECT
    passenger_id,
    passenger_full_name,
    passenger_email,
    passenger_phone
FROM Passengers
ORDER BY passenger_full_name DESC;

--Danh sách đoàn tàu theo số ghế tăng dần
SELECT
    train_id,
    train_name,
    total_seats
FROM Trains
ORDER BY total_seats ASC;

--7 Thông tin vé đã đặt
SELECT
    p.passenger_full_name,
    t.train_name,
    tk.departure_date,
    tk.seat_number
FROM Tickets tk
JOIN Passengers p
    ON tk.passenger_id = p.passenger_id
JOIN Trains t
    ON tk.train_id = t.train_id;

--8 Hành khách và tổng tiền thanh toán
SELECT
    p.passenger_id,
    p.passenger_full_name,
    STRING_AGG(DISTINCT tr.payment_method,',') AS payment_menthod,
    SUM(tr.amount) as total_paid
FROM Passengers p
JOIN Tickets tk
    ON p.passenger_id = tk.passenger_id
JOIN Transactions tr
    ON tk.ticket_id = tr.ticket_id
Group BY 
	p.passenger_id,
	p.passenger_full_name
ORDER BY total_paid ASC;

--9 Lấy hành khách từ vị trí 3 đến 5
SELECT *
FROM Passengers
ORDER BY passenger_full_name DESC
LIMIT 3 OFFSET 2;

--10 Hành khách đặt ít nhất 3 vé
SELECT
    p.passenger_id,
    p.passenger_full_name,
    COUNT(tk.ticket_id) AS total_tickets
FROM Passengers p
JOIN Tickets tk
    ON p.passenger_id = tk.passenger_id
GROUP BY p.passenger_id, p.passenger_full_name
HAVING COUNT(tk.ticket_id) >= 3;

--11 Đoàn tàu có hơn 10 lượt khách đặt vé
SELECT
    t.train_id,
    t.train_name,
    COUNT(tk.ticket_id) AS total_bookings
FROM Trains t
JOIN Tickets tk
    ON t.train_id = tk.train_id
GROUP BY t.train_id, t.train_name
HAVING COUNT(tk.ticket_id) > 10;

--12 Hành khách có tổng giao dịch > 2 triệu
SELECT
    p.passenger_id,
    p.passenger_full_name,
    tk.train_id,
    SUM(tr.amount) AS total_amount
FROM Passengers p
JOIN Tickets tk
    ON p.passenger_id = tk.passenger_id
JOIN Transactions tr
    ON tk.ticket_id = tr.ticket_id
GROUP BY
    p.passenger_id,
    p.passenger_full_name,
    tk.train_id
HAVING SUM(tr.amount) > 2000000;

--13 Hành khách tên chứa "Hoàng" hoặc email gmail
SELECT
    passenger_id,
    passenger_full_name,
    passenger_email
FROM Passengers
WHERE passenger_full_name ILIKE '%Hoàng%'
OR passenger_email ILIKE '%@gmail.com'
ORDER BY passenger_full_name ASC;

--14 Phân trang tàu - trang 2, mỗi trang 5 dòng
INSERT INTO Trains VALUES
('T006', 'Tau Thong Nhat 4', 'SE', 500),
('T007', 'Tau Thong Nhat54', 'SE', 200);
SELECT *
FROM Trains
ORDER BY total_seats DESC
LIMIT 5 OFFSET 5;

--15 View chuyến đi sắp tới
CREATE OR REPLACE VIEW vw_UpcomingTrips AS
SELECT
    p.passenger_full_name,
    t.train_name,
    tk.seat_number,
    tk.ticket_price,
    tk.departure_date
FROM Tickets tk
JOIN Passengers p
    ON tk.passenger_id = p.passenger_id
JOIN Trains t
    ON tk.train_id = t.train_id
WHERE tk.departure_date > '2025-06-01';

SELECT * FROM vw_UpcomingTrips;

--16 View vé giá trị cao
CREATE OR REPLACE VIEW vw_HighValueTickets AS
SELECT
    p.passenger_full_name,
    t.train_name,
    tk.seat_number,
    tk.ticket_price
FROM Tickets tk
JOIN Passengers p
    ON tk.passenger_id = p.passenger_id
JOIN Trains t
    ON tk.train_id = t.train_id
WHERE tk.ticket_price > 500000;

SELECT * FROM vw_HighValueTickets;

--17 Trigger kiểm tra ngày khởi hành
CREATE OR REPLACE FUNCTION fn_check_ticket_date()
RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.departure_date < CURRENT_DATE THEN
        RAISE EXCEPTION 'Ngày khởi hành không hợp lệ';
    END IF;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tg_check_ticket_date
BEFORE INSERT ON Tickets
FOR EACH ROW
EXECUTE FUNCTION fn_check_ticket_date();

INSERT INTO Tickets VALUES
('TK019','P001','T001','2025-05-03','Z01','500000');
--18 Trigger Update tự động giảm total_seats của bảng Trains
--đi 1 khi thêm bản ghi mới
CREATE OR REPLACE FUNCTION fn_update_seats()
RETURNS TRIGGER AS
$$
BEGIN
    UPDATE Trains
    SET total_seats = total_seats - 1
    WHERE train_id = NEW.train_id;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tg_update_seats
AFTER INSERT ON Tickets
FOR EACH ROW
EXECUTE FUNCTION fn_update_seats();

SELECT
	train_id,
	train_name,
	total_seats
FROM Trains
WHERE train_id = 'T002';

INSERT INTO Tickets VALUES
('TK019','P006','T002','2026-06-014','Z01','500000');


--19 Procedure Thêm mới hành khách
CREATE OR REPLACE PROCEDURE sp_add_passenger(
    p_passenger_id VARCHAR(5),
    p_full_name VARCHAR(100),
    p_email VARCHAR(100),
    p_phone VARCHAR(15),
    p_cccd VARCHAR(20)
)
LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO Passengers(
        passenger_id,
        passenger_full_name,
        passenger_email,
        passenger_phone,
        passenger_cccd
    )
    VALUES (
        p_passenger_id,
        p_full_name,
        p_email,
        p_phone,
        p_cccd
    );
END;
$$;

CALL sp_add_passenger(
    'P007',
    'Hoang Van Long',
    'long@gmail.com',
    '0966666666',
    '006666666666'
);
--20 Procedure hủy vé

CREATE OR REPLACE PROCEDURE sp_cancel_ticket(
    p_ticket_id VARCHAR(5)
)
LANGUAGE plpgsql
AS
$$
BEGIN
    -- Xóa giao dịch
    DELETE FROM Transactions
    WHERE ticket_id = p_ticket_id;

    -- Xóa vé
    DELETE FROM Tickets
    WHERE ticket_id = p_ticket_id;
END;
$$;

CALL sp_cancel_ticket('TK001');
SELECT * From Tickets