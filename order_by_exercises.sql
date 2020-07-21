-- Copy in the contents of your exercise from the previous lesson.--
USE employees;

/*Find all employees with first names 'Irena', 'Vidya', or 'Maya'*/
SELECT first_name, last_name
FROM employees
WHERE first_name in ('Irena', 'Vidya', 'Maya');

/*Find all employees whose last name starts with 'E'*/
SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'E%';

/*Find all employees hired in the 90s*/
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' and '1999-12-31';

/*Find all employees born on Christmas*/
SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date LIKE '%12-25';

/*Find all employees with a 'q' in their last name  */
SELECT last_name, first_name
FROM employees
WHERE last_name LIKE '%q%';

/*Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN*/
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Irena' 
OR first_name = 'Vidya' 
OR first_name = 'Maya';

/*Add a condition to the previous query to find everybody with those names who is also male */
SELECT first_name, last_name, gender
FROM employees
WHERE gender = 'M'
	AND (
		first_name = 'Irena' 
		OR first_name = 'Vidya' 
		OR first_name = 'Maya'
);

/*Find all employees whose last name starts or ends with 'E'*/
SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E';

/*Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E'*/
SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E';


/*Find all employees hired in the 90s and born on Christmas*/
SELECT first_name, last_name, hire_date, birth_date 
FROM employees
WHERE birth_date LIKE '%12-25'
	AND (
		hire_date BETWEEN '1990-01-01' and '1999-12-31'
);

/*Find all employees with a 'q' in their last name but not 'qu'*/
SELECT last_name, first_name
FROM employees
WHERE last_name NOT LIKE '%qu%'
	AND (
		last_name LIKE '%q%'
);

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ORDER BY EXERCISES~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

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


