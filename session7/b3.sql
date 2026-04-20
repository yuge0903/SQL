CREATE TABLE post (
    post_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    tags TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_public BOOLEAN DEFAULT TRUE
);

CREATE TABLE post_like (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id)
);

CREATE INDEX idx_post_content_lower 
ON post (LOWER(content));

CREATE INDEX idx_post_tags_gin 
ON post USING GIN (tags);

CREATE INDEX idx_post_recent_public 
ON post (created_at DESC) 
WHERE is_public = TRUE;

CREATE INDEX idx_post_user_recent 
ON post (user_id, created_at DESC);

CREATE INDEX idx_post_user_id ON post (user_id);


CREATE INDEX idx_post_is_public ON post (is_public);

EXPLAIN ANALYZE
SELECT * FROM post 
WHERE is_public = TRUE 
  AND content ILIKE '%du lich%';

EXPLAIN ANALYZE
SELECT * FROM post 
WHERE is_public = TRUE 
  AND LOWER(content) LIKE LOWER('%du lich%');


EXPLAIN ANALYZE
SELECT * FROM post 
WHERE tags @> ARRAY['travel'];


EXPLAIN ANALYZE
SELECT * FROM post 
WHERE is_public = TRUE 
  AND created_at >= NOW() - INTERVAL '7 days'
ORDER BY created_at DESC;


EXPLAIN ANALYZE
SELECT * FROM post 
WHERE user_id IN (101, 102, 103, 104) 
  AND is_public = TRUE
ORDER BY created_at DESC 
LIMIT 20;