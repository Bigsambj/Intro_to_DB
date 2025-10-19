-- File: alx_book_store.sql
-- Creates alx_book_store database and tables for an online bookstore

CREATE DATABASE IF NOT EXISTS alx_book_store
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci;
USE alx_book_store;

-- Authors table
CREATE TABLE IF NOT EXISTS Authors (
    author_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    author_name VARCHAR(215) NOT NULL,
    PRIMARY KEY (author_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Books table
CREATE TABLE IF NOT EXISTS Books (
    book_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    title VARCHAR(130) NOT NULL,
    author_id BIGINT UNSIGNED NOT NULL,
    price DOUBLE NOT NULL DEFAULT 0.0,
    publication_date DATE NULL,
    PRIMARY KEY (book_id),
    INDEX idx_books_author_id (author_id),
    CONSTRAINT fk_books_authors
        FOREIGN KEY (author_id)
        REFERENCES Authors (author_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Customers table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215) NULL,
    address TEXT NULL,
    PRIMARY KEY (customer_id),
    UNIQUE KEY uq_customers_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Orders table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Order_Details table
CREATE TABLE IF NOT EXISTS Order_Details (
    orderdetailid BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    order_id BIGINT UNSIGNED NOT NULL,
    book_id BIGINT UNSIGNED NOT NULL,
    quantity DOUBLE NOT NULL DEFAULT 1,
    PRIMARY KEY (orderdetailid),
    INDEX idx_od_order_id (order_id),
    INDEX idx_od_book_id (book_id),
    CONSTRAINT fk_orderdetails_orders
        FOREIGN KEY (order_id)
        REFERENCES Orders (order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_orderdetails_books
        FOREIGN KEY (book_id)
        REFERENCES Books (book_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Optional: Example sample inserts (uncomment to use)
-- INSERT INTO Authors (author_name) VALUES ('Chinua Achebe'), ('Jane Austen');
-- INSERT INTO Books (title, author_id, price, publication_date) VALUES ('Things Fall Apart', 1, 12.50, '1958-06-17'), ('Pride and Prejudice', 2, 9.99, '1813-01-28');
-- INSERT INTO Customers (customer_name, email, address) VALUES ('Samuel Aidoo', 'sam@example.com', 'Accra, Ghana');
-- INSERT INTO Orders (customer_id, order_date) VALUES (1, CURDATE());
-- INSERT INTO Order_Details (order_id, book_id, quantity) VALUES (1, 1, 1), (1, 2, 2);

-- Useful example queries:
-- 1) Get order details with book titles and customer:
-- SELECT o.order_id, o.order_date, c.customer_name, b.title, od.quantity, b.price
-- FROM Orders o
-- JOIN Customers c ON o.customer_id = c.customer_id
-- JOIN Order_Details od ON od.order_id = o.order_id
-- JOIN Books b ON od.book_id = b.book_id
-- WHERE o.order_id = 1;

-- 2) List all books with their authors:
-- SELECT b.book_id, b.title, a.author_name, b.price, b.publication_date
-- FROM Books b
-- JOIN Authors a ON b.author_id = a.author_id
-- ORDER BY a.author_name, b.title;
