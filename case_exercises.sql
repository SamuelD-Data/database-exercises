-- Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. --

select E.emp_no, dept_no, hire_date, to_date, IF(to_date > curdate(), true, false) as is_current_employee
from employees as E
join dept_emp as DE on DE.emp_no = E.emp_no;

-- Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name. --

select last_name, 
	CASE
		WHEN last_name < 'I' THEN 'A-H'
		WHEN last_name < 'R' THEN 'I-Q'
		ELSE 'R-Z'
		END AS alpha_group
from employees;

-- How many employees were born in each decade? -- 

select birth_date,
	CASE
		WHEN substr(birth_date, 1,4) < '1960' then '1950s'
		WHEN substr(birth_date, 1,4) < '1970' then '1960s'
		else 'not 50s or 60s'
		end as birth_decade
from employees;

-- BONUS --

-- What is the average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? --

select substr(birth_date, 1,4)
from employees;

-- still confused, this runs but returns no results
select substr(last_name,1,1)
FROM employees
where REGEXP([abc];