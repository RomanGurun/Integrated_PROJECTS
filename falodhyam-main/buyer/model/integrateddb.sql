-- Create the first database
CREATE DATABASE IF NOT EXISTS falodhyam_parties;
USE falodhyam_parties;

-- Create the 'buyers' table first because other tables depend on it
CREATE TABLE buyers (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(10) NOT NULL,
    address VARCHAR(255) NOT NULL,
    house_number VARCHAR(8) NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Create the 'seller' table next as 'products' table depends on it
CREATE TABLE seller (
    `s-id` INT(20) NOT NULL AUTO_INCREMENT,
    `s-name` VARCHAR(50) NOT NULL,
    `s-email` VARCHAR(50) NOT NULL,
    `s-password` VARCHAR(20) NOT NULL,
    `s-profile` VARCHAR(250) NOT NULL,
    PRIMARY KEY (`s-id`)
);

-- Create the 'products' table next as 'cart', 'orders', and 'wishlist' tables depend on it
CREATE TABLE products (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    image VARCHAR(255),
    product_detail TEXT,
    status varchar(20),
    `s-id` INT(20) NOT NULL,
    FOREIGN KEY (`s-id`) REFERENCES seller(`s-id`) ON DELETE CASCADE ON UPDATE CASCADE,
    type ENUM('Berries', 'Drupes', 'Pomes', 'Citrus Fruits', 'Melons', 'Dried Fruits', 'Tropical Fruits', 'Others')
);

-- Now create the dependent tables with ON DELETE CASCADE option
CREATE TABLE cart (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36),
    product_id VARCHAR(36),
    price DECIMAL(10, 2),
    qty INT,
    date_added DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES buyers(id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
    

CREATE TABLE orders (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36),
    name VARCHAR(255),
    number VARCHAR(255),
    email VARCHAR(255),
    address VARCHAR(255),
    house_number VARCHAR(8) NOT NULL,
    method VARCHAR(255),
    product_id VARCHAR(36),
    price DECIMAL(10, 2),
    qty INT,
    date_ordered TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES buyers(id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE wishlist (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36),
    product_id VARCHAR(36),
    price DECIMAL(10, 2),
    date_added DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES buyers(id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Now create the second database
CREATE DATABASE IF NOT EXISTS falodhyam_admin;
USE falodhyam_admin;

CREATE TABLE admin (
    id INT(20) NOT NULL AUTO_INCREMENT,
    useremail VARCHAR(50) NOT NULL,
    password VARCHAR(250) NOT NULL,
    PRIMARY KEY (id)
);

-- Insert admin example
INSERT INTO admin (id, useremail, password)
VALUES (1, 'fruitadmin097@gmail.com', 'fruit2097');




INSERT INTO `seller` (`s-id`, `s-name`, `s-email`, `s-password`, `s-profile`) VALUES ('1', 'Rustam', 'bdave5457@gmail.com', 'ppp', ''), ('2', 'Tiger', 't@gmail.com', 'ppp', '');


INSERT INTO `products` (`id`, `name`, `price`, `image`, `product_detail`, `status`, `s-id`, `type`) VALUES
('668', 'strawberry', '15', 'sellerimage/strawberry.jpg', 'Fresh strawberries', 'active', '1', 'Berries'),
('669', 'cherry', '20', 'sellerimage/cherry.jpg', 'Sweet cherries', 'active', '2', 'Drupes'),
('670', 'apple', '25', 'sellerimage/apple.jpg', 'Crisp apples', 'active', '1', 'Pomes'),
('671', 'grapefruit', '12', 'sellerimage/grapefruit.jpg', 'Juicy grapefruit', 'active', '2', 'Citrus Fruits'),
('672', 'watermelon', '30', 'sellerimage/watermelon.jpg', 'Refreshing watermelon', 'active', '1', 'Melons'),
('673', 'fig', '35', 'sellerimage/fig.jpg', 'Sweet figs', 'active', '2', 'Dried Fruits'),
('674', 'pineapple', '40', 'sellerimage/pineapple.jpg', 'Tropical pineapple', 'active', '1', 'Tropical Fruits'),
('675', 'dragon fruit', '50', 'sellerimage/dragonfruit.jpg', 'Exotic dragon fruit', 'active', '2', 'Tropical Fruits'),
('676', 'kiwi', '22', 'sellerimage/kiwi.jpg', 'Tangy kiwi', 'active', '1', 'Tropical Fruits'),
('677', 'banana', '18', 'sellerimage/banana.jpg', 'Sweet bananas', 'active', '2', 'Tropical Fruits'),
('678', 'mango', '35', 'sellerimage/mango.jpg', 'Juicy mangoes', 'active', '1', 'Tropical Fruits'),
('679', 'sugarcane', '28', 'sellerimage/sugarcane.webp', 'Fresh sugarcane', 'active', '2', 'Tropical Fruits'),
('680', 'guava', '33', 'sellerimage/guava.webp', 'Crisp guava', 'active', '1', 'Tropical Fruits'),
('681', 'blueberry', '45', 'sellerimage/blueberry.jpg', 'Juicy blueberries', 'active', '2', 'Berries');






-- We have rename the s-profile attributes to s-pan_CARD OF seller table
ALTER TABLE `seller` CHANGE `s-profile` `s-pan_card` VARCHAR(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;

-- JUST ADDED AVAILABLE STOCKS ON A PRODUCTS TABLE
ALTER TABLE `products` ADD `available_stock` INT(7) NOT NULL AFTER `type`;


-- JUST ADDED s-id  ON A ORDERS TABLE

ALTER TABLE `orders` ADD `s-id` INT(7) NOT NULL AFTER `status`;
