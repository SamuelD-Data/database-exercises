-- Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT emp.emp_no, d.dept_no, emp.start_date, emp.end_date, emp.is_current_emp
FROM dept_emp d 
JOIN 
(SELECT dept_emp.emp_no # dept.dept_no
		, max(employees.hire_date) AS start_date
		, max(dept_emp.to_date) AS end_date
		, max(CASE WHEN dept_emp.to_date > curdate() THEN 1 ELSE 0 END) 
			AS is_current_emp
FROM dept_emp
JOIN employees USING(emp_no)
GROUP BY dept_emp.emp_no #, dept.dept_no
) emp
ON d.emp_no = emp.emp_no AND d.to_date = emp.end_date
;


-- Write a query that returns all employee names, and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name. --

select last_name, 
	CASE
		WHEN last_name < 'I' THEN 'A-H'
		WHEN last_name < 'R' THEN 'I-Q'
		WHEN last_name > 'Q' THEN 'R-Z'
		ELSE null
		END AS alpha_group
from employees;

-- How many employees were born in each decade? -- 

select count(birth_date),
	CASE
		WHEN substr(birth_date, 1,4) < '1960' then '1950s'
		WHEN substr(birth_date, 1,4) < '1970' then '1960s'
		else null
		end as birth_decade
from employees
GROUP BY birth_decade;

-- BONUS --

-- What is the average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? --

select 
	CASE 
		WHEN dept_name = 'Customer Service' THEN 'Customer Service'
		WHEN dept_name = 'Finance' OR dept_name = 'Human Resources' THEN 'Finance & HR'
		WHEN dept_name = 'Sales' OR dept_name = 'Marketing' THEN 'Sales & Marketing'
		WHEN dept_name = 'Production' OR dept_name = 'Quality Management' THEN 'Prod & QM'
		WHEN dept_name = 'Research' OR dept_name = 'Development' THEN 'R&D'
		ELSE null
		END as department_groups,
		round(avg(salary),2) as avg_dept_grp_sal
from salaries as S
join dept_emp as DE ON DE.emp_no = S.emp_no
join departments as D on D.dept_no = DE.dept_no
group by department_groups
;