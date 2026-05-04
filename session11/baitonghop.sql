CREATE DATABASE pg_bank;
\c pg_bank;

CREATE TABLE tai_khoan (
    id VARCHAR(10) PRIMARY KEY,
    ten_tai_khoan VARCHAR(100) NOT NULL,
    so_du DECIMAL(15,2) NOT NULL DEFAULT 0,
    trang_thai VARCHAR(20) DEFAULT 'ACTIVE',
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE giao_dich (
    id SERIAL PRIMARY KEY,
    tai_khoan_nguoi_gui VARCHAR(10),
    tai_khoan_nguoi_nhan VARCHAR(10),
    so_tien DECIMAL(15,2),
    loai_giao_dich VARCHAR(50),
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    trang_thai VARCHAR(20),
    mo_ta TEXT
);

CREATE TABLE ve_phim (
    id SERIAL PRIMARY KEY,
    suat_chieu_id VARCHAR(10),
    ten_phim VARCHAR(100),
    so_luong_con INT NOT NULL,
    gia_ve DECIMAL(10,2),
    ngay_chieu DATE
);

INSERT INTO tai_khoan (id, ten_tai_khoan, so_du, trang_thai) VALUES  
('TK001', 'Nguyen Van A', 5000000, 'ACTIVE'),
('TK002', 'Tran Thi B', 3000000, 'ACTIVE'),
('TK003', 'Le Van C', 1000000, 'LOCKED'),
('TK004', 'Pham Thi D', 2000000, 'ACTIVE'),
('TK005', 'Bank Fee Account', 0, 'ACTIVE');

INSERT INTO ve_phim (suat_chieu_id, ten_phim, so_luong_con, gia_ve, ngay_chieu) VALUES  
('SC001', 'Avengers: Endgame', 5, 80000, '2024-01-15'),
('SC002', 'Spider-Man: No Way Home', 3, 75000, '2024-01-16'),
('SC003', 'The Batman', 1, 85000, '2024-01-17');

UPDATE tai_khoan SET so_du = so_du - 1000000 WHERE id = 'TK001';
UPDAT tai_khoan SET so_du = so_du + 1000000 WHERE id = 'TK002'; 

SELECT * FROM tai_khoan WHERE id IN ('TK001', 'TK002');

BEGIN;

UPDATE tai_khoan 
SET so_du = so_du - 1000000 
WHERE id = 'TK001' AND so_du >= 1000000 AND trang_thai = 'ACTIVE';

UPDATE tai_khoan 
SET so_du = so_du + 1000000 
WHERE id = 'TK002' AND trang_thai = 'ACTIVE';

INSERT INTO giao_dich (tai_khoan_nguoi_gui, tai_khoan_nguoi_nhan, so_tien, loai_giao_dich, trang_thai, mo_ta)
VALUES ('TK001', 'TK002', 1000000, 'TRANSFER', 'SUCCESS', 'Transaction OK');

COMMIT;

SELECT * FROM tai_khoan WHERE id IN ('TK001', 'TK002');