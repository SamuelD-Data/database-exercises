USE employees;

-- Find all the employees with the same hire date as employee 101010 using a sub-query. 69 Rows --

SELECT CONCAT(first_name, " ", last_name) as full_name, hire_date
FROM employees
WHERE hire_date IN (
	SELECT hire_date
	FROM employees
	WHERE emp_no = '101010'
);

-- Find all the titles held by all employees with the first name Aamod. 314 total titles, 6 unique titles --

select titles.title, CONCAT(first_name, " ", last_name) 
FROM titles
JOIN employees ON employees.emp_no = titles.emp_no
where titles.emp_no in (
	select emp_no from employees
	where employees.first_name = 'Aamod')
order by title;
 
-- ALTERNATE ANSWER --

SELECT titles.title, COUNT(titles.title)
FROM employees 
JOIN titles ON titles.emp_no = employees.emp_no
WHERE employees.emp_no IN (
    SELECT employees.emp_no
    FROM employees
	WHERE employees.first_name = 'Aamod')
GROUP BY titles.title;
	
-- How many people in the employees table are no longer working for the company? --

select count(distinct emp_no) 
from employees 
where emp_no not in (select emp_no 
					from dept_emp
					where to_date = '9999-01-01');
	
-- Find all the current department managers that are female.--

SELECT CONCAT(first_name, ' ', last_name) as female_managers
FROM employees 
WHERE employees.emp_no IN (
	SELECT emp_no
	FROM dept_manager 
	WHERE to_date > curdate() and employees.gender = 'F');

-- Find all the employees that currently have a higher than average salary. 154543 rows in total. --

SELECT CONCAT(first_name, ' ', last_name) as emp_name, salaries.salary
FROM salaries
JOIN employees ON employees.emp_no = salaries.emp_no
WHERE salaries.salary > (
	SELECT avg(salaries.salary)
	FROM salaries)
and salaries.to_Date > curdate();

-- How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) --

SELECT COUNT(salaries.salary) as salaries_above_avg
FROM salaries
WHERE salaries.salary 
	BETWEEN  
		((select MAX(salary) from salaries) - (select std(salary) from salaries))
	AND 
		(select MAX(salary) from salaries) 
	AND salaries.to_date> curdate();
	
-- What percentage of all salaries is this? 78 salaries --

SELECT FORMAT
	((SELECT COUNT(salaries.salary) as salaries_above_avg
	FROM salaries
	WHERE salaries.salary >=  
			((select MAX(salary) from salaries) - (select std(salary) from salaries))
	AND salaries.to_date> curdate()) 
	/ (select COUNT(salaries.salary) from salaries), 7) 
as percent_of_salaries;

-- BONUS QUESTIONS -- 


-- Find all the department names that currently have female managers. --

select EG.gender as manager_gender, d.dept_name
from (
		SELECT e.gender, e.emp_no
		FROM employees as e
		WHERE e.gender = 'F' 
	  ) as EG
JOIN dept_manager as dm ON dm.emp_no = EG.emp_no
JOIN departments as d ON d.dept_no = dm.dept_no
WHERE dm.to_date > curdate()
;
	  
-- Find the first and last name of the employee with the highest salary. --

select CONCAT(e.first_name, ' ', e.last_name) as full_name, all_salaries.salary
FROM (
		SELECT s.salary, s.emp_no
		FROM salaries as s
	  ) as all_salaries
JOIN employees as e ON e.emp_no = all_salaries.emp_no
ORDER BY salary DESC
LIMIT 1;

-- Find the department name that the employee with the highest salary works in. --

select subquery.dept_name, CONCAT(subquery.first_name, ' ', subquery.last_name) as full_name
FROM (
		SELECT d.dept_name, d.dept_no, s.salary, e.first_name, e.last_name
		FROM departments as d
		JOIN dept_emp as de ON de.dept_no = d.dept_no
		JOIN employees as e ON e.emp_no = de.emp_no
		JOIN salaries as s ON s.emp_no = e.emp_no
		) as subquery
ORDER BY subquery.salary DESC
LIMIT 1;




