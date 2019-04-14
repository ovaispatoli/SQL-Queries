USE sakila;


-- Section 1 --
--  (1a): Find The First and Last Names of Actor

SELECT first_name, last_name FROM actor;

--  (1b): Display First and Last name in a single column in upper case letters. Name column 'Actor Name'

SELECT UPPER(CONCAT(first_name, " ", last_name)) AS 'Actor Name' FROM actor;


-- Section 2 --
--  (2a): Find the ID Number, first name, last name of an actor of whome you only have the fist name. 

SELECT actor_id, first_name, last_name FROM actor 
WHERE first_name = 'Joe';

--  (2b): Find all actors whose last name contain the letters 'GEN'
SELECT actor_id, first_name, last_name FROM actor 
WHERE last_name LIKE "%GEN%";

--  (2c): Find all actors whose last name contains the ltters 'LI'. Order rows by last name and first name

SELECT last_name, first_name FROM actor 
WHERE last_name LIKE "%LI%" 
ORDER BY last_name, first_name;

--  (2d): Using 'IN', display the 'country_id' and 'country' coluns of the countries: Afghanistan, Bangladesh, China

SELECT country_id, country FROM country 
WHERE country in ("Afghanistan", "Bangladesh", "China");


-- Section 3 -- 
--  (3a): Create a column in the table 'actor' named 'description' and use the data type 'BLOB' 

ALTER TABLE actor ADD description BLOB;

-- Question (3b): Delete the 'description' column

ALTER TABLE actor DROP COLUMN description;


-- Section 4 --
--  (4a): List the last names of actors, as well as how many actors have that last name.

SELECT last_name, COUNT(*) AS "Number of Actors" FROM actor 
GROUP BY last_name;

-- Question (4b): List last names of actors and number of actors who have that last name(shared by at least two actors)

SELECT last_name, COUNT(*) AS "Number of Actors" FROM actor 
GROUP BY last_name 
HAVING COUNT(*) >= 2;

--  (4c): Fix 'GROUCHO WILLIAMS' to 'HARPO WILLIAMS'

UPDATE actor SET first_name = "HARPO" 
WHERE first_name  = "GROUCHO" AND last_name = "WILLIAMS";

--  (4d): Change 'HARPO' back to 'GROUCHO'

UPDATE actor SET first_name = "GROUCHO" 
WHERE first_name = "HARPO";


-- Section 5 -- 
--  (5a): Can't find the schema for the 'addresss' table. Find a way to recreate it.

SHOW CREATE TABLE sakila.address; 


-- Section 6 -- 
--  (6a): Display first name, last name, address of each staff member by using JOIN. use 'staff' and 'address' tables

SELECT first_name, last_name, address FROM staff s 
JOIN address a ON s.address_id = a.address_id;

--  (6b): Find the total amount run up by each staff member in August of 2005 by using JOIN. 'staff' and 'payment'

SELECT FIRST_NAME, LAST_NAME, SUM(amount) AS "August Rentals by Staff ID" FROM staff s 
INNER JOIN payment p 
ON s.staff_id = p.staff_id 
GROUP BY p.staff_id 
ORDER BY last_name ASC;

--  (6c): List each film and the number of actors who are listed for that film by using inner join. 'film_actor' and 'film'

SELECT title, COUNT(actor_id) AS "# of Actors in Film" FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id 
GROUP BY title;

-- (6d): Find how many copies of the film 'Hunchback  Impossible' exist 

SELECT title, COUNT(inventory_id) FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id 
WHERE title = "Hunchback Impossible";

-- (6e): Find total paid by each customer and sort the customers alphabetically: 'payment', 'customer', 'JOIN'

SELECT first_name, last_name, SUM(amount) AS "Total Amount Paid" FROM payment p
INNER JOIN customer c ON (p.customer_id = c.customer_id) 
GROUP BY p.customer_id 
ORDER BY alst_name ASC;


-- Section 7 --
-- (7a): Use subqueries to display the titles of movies starting with the letters 'K' and 'Q' whose language is English

SELECT title FROM film 
WHERE language_id IN 
		(SELECT language_id FROM language 
        WHERE name = "English") 
AND (title LIKE "K%") OR (title LIKE "Q%");

-- (7b): Use subqueries to display all actors who appear in the film 'Alone trip'

SELECT last_name, first_name FROM actor WHERE actor_id IN 
		(SELECT actor_id FROM film_actor WHERE film_id IN 
				(SELECT film_id FROM film 
                WHERE title = "Alone Trip"));

-- (7c): Retrieve the names and email addresses of all Canadian (boo!) Customers

SELECT country, last_name, first_name, email FROM country c 
LEFT JOIN customer cu ON c.country_id = cu.customer_id
WHERE country = "Canada";

-- (7d): Identify all movies categorized as __family__ films

SELECT title, category FROM film_list
WHERE category = "Family";

-- (7e): Display the most frequently rented movies in descending order

SELECT i.film_id, f.title, COUNT(r.inventory_id) AS Inventory FROM inventory i 
	INNER JOIN rental r ON i.inventory_id = r.inventory_id
	INNER JOIN film_text f ON i.film_id = f.film_id
GROUP BY r.inventory_id
ORDER BY COUNT(r.inventory_id) DESC;

-- (7f): Find how much business, in dollars, each store brought in 

SELECT store.store_id, SUM(amount) FROM store
	INNER JOIN staff ON store.store_id = staff.store_id
	INNER JOIN payment p ON p.staff_id = staff.staff_id
GROUP BY store.store_id
ORDER BY SUM(amount);


-- (7g): Display for each store: store ID, city and country

SELECT s.store_id, city, country FROM store s
	INNER JOIN customer cu ON s.store_id = cu.store_id
	INNER JOIN staff st ON s.store_id = st.store_id
	INNER JOIN address a on cu.address_id = a.address_id
	INNER JOIN city ci ON a.city_id = ci.city_id
	INNER JOIN country coun ON ci.country_id = coun.country_id;

-- (7h): List top five genres in gross revenue in descending order (tables: category, film_category, inventory, payment and rental)

SELECT c.name AS "Genre", SUM(p.amount) AS "Gross" FROM cateogry c
	JOIN film_category fc ON (c.category_id = fc.category_id)
	JOIN invenotry i ON (fc.film_id = i.film_id)
	JOIN rental r ON (i.inventory_id = r.inventory_id)
	JOIN payment p ON (r.rental_id = p.rental_id)
GROUP BY c.name
ORDER BY Gross
LIMIT 5;

-- Section 8 --
-- (8a): Create a view to the Top five genres by gross revenue

CREATE VIEW top_five_grossing_genres AS
SELECT c.name AS "Genre", SUM(p.amount) AS "Gross" FROM category c
	JOIN film_category fc ON (c.category_id = fc.cateogry_id)
    JOIN inventory i ON (fc.film_id = i.film_id)
    JOIN rental r ON (i.inventory_id = r.inventory_id)
    JOIN payment p ON (r.rental_id = p.rental_id)
GROUP BY c.name
ORDER BY Gross
Limit 5;

-- (8b): Display the view created above

SELECT * FROM top_five_grossing_genres

-- (8c): Delete the above created view

DROP VIEW top_give_grossing_genres;