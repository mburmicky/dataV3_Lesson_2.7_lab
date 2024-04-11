USE sakila;

#1) How many films are there for each of the categories in the category table. Use appropriate join to write this query.

SELECT * FROM sakila.category;

SELECT * FROM sakila.film_category;

#Here we join both tables, to bring the name of the category and to group it by it
SELECT b.name, COUNT(a.film_id) AS nb_films_per_cat
FROM sakila.film_category a
JOIN sakila.category b
ON a.category_id = b.category_id
GROUP BY b.name
ORDER BY nb_films_per_cat DESC;

#Still we could have get total count from the table film_category but only grouped by cat_id
SELECT category_id, COUNT(film_id) AS COUNT FROM sakila.film_category GROUP BY category_id;


#2)Display the total amount rung up by each staff member in August of 2005.

SELECT * FROM sakila.staff;

SELECT * FROM sakila.rental;

SELECT a.staff_id, a.first_name, a.last_name, COUNT(rental_id) AS Nb_Rentals_per_Staff
FROM sakila.staff a
JOIN sakila.rental b
ON a.staff_id = b.staff_id
WHERE b.rental_date LIKE '2005-08%'
GROUP BY a.staff_id;

#3) Which actor has appeared in the most films?

SELECT * FROM sakila.film_actor;
SELECT * FROM sakila.actor;

#SINGLE TABLE showing only actor_id
SELECT actor_id, COUNT(DISTINCT film_id) AS Nb_films 
FROM sakila.film_actor GROUP BY actor_id ORDER BY Nb_films DESC;

#JOINED tables to show first_name and last_name
SELECT b.actor_id, b.first_name, b.last_name, COUNT(DISTINCT a.film_id) AS Nb_films 
FROM sakila.film_actor a
JOIN sakila.actor b
ON a.actor_id = b.actor_id
GROUP BY b.actor_id ORDER BY Nb_films DESC LIMIT 1;

#4) Most active customer (the customer that has rented the most number of films)

SELECT * FROM sakila.customer;
SELECT * FROM sakila.rental;

SELECT b.customer_id, b.first_name, b.last_name, COUNT(DISTINCT a.rental_id) AS Nb_Rentals 
FROM sakila.rental a
JOIN sakila.customer b
ON a.customer_id = b.customer_id
GROUP BY b.customer_id ORDER BY Nb_Rentals DESC LIMIT 1;

#5) Display the first and last names, as well as the address, of each staff member.

SELECT * FROM sakila.address;
SELECT * FROM sakila.staff;

SELECT a.first_name, a.last_name, b.address
FROM sakila.staff a
JOIN sakila.address b
ON a.address_id = b.address_id;

#6) List each film and the number of actors who are listed for that film.

SELECT * FROM sakila.film;
SELECT * FROM sakila.film_actor;

SELECT b.title, COUNT(distinct a.actor_id) AS Nb_actor_in_film
FROM sakila.film_actor a
JOIN sakila.film b
ON a.film_id = b.film_id GROUP BY b.title ORDER BY Nb_actor_in_film DESC;

#7) Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.

SELECT * FROM sakila.payment;
SELECT * FROM sakila.customer;

SELECT b.last_name, SUM(a.amount) AS total_paid
FROM sakila.payment a
JOIN sakila.customer b
ON a.customer_id = b.customer_id
GROUP BY b.last_name ORDER BY total_paid DESC;

#8) List the titles of films per category.

SELECT * FROM sakila.category;
SELECT * FROM sakila.film_category;

SELECT a.name, c.title
FROM sakila.category a
JOIN sakila.film_category b
ON a.category_id = b.category_id
JOIN sakila.film c
ON b.film_id = c.film_id
ORDER BY a.name;

