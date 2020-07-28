use darden_1034;

-- Using the example from the lesson, re-create the employees_with_departments table.

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no);

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

ALTER TABLE employees_with_departments ADD full_name VARCHAR(64);

-- Update the table so that full name column contains the correct data

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;

ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- What is another way you could have ended up with this same table?

CREATE TEMPORARY TABLE employees_with_departments AS
SELECT *
FROM employees.employees_with_departments;

ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

-- Create a temporary table based on the payment table from the sakila database.

CREATE TEMPORARY TABLE payment AS
SELECT *
FROM sakila.payment;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

ALTER TABLE payment ADD amount_v2 INT(50); -- add new column that will store amounts as cents

UPDATE payment 
SET amount_v2 = amount * 100; -- populate new column with amount values * 100 to convert to cents

ALTER TABLE payment MODIFY amount_v2 INT(50) AFTER amount; -- move new column next to amount column

ALTER TABLE payment DROP COLUMN amount; -- drop old amount column

ALTER TABLE payment CHANGE amount_v2 amount INT(50); -- change name of new column to match old column

-- Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. 

create temporary table z_score_V3 as 
select dept_name, avg(salary) as avg_dept_sal
from zscore
JOIN employees.dept_emp as DE on DE.emp_no = zscore.emp_no -- Create temp table that contains each dept with the respective avg. salaries
JOIN employees.departments as D on D.dept_no = DE.dept_no
GROUP BY dept_name;

alter table z_score_V3 add total_avg VARCHAR(100); -- add column to temp table that will contain total avg of all salaries

update z_score_V3
set total_avg = (SELECT AVG(employees.salaries.salary) from employees.salaries); -- populate column w/ total avg of all salaries

alter table z_score_V3 add total_sdev VARCHAR(100); -- add column to temp table that will contain sdev of all salaries

update z_score_V3
set total_sdev = (SELECT STD(employees.salaries.salary) from employees.salaries); -- populate column w/ sdev of all salaries

alter table z_score_V3 add zscore VARCHAR(100); -- column to table that will contain zscore

update z_score_V3
set zscore = ((avg_dept_sal) - (total_avg)) / total_sdev; -- populate column with zscores

select dept_name, zscore -- examine results
from z_score_V3; 

-- In terms of salary, what is the best department to work for? 

select * from darden_1034.z_score_V3
order by zscore desc
limit 1;

-- Answer: sales

-- The worst?

select * from darden_1034.z_score_V3
order by zscore
limit 1;

-- Answer: Research
