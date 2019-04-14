USE sakila;


-- Section 1 --
-- Question (1a): Find The First and Last Names of Actor
SELECT first_name, last_name FROM actor;

-- Question (1b): Display First and Last name in a single column in upper case letters. Name column 'Actor Name'
SELECT UPPER(CONCAT(first_name, " ", last_name)) AS 'Actor Name' FROM actor;


-- Section 2 --
-- Question (2a): Find the ID Number, first name, last name of an actor of whome you only have the fist name. 
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

-- Question (2b): Find all actors whose last name contain the letters 'GEN'
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE "%GEN%";

-- Question (2c): Find all actors whose last name contains the ltters 'LI'. Order rows by last name and first name
SELECT last_name, first_name FROM actor WHERE last_name LIKE "%LI%" ORDER BY last_name, first_name;

-- Question (2d): Using 'IN', display the 'country_id' and 'country' coluns of the countries: Afghanistan, Bangladesh, China
SELECT country_id, country FROM country WHERE country in ("Afghanistan", "Bangladesh", "China");


-- Section 3 -- 
-- Question (3a): Create a column in the table 'actor' named 'description' and use the data type 'BLOB' 
ALTER TABLE actor ADD description BLOB;

-- Question (3b): Delete the 'description' column
ALTER TABLE actor DROP COLUMN description;


-- Section 4 --
-- Question (4a): List the last names of actors, as well as how many actors have that last name.
SELECT last_name, COUNT(*) AS "Number of Actors" FROM actor GROUP BY last_name;

-- Question (4b): List last names of actors and number of actors who have that last name(shared by at least two actors)
SELECT last_name, COUNT(*) AS "Number of Actors" FROM actor GROUP BY last_name HAVING COUNT(*) >= 2;

-- Question (4c): Fix 'GROUCHO WILLIAMS' to 'HARPO WILLIAMS'
UPDATE actor SET first_name = "HARPO" WHERE first_name  = "GROUCHO" AND last_name = "WILLIAMS";

-- Question (4d): Change 'HARPO' back to 'GROUCHO'
UPDATE actor SET first_name = "GROUCHO" where first_name = "HARPO";


-- Section 5 -- 
-- Question (5a): Can't find the schema for the 'addresss' table. Find a way to recreate it.
DESCRIBE sakila.address; 


-- Section 6 -- 
-- Question (6a): Display first name, last name, address of each staff member by using JOIN. use 'staff' and 'address' tables
SELECT first_name, last_name, address FROM staff s JOIN address a ON s.address_id = a.address_id;

-- Question (6b): Find the total amount run up by each staff member in August of 2005 by using JOIN. 'staff' and 'payment'
SELECT FIRST_NAME, LAST_NAME, sum(amount) AS "August Rentals by Staff ID" FROM staff s 
INNER JOIN payment p ON s.staff_id = p.staff_id GROUP BY p.staff_id ORDER BY last_name ASC;

-- Question (6c): List each film and the number of actors who are listed for that film by using inner join. 'film_actor' and 'film'
SELECT title, COUNT(actor_id) AS "# of Actors in Film" FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id GROUP BY title;

-- Question (6d): Find how many copies of the film 'Hunchback  Impossible' exist 
SELECT title, COUNT(inventory_id) FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id WHERE title = "Hunchback Impossible";

-- Question (6e): Find total paid by each customer and sort the customers alphabetically: 'payment', 'customer', 'JOIN'
SELECT first_name, last_name, SUM(amount) AS "Total Amount Paid" FROM payment p
INNER JOIN customer c ON (p.customer_id = c.customer_id) GROUP BY p.customer_id ORDER BY alst_name ASC;


