-- Додавання книги
INSERT INTO books (title, author, price, stock_quantity, description, image_url, published_date, pre_order)
VALUES ('Назва книги', 'Автор', 299.99, 100, 'Опис книги', 'img/book.jpg', '2025-06-01', FALSE);
-- Додавання жанру
INSERT INTO book_genres (book_id, genre_id)
VALUES (LAST_INSERT_ID(), 3);

-- Редагування книги
UPDATE books
SET price = 249.99,
    stock_quantity = 150,
    description = 'Оновлений опис'
WHERE id = 10;

-- Видалення книги
DELETE FROM books
WHERE id = 10;

-- Обробка та зміна статусів замовлень
UPDATE orders
SET status = 'shipped'
WHERE id = 25;

-- Управління користувачами: Блокування
UPDATE users
SET status = 'blocked'
WHERE id = 7;

-- Управління користувачами: Видалення
DELETE FROM users
WHERE id = 7;

-- Генерація звітів: Продажі по кожній книжці
SELECT 
    b.id,
    b.title,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.price * oi.quantity) AS revenue
FROM books b
JOIN order_items oi ON b.id = oi.book_id
JOIN orders o ON oi.order_id = o.id
WHERE o.status IN ('shipped', 'completed')
GROUP BY b.id, b.title
ORDER BY revenue DESC;

-- Генерація звітів: Залишки товарів (stock)
SELECT id, title, stock_quantity
FROM books
ORDER BY stock_quantity ASC;

-- Налаштування знижок, акцій, промокодів: Додати знижку
INSERT INTO discounts (code, discount_percent, expires_at)
VALUES ('SPRING25', 25.00, '2025-05-01');

-- Налаштування знижок, акцій, промокодів: Прив'язка знижки до книги
INSERT INTO book_discounts (book_id, discount_id)
VALUES (10, 2);

-- Налаштування знижок, акцій, промокодів: Деактивація знижки
UPDATE discounts
SET active = FALSE
WHERE id = 2;
