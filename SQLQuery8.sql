--Q1.Who is the senior most employee based on job title?
SELECT*FROM employee
ORDER BY levels desc  

--Q2.Which Contries have the most Invoices?
SELECT *FROM invoice
SELECT billing_country, COUNT(billing_country) AS Country_Invoices
FROM invoice
GROUP BY billing_country
ORDER BY Country_Invoices DESC
-- In USA 131 Invoices Was Genrated

--Q3. What are top 3 Values of total Invoice
SELECT customer_id, billing_city, total
FROM invoice
ORDER BY total DESC
-- Customer ID 42,3,32 is top 3 Values

--Q4. Which City is the Best Customers
SELECT billing_city, SUM(total) as invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
-- Prague City is the Best 273.24$ Music Sold in this City

--Q5. Who is the Best Customer. 
SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) as Total
FROM customer
JOIN invoice 
on customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY Total DESC

--Q6. Write Query to return Email, First Name, Last Name who listens ROCK Music 

 --Method(1)
SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice 
ON customer.customer_id = invoice.customer_id
JOIN invoice_line 
ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
				SELECT track_id 
				FROM track
				JOIN genre 
				ON track.genre_id = genre.genre_id
				WHERE genre.name LIKE 'ROCK'
				)
ORDER BY email 

-- Q7. Find the artist Who sing most ROCK Musics

SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS Song
FROM track
Join album2 ON track.album_id = album2.album_id
JOIN artist ON album2.artist_id = artist.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'ROCK'
GROUP BY artist.artist_id, artist.name
ORDER BY Song DESC

-- Q8. Find the AVG of Track Length and Show Greter than AVG Millisecound track length

SELECT name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds)
					  FROM track )
ORDER BY milliseconds DESC

--Q9. Find Which Customer spent most money of which artist

SELECT customer.customer_id, customer.first_name,customer.last_name, artist.name, SUM(invoice_line.unit_price*invoice_line.quantity) as Total
FROM artist
JOIN album2 ON artist.artist_id = album2.artist_id
JOIN track ON album2.album_id = track.album_id
JOIN invoice_line ON track.track_id = invoice_line.track_id
JOIN invoice ON invoice_line.invoice_id = invoice.invoice_id
JOIN customer ON invoice.customer_id = customer.customer_id
GROUP BY customer.customer_id, customer.first_name,customer.last_name, artist.name
order by Total DESC

