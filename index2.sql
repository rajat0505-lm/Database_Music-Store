--Q1-- Find how much amount spent by each customer on artists?
--write a query to return cusotmer name, artist name and total spent.

WITH best_selling_artist AS (
	SELECT artist.artist_id as artist_id, artist.name as artist_name,
	SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1
	ORDER BY 3 DESC
	LIMIT 1	
	
)

SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name,
SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;




-Q2-- We want to find out the most popular music genre for each country.
-- we determine the most popular music genre as the genre with highest amount of 
--purchases.
-- write a query that returns each country along with the top genre.
-- for countries where the maximum number of purchases is shared reutrns all genres.

WITH popular_genre AS
(
	
SELECT 
COUNT(invoice_line.quantity) AS purchases, 
customer.country, 
genre.name, 
genre.genre_id,
ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS Row_no
FROM invoice_line
JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
JOIN customer ON customer.customer_id = invoice.customer_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
GROUP BY customer.country, genre.name, genre.genre_id
ORDER BY customer.country ASC, purchases DESC

)

SELECT * FROM popular_genre WHERE Row_No <= 1



--Q3-- write a query that determines the customers that has spent the most 
--on music for each country.
--write a query that returns the country along with the top customer and
--how much they spent.
--For countries where the top amount is speny is shared, provide all customers
--who spent this amount.



WITH customer_with_country AS (
	SELECT customer.customer_id,
	first_name,last_name,
	billing_country,
	SUM(total) AS total_spending,
    ROW_NUMBER() OVER (PARTITION BY billing_country ORDER BY SUM(total) DESC) AS Rowno
	FROM invoice
    JOIN customer ON customer.customer_id = invoice.customer_id
    GROUP BY customer.customer_id,first_name,last_name,billing_country

)	


SELECT * FROM customer_with_country WHERE Rowno <=1;




















