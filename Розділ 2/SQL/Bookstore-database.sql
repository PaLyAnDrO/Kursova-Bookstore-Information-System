CREATE DATABASE bookstore;

USE bookstore;

CREATE TABLE IF NOT EXISTS `employee` (
	`employee_id` int NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`hire_date` date NOT NULL,
	`position` varchar(15) NOT NULL,
	`salary` float NOT NULL,
	`phone_number` int NOT NULL,
	`department_id` int,
	`manager_id` int,
	`email` varchar(50),
	PRIMARY KEY (`employee_id`)
);

CREATE TABLE IF NOT EXISTS `department` (
	`department_id` int NOT NULL,
	`department_name` varchar(30) NOT NULL,
	`location` varchar(50) NOT NULL,
	`manager_id` int,
	PRIMARY KEY (`department_id`)
);

CREATE TABLE IF NOT EXISTS `book` (
	`book_id` int NOT NULL,
	`title` varchar(30) NOT NULL,
	`author` varchar(30) NOT NULL,
	`genre` varchar(20) NOT NULL,
	`publisher` varchar(20) NOT NULL,
	`publish_date` date NOT NULL,
	`isbn` int NOT NULL,
	`price` float NOT NULL,
	`stock` int NOT NULL,
	`pages` int NOT NULL,
	`language` varchar(20) NOT NULL,
	PRIMARY KEY (`book_id`)
);

CREATE TABLE IF NOT EXISTS `costumer` (
	`customer_id` int NOT NULL,
	`first_name` varchar(30) NOT NULL,
	`last_name` varchar(30) NOT NULL,
	`address` varchar(50) NOT NULL,
	`email` varchar(50) NOT NULL,
	`phone_number` int NOT NULL,
	`registration_date` date NOT NULL,
	`birth_date` date,
	`loyalty_points` int,
	`discount` int,
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `order` (
	`order_id` int NOT NULL,
	`employee_id` int NOT NULL,
	`customer_id` int NOT NULL,
	`order_date` datetime NOT NULL,
	`total_amount` int NOT NULL,
	`status` varchar(20) NOT NULL,
	`payment_method` varchar(20) NOT NULL,
	`shipping_address` varchar(50) NOT NULL,
	`shipping_date` date NOT NULL,
	PRIMARY KEY (`order_id`)
);

CREATE TABLE IF NOT EXISTS `order_detail` (
	`order_id` int NOT NULL,
	`book_id` int NOT NULL,
	`quantity` int NOT NULL,
	`unit_price` int NOT NULL,
	`discount` int
);

ALTER TABLE `employee` ADD CONSTRAINT `employee_fk7` FOREIGN KEY (`department_id`) REFERENCES `department`(`department_id`);



ALTER TABLE `order` ADD CONSTRAINT `order_fk1` FOREIGN KEY (`employee_id`) REFERENCES `employee`(`employee_id`);

ALTER TABLE `order` ADD CONSTRAINT `order_fk2` FOREIGN KEY (`customer_id`) REFERENCES `costumer`(`customer_id`);
ALTER TABLE `order_detail` ADD CONSTRAINT `order_detail_fk0` FOREIGN KEY (`order_id`) REFERENCES `order`(`order_id`);

ALTER TABLE `order_detail` ADD CONSTRAINT `order_detail_fk1` FOREIGN KEY (`book_id`) REFERENCES `book`(`book_id`);