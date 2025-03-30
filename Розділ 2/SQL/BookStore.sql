CREATE DATABASE bookstoresystem;
USE bookstoresystem;

CREATE TABLE users (
    id            INT PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone         VARCHAR(20) NULL,
    address       TEXT NULL,
    role          ENUM('customer', 'admin') DEFAULT 'customer',
    status        ENUM('active', 'blocked') DEFAULT 'active',
    created_at    DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE books (
    id             INT PRIMARY KEY AUTO_INCREMENT,
    title          VARCHAR(255) NOT NULL,
    author         VARCHAR(255) NOT NULL,
    price          DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    rating         DECIMAL(3,2) DEFAULT 0 CHECK (rating BETWEEN 0 AND 5),
    description    TEXT NULL,
    image_url      VARCHAR(255) NULL,
    published_date DATE NULL,
    pre_order      BOOLEAN DEFAULT FALSE,
    created_at     DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE genres (
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE orders (
    id           INT PRIMARY KEY AUTO_INCREMENT,
    user_id      INT NOT NULL,
    discount_id  INT NULL,
    total_price  DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    status       ENUM('pending', 'shipped', 'completed', 'canceled') DEFAULT 'pending',
    created_at   DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (discount_id) REFERENCES discounts(id) ON DELETE SET NULL
);

CREATE TABLE order_items (
    id        INT PRIMARY KEY AUTO_INCREMENT,
    order_id  INT NOT NULL,
    book_id   INT NOT NULL,
    quantity  INT NOT NULL CHECK (quantity > 0),
    price     DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

CREATE TABLE book_discounts (
    book_id     INT NOT NULL,
    discount_id INT NOT NULL,
    PRIMARY KEY (book_id, discount_id),
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (discount_id) REFERENCES discounts(id) ON DELETE CASCADE
);

CREATE TABLE discounts (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    code            VARCHAR(50) UNIQUE NOT NULL,
    discount_percent DECIMAL(5,2) NOT NULL CHECK (discount_percent BETWEEN 0 AND 100),
    active          BOOLEAN DEFAULT TRUE,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP,
    expires_at      DATETIME NULL
);


CREATE TABLE admins (
    id          INT PRIMARY KEY AUTO_INCREMENT,
    user_id     INT UNIQUE NOT NULL,
    permissions TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE book_genres (
    book_id     INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (book_id, genre_id),
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
)

