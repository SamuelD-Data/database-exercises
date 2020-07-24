-- Use the join_example_db. Select all the records from both the users and roles tables.--

USE join_example_db;

SELECT *
FROM roles
JOIN users ON roles.id = users.role_id;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. --

SELECT *
FROM roles
JOIN users ON roles.id = users.role_id;

SELECT *
FROM roles
LEFT JOIN users on roles.id = users.role_id;

SELECT *
FROM roles
RIGHT JOIN users on roles.id = users.role_id;

 -- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query. --
 
SELECT roles.name, COUNT(users.role_id) as Role_Count
FROM roles
LEFT JOIN users ON roles.id = users.role_id
GROUP BY roles.name;

-- Use the employees database. --

USE employees;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department. --

SELECT dept_name, CONCAT(first_name, ' ', last_name) AS department_manager
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no 
WHERE dept_manager.to_date > curdate()
ORDER BY departments.dept_name;

-- Find the name of all departments currently managed by women. --

SELECT dept_name, CONCAT(first_name, ' ', last_name) AS department_manager, employees.gender AS manager_gender
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date > curdate() AND employees.gender = 'F';

-- Find the current titles of employees currently working in the Customer Service department. --

SELECT titles.title AS employee_title, COUNT(titles.title) AS title_count
FROM employees 
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN titles ON titles.emp_no = dept_emp.emp_no
WHERE departments.dept_name = "Customer Service" AND titles.to_date > curdate() AND dept_emp.to_date > curdate()
GROUP BY titles.title;

-- Find the current salary of all current managers. --

SELECT dept_name, CONCAT(first_name, ' ', last_name) AS department_manager, salaries.salary
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN salaries ON salaries.emp_no = dept_manager.emp_no 
WHERE salaries.to_date > curdate() AND dept_manager.to_date > curdate()
ORDER BY departments.dept_name;

-- Find the number of employees in each department. --

SELECT  dept_emp.dept_no, dept_name, count(departments.dept_no) AS emp_per_dept
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN employees ON employees.emp_no = dept_emp.emp_no
WHERE dept_emp.to_date > curdate()
GROUP BY dept_name
ORDER BY dept_emp.dept_no;

-- Which department has the highest average salary? --

SELECT departments.dept_name, AVG(salaries.salary) AS highest_avg_salary
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON salaries.emp_no = dept_emp.emp_no 
WHERE salaries.to_date > curdate() AND dept_emp.to_date > curdate()
GROUP BY departments.dept_name
ORDER BY highest_avg_salary DESC
LIMIT 1;

-- Who is the highest paid employee in the Marketing department? --

SELECT CONCAT(first_name, ' ', last_name) AS employee_name, salaries.salary AS highest_salary
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN employees ON employees.emp_no = dept_emp.emp_no 
JOIN salaries ON salaries.emp_no = dept_emp.emp_no 
WHERE salaries.to_date > curdate() AND dept_emp.to_date > curdate() AND departments.dept_name = 'Marketing'
ORDER BY highest_salary DESC
LIMIT 1;

-- Which current department manager has the highest salary? --

SELECT CONCAT(first_name, ' ', last_name) AS department_manager, salaries.salary AS highest_salary, departments.dept_name
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN salaries ON salaries.emp_no = employees.emp_no 
WHERE salaries.to_date > curdate() AND dept_manager.to_date > curdate()
ORDER BY salaries.salary DESC
LIMIT 1;

-- Bonus Find the names of all current employees, their department name, and their current manager's name. --

SELECT CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name
         , d.dept_name
         , CONCAT(manager_emp.first_name, ' ', manager_emp.last_name) AS manager_name
 FROM dept_emp AS de
 JOIN employees AS emp ON de.emp_no = emp.emp_no
 JOIN departments AS d ON de.dept_no = d.dept_no
 JOIN dept_manager AS dm ON de.dept_no = dm.dept_no 
         AND dm.to_date > curdate()
 JOIN employees AS manager_emp ON dm.emp_no = manager_emp.emp_no
 WHERE de.to_date > curdate();

-- Bonus Find the highest paid employee in each department. --



