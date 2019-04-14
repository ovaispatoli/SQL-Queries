USE sakila;

-- Question (1a): Find The First and Last Names of Actor
SELECT first_name, last_name FROM actor;

-- Question (1b): Display First and Last name in a single column in upper case letters. Name column 'Actor Name'
SELECT UPPER(CONCAT(first_name, " ", last_name)) AS 'Actor Name' FROM actor;


