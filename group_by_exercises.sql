USE employees;

-- In your script, use DISTINCT to find the unique titles in the titles table. --

SELECT distinct title
FROM titles; 

-- Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY. --

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
GROUP BY last_name;

-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. --

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
GROUP BY first_name, last_name;

-- Find the unique last names with a 'q' but not 'qu'. --

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others. --

SELECT last_name, COUNT(*)
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(*);

-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. --

SELECT COUNT(*) as Gender_Count, gender
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya')
GROUP BY gender
ORDER BY COUNT(*) DESC;

-- Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames? --

USE employees;

-- In your script, use DISTINCT to find the unique titles in the titles table. --

SELECT distinct title
FROM titles; 

-- Find your query for employees whose last names start and end with 'E'. Update the query find just the unique last names that start and end with 'E' using GROUP BY. --

SELECT last_name
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
GROUP BY last_name;

-- Update your previous query to now find unique combinations of first and last name where the last name starts and ends with 'E'. --

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
GROUP BY first_name, last_name;

-- Find the unique last names with a 'q' but not 'qu'. --

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

-- Add a COUNT() to your results and use ORDER BY to make it easier to find employees whose unusual name is shared with others. --

SELECT last_name, COUNT(*)
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(*);

-- Update your query for 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names. --

SELECT COUNT(*) as Gender_Count, gender
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya')
GROUP BY gender
ORDER BY COUNT(*) DESC;

-- Recall the query the generated usernames for the employees from the last lesson. Are there any duplicate usernames? --

SELECT 
	CONCAT(
		LOWER(SUBSTR(first_name, 1, 1)), 
		LOWER(SUBSTR(last_name, 1, 4)) , 
		"_", SUBSTR(birth_date, 6, 2), 
		SUBSTR(birth_date, 3, 2)) 
	as USERNAME, 
	COUNT(*)
FROM employees
GROUP BY USERNAME
HAVING COUNT(*) > 1;

/* Answer: Yes, there are duplicates as seen in the results of the code above. For example, there are 2 "aaamo_0359" usernames.

Bonus: how many duplicate usernames are there? */

SELECT sum(temp.username_count)
FROM (
        SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), LOWER(SUBSTR(last_name, 1, 4)), "_", SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)) AS username, COUNT(*) as username_count
        FROM employees
        GROUP BY username
        ORDER BY username_count DESC
) as temp
WHERE username_count > 1;

/* Answer: There are 27,403 username duplicates total. */