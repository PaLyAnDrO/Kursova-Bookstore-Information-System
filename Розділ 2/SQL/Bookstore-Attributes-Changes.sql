USE bookstore;

ALTER TABLE employee 
ADD CONSTRAINT UNIQUE (email),
ADD CONSTRAINT UNIQUE (phone_number);

ALTER TABLE department ADD CONSTRAINT UNIQUE (department_name);

ALTER TABLE book ADD CONSTRAINT UNIQUE (isbn);

ALTER TABLE customer 
ADD CONSTRAINT UNIQUE (email),
ADD CONSTRAINT UNIQUE (phone_number);

ALTER TABLE `order_detail` ADD CONSTRAINT UNIQUE (`order_id`, `book_id`);

ALTER TABLE customer 
MODIFY loyalty_points INT DEFAULT 0,
MODIFY discount INT DEFAULT 0;

ALTER TABLE `order` 
MODIFY `status` varchar(20) DEFAULT 'Processing',
MODIFY payment_method varchar(20) DEFAULT 'Cash';

ALTER TABLE order_detail MODIFY discount int DEFAULT 0;