-- File: task_2.sql
-- Creates the alx_book_store database and all required tables:
-- authors, customers, books, orders, order_details

CREATE DATABASE IF NOT EXISTS alx_BOOK_store
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci;
USE alx_BOOK_store;

-- AUTHORS table
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT NOT NULL AUTO_INCREMENT,
    author_name VARCHAR(215) NOT NULL,
    PRIMARY KEY (author_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- CUSTOMERS table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(215) NOT NULL,
    email VARCHAR(215),
    address TEXT,
    PRIMARY KEY (customer_id),
    UNIQUE KEY uq_customers_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- BOOKS table
CREATE TABLE IF NOT EXISTS Books (
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(130) NOT NULL,
    author_id INT NOT NULL,
    price DOUBLE NOT NULL DEFAULT 0.0,
    publication_date DATE,
    PRIMARY KEY (book_id),
    INDEX idx_books_author_id (author_id),
    CONSTRAINT fk_books_authors
        FOREIGN KEY (author_id) REFERENCES Authors (author_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ORDERS table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    PRIMARY KEY (order_id),
    INDEX idx_orders_customer_id (customer_id),
    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id) REFERENCES Customers (customer_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ORDER_DETAILS table
CREATE TABLE IF NOT EXISTS Order_Details (
    orderdetailid INT NOT NULL AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity DOUBLE NOT NULL DEFAULT 1,
    PRIMARY KEY (orderdetailid),
    INDEX idx_od_order_id (order_id),
    INDEX idx_od_book_id (book_id),
    CONSTRAINT fk_orderdetails_orders
        FOREIGN KEY (order_id) REFERENCES Orders (order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_orderdetails_books
        FOREIGN KEY (book_id) REFERENCES Books (book_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- OPTIONAL: Example inserts (commented out)
-- INSERT INTO Authors (author_name) VALUES ('Author One'), ('Author Two');
-- INSERT INTO Customers (customer_name, email, address) VALUES ('Customer A', 'a@example.com', 'Address A');
-- INSERT INTO Books (title, author_id, price, publication_date) VALUES ('Book A', 1, 12.50, '2025-01-01');
-- INSERT INTO Orders (customer_id, order_date) VALUES (1, CURDATE());
-- INSERT INTO Order_Details (order_id, book_id, quantity) VALUES (1, 1, 2);
