USE sakila;

-- Question (1a): Find The First and Last Names of Actor
SELECT first_name, last_name FROM actor;

-- Question (1b): Display First and Last name in a single column in upper case letters. Name column 'Actor Name'
SELECT UPPER(CONCAT(first_name, " ", last_name)) AS 'Actor Name' FROM actor;

-- Question (2a): Find the ID Number, first name, last name of an actor of whome you only have the fist name. 
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

-- Question (2b): Find all actors whose last name contain the letters 'GEN'
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE "%GEN%";

-- Question (2c): Find all actors whose last name contains the ltters 'LI'. Order rows by last name and first name
SELECT last_name, first_name FROM actor WHERE last_name LIKE "%LI%" ORDER BY last_name, first_name;

-- Question (2d): Using 'IN', display the 'country_id' and 'country' coluns of the countries: Afghanistan, Bangladesh, China
SELECT country_id, country FROM country WHERE country in ("Afghanistan", "Bangladesh", "China");
