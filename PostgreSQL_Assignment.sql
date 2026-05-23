-- Active: 1779205148034@@127.0.0.1@5432@bookstore_db
CREATE Table books(
    id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    author VARCHAR (100),
    price INTEGER check (price>0),
    stock INTEGER check (stock>=0),
    pulished_year DATE
)

drop Table books CASCADE;

insert into  books( title, author,price, stock, pulished_year) 
VALUES
('Learn PostgreSQL', 'Rahim Uddin', 250, 15, '2025-01-10'),
('Mastering JavaScript', 'Karim Ahmed', 350, 12, '2024-05-15'),
('React Basics', 'Nusrat Jahan', 400, 8, '2023-08-12'),
('Next.js Complete Guide', 'Sabbir Hasan', 550, 20, '2025-11-01'),
('Node.js in Action', 'Tanvir Islam', 300, 14, '2024-06-17'),
('Express.js Essentials', 'Mithun Roy', 280, 18, '2023-09-20'),
('MongoDB Deep Dive', 'Shakil Ahmed', 450, 9, '2025-02-14'),
('TypeScript Handbook', 'Arif Chowdhury', 390, 13, '2024-03-11'),
('Tailwind CSS Mastery', 'Nayeem Hasan', 320, 11, '2023-12-05'),
('Flutter Development', 'Sadia Rahman', 500, 7, '2025-07-19'),
('Python For Beginners', 'Jannat Akter', 260, 16, '2022-04-25'),
('Django Unleashed', 'Mehedi Hasan', 430, 6, '2024-01-08'),
('Data Structures', 'Imran Hossain', 600, 5, '2021-10-30'),
('Algorithms Made Easy', 'Rakibul Islam', 700, 4, '2020-02-18'),
('C Programming', 'Fahim Reza', 220, 19, '2023-07-07'),
('Java Programming', 'Asif Mahmud', 370, 10, '2022-09-09'),
('PHP and MySQL', 'Rifat Ahmed', 290, 17, '2024-11-21'),
('Laravel Framework', 'Mahadi Hasan', 410, 8, '2025-06-14'),
('Full Stack Web Dev', 'Sazzad Hossen', 800, 5, '2026-01-01'),
('Machine Learning Intro', 'Arafat Khan', 900, 0, '2025-03-12'),
('Artificial Intelligence', 'Sakib Hossain', 950, 2, '2024-12-22'),
('Cyber Security Basics', 'Adnan Karim', 480, 9, '2023-05-28'),
('Ethical Hacking', 'Raihan Islam', 650, 6, '2022-06-16'),
('Cloud Computing', 'Tariqul Islam', 720, 7, '2025-08-08'),
('Docker Essentials', 'Habib Rahman', 340, 0, '2024-10-10'),
('Kubernetes Guide', 'Shuvo Das', 580, 5, '2025-09-09'),
('Operating Systems', 'Anik Paul', 460, 11, '2021-03-03'),
('Computer Networks', 'Bappy Roy', 530, 0, '2020-07-27')



CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    joined_date DATE DEFAULT now()
)

alter Table customers 
ADD CONSTRAINT email UNIQUE(email)

alter Table customers
alter COLUMN joined_date TYPE TIMESTAMP

insert INTO customers (name,email)
VALUES
('Sathi','sathi@gmail.com')


CREATE Table orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    book_id INTEGER REFERENCES books(id),
    quantity INTEGER check (quantity>0),
    order_date  TIMESTAMP DEFAULT now()
)

TRUNCATE TABLE orders RESTART IDENTITY CASCADE;



insert into orders (customer_id,book_id,quantity)
VALUES
(2,20,4)


SELECT * FROM orders


--1️⃣ Find books that are out of stock.

SELECT title FROM books
WHERE (stock =0)

--2️⃣ Retrieve the most expensive book in the store.

SELECT  * FROM books
ORDER BY price DESC
LIMIT 1

--3️⃣ Find the total number of orders placed by each customer.

SELECT
    c.name,
    COUNT(o.id) AS total_orders
FROM orders o
JOIN customers c
ON o.customer_id = c.id
GROUP BY c.id;

--4️⃣ Calculate the total revenue generated from book sales.
SELECT b.price*
o.quantity as total_revenue
FROM books b
JOIN orders o
ON b.id = o.book_id

SELECT sum(b.price*o.quantity)as total_revenue
FROM books b
JOIN orders o
ON b.id = o.book_id


--5️⃣ List all customers who have placed more than one order.
SELECT
    c.name,
    COUNT(o.id) AS total_orders
FROM orders o
JOIN customers c
ON o.customer_id = c.id
GROUP BY c.id
HAVING count(o.id)>1

--6️⃣ Find the average price of books in the store.
SELECT ROUND(AVG(price), 2) AS avg_book_price FROM books