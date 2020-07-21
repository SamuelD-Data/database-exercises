USE employees;

-- Run the following query --
SELECT DISTINCT title from titles;

-- List the first 10 distinct last name sorted in descending order. --
SELECT DISTINCT last_name from employees
ORDER BY last_name DESC
LIMIT 10;

-- Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees. -- 
SELECT first_name, last_name
FROM employees
WHERE birth_date LIKE '%12-25'
	AND (
		hire_date BETWEEN '1990-01-01' and '1999-12-31')
ORDER BY birth_date, hire_date DESC
LIMIT 5;

-- Update the query to find the tenth page of results. --
SELECT first_name, last_name
FROM employees
WHERE birth_date LIKE '%12-25'
	AND (
		hire_date BETWEEN '1990-01-01' and '1999-12-31')
ORDER BY birth_date, hire_date DESC
LIMIT 5 OFFSET 45;

-- What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number? --
-- Answer: LIMIT sets how many results make up a page. For example, in this case there are 5 results per page. Thus, for every 5 results that are offset, 1 page is skipped. --

/* 

In algebraic terms:
Amount of results you want to skip = OFFSET = F
Page number you want to see in results = P
Number of results you want per page = LIMIT = L

F = (P-1) * L

Formula applied to last problem:

45 = (10-1) * 5

*/









