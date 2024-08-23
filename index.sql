Q1 Who is the most senior employee based on the job title?

SELECT * FROM employee
ORDER BY levels DESC
limit 1



Q2 Which countries have the most invoices?

SELECT COUNT(*) as c, billing_country
FROM invoice
group by billing_country
order by c desc

Q3 What are top 3 values of total invoice?

SELECT total FROM invoice
order by total desc
limit 3


Q4- which city has the best customers?
--we would like to throw a promotional music festival in the city we made the most money.
--Write a query that returns one city that has the highest sum of invoice totals.
--Return both the city name and sum of all invoice total.


SELECT Sum(total) as invoice_total, billing_city
FROM invoice
group by billing_city
order by invoice_total desc
limit 1

Q5--Who is the best customer?
--The customer who has spent the most money will be declared the best customer.
--Write a query that returns the person who has spent the most money.



SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) as total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC
LIMIT 1


























































































