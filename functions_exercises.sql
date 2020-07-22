USE employees;

-- COPY THE ORDER BY EXERCISES --

/*Modify your first query to order by first name. The first result should be Irena Reutenauer and the last result should be Vidya Simmen.*/
SELECT first_name, last_name
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

/*Update the query to order by first name and then last name. The first result should now be Irena Acton and the last should be Vidya Zweizig.*/
SELECT first_name, last_name
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

/*Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda.*/
SELECT first_name, last_name
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

/*Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your results should not change!*/
SELECT last_name, first_name, emp_no
FROM employees
WHERE last_name LIKE 'E%'
ORDER BY emp_no;

SELECT last_name, first_name, emp_no
FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E'
ORDER BY emp_no;

SELECT last_name, first_name, emp_no
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
ORDER BY emp_no;

/*Now reverse the sort order for both queries.*/
SELECT last_name, first_name, emp_no
FROM employees
WHERE last_name LIKE 'E%'
ORDER BY emp_no DESC;

SELECT last_name, first_name, emp_no
FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E'
ORDER BY emp_no DESC;

SELECT last_name, first_name, emp_no
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
ORDER BY emp_no DESC;

/*Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. It should be Khun Bernini.
IMPORTANT: PLEASE NOTE HIRE DATE COLUMN IS TO THE LEFT OF BIRTH DATE*/
SELECT first_name, last_name, hire_date, birth_date 
FROM employees
WHERE birth_date LIKE '%12-25'
	AND (
		hire_date BETWEEN '1990-01-01' and '1999-12-31')
ORDER BY birth_date, hire_date DESC;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~FUNCTION EXERCISES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --

-- Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name. --

SELECT CONCAT(first_name, " ", last_name) AS full_name, emp_no
FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E'
ORDER BY emp_no DESC;

SELECT CONCAT(first_name, " ", last_name) AS full_name, emp_no
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
ORDER BY emp_no DESC;

-- Convert the names produced in your last query to all uppercase. --

SELECT CONCAT (UPPER (first_name), " ", UPPER (last_name)) AS full_name, emp_no
FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E'
ORDER BY emp_no DESC;

SELECT CONCAT (UPPER (first_name), " ", UPPER (last_name)) AS full_name, emp_no
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
ORDER BY emp_no DESC;

-- For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company -- 

SELECT first_name, last_name, hire_date, birth_date, DATEDIFF(NOW(), hire_date) AS Days_Worked
FROM employees
WHERE birth_date LIKE '%12-25'
	AND (
		hire_date BETWEEN '1990-01-01' and '1999-12-31')
ORDER BY birth_date, hire_date DESC;

-- Find the smallest and largest salary from the salaries table. --

SELECT MIN(salary) as Smallest_Salary, MAX(salary) as Largest_Salary
FROM salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. --

SELECT first_name, last_name, birth_date,
	CONCAT
		(LOWER(SUBSTR(first_name, 1, 1)), 
		LOWER(SUBSTR(last_name, 1, 4)) , 
		"_", 
		SUBSTR(birth_date, 6, 2), 
		SUBSTR(birth_date, 3, 2)) as USERNAME		
FROM employees;
 