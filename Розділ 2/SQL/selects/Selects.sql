USE bookstoresystem;

-- Перегляд каталогу книг за жанрами (категоріями)
SELECT b.*
FROM books AS b
JOIN book_genres AS bg ON b.id = bg.book_id
JOIN genres AS g ON bg.genre_id = g.id
WHERE g.name = 'Literature & Fiction';

-- Пошук за назвою або автором
SELECT *
FROM books
WHERE title LIKE '%Theoretic%' OR author LIKE '%Richard%';

-- Фільтрація та сортування (за ціною, жанром, рейтингом)
SELECT b.*
FROM books b
JOIN book_genres bg ON b.id = bg.book_id
JOIN genres g ON bg.genre_id = g.id
WHERE g.name = 'Business & Money' AND b.price BETWEEN 2 AND 500
ORDER BY b.rating DESC;

-- Перевірка вмісту кошика (тобто orders.status = 'pending' і ще не оформлене)
SELECT 
	b.title, 
    oi.quantity, 
    oi.price, 
    (oi.price * oi.quantity) AS total
FROM order_items oi
JOIN books b ON oi.book_id = b.id
JOIN orders o ON oi.order_id = o.id
WHERE o.user_id = 56 AND o.status = 'pending';

-- Перегляд історії замовлень та статусів
SELECT 
	o.id AS order_id, 
    o.created_at, 
	o.status, 
	o.total_price, 
    d.code AS discount_code
FROM orders o
LEFT JOIN discounts d ON o.discount_id = d.id
WHERE o.user_id = 56
ORDER BY o.created_at DESC; 

-- Перегляд книг з можливістю передзамовлення
SELECT *
FROM books
WHERE pre_order = TRUE;

SELECT 
    b.id,
    b.title,
    b.price AS original_price,
    d.discount_percent,
    ROUND(b.price * (1 - d.discount_percent / 100), 2) AS discounted_price
FROM books b
JOIN book_discounts bd ON b.id = bd.book_id
JOIN discounts d ON bd.discount_id = d.id
WHERE d.active = TRUE
  AND (d.expires_at IS NULL OR d.expires_at > NOW());
  
-- Топ популярних книжок (за кількістю покупок)
SELECT 
    b.id,
    b.title,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM books b
JOIN order_items oi ON b.id = oi.book_id
JOIN orders o ON oi.order_id = o.id
WHERE o.status IN ('shipped', 'completed') -- тільки виконані замовлення
GROUP BY b.id, b.title
ORDER BY total_sold DESC
LIMIT 10;

-- Фільтрація книг зі знижками з урахуванням жанру, рейтингу та сортування за зниженою ціною
SELECT 
    b.id,
    b.title,
    b.author,
    b.rating,
    g.name AS genre,
    b.price AS original_price,
    d.discount_percent,
    ROUND(b.price * (1 - d.discount_percent / 100), 2) AS discounted_price
FROM books b
JOIN book_discounts bd ON b.id = bd.book_id
JOIN discounts d ON bd.discount_id = d.id
JOIN book_genres bg ON b.id = bg.book_id
JOIN genres g ON bg.genre_id = g.id
WHERE d.active = TRUE
  AND (d.expires_at IS NULL OR d.expires_at > NOW())
  AND g.name = 'Business & Money' -- фільтр по жанру
  AND b.rating >= 4.0       -- фільтр по рейтингу
ORDER BY discounted_price ASC; -- сортування: від дешевших


