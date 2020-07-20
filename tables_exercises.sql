USE employees;
show tables;

DESCRIBE employees;

/*Data types in the employees table includes date, int, enum, and varchar.

I expect at least one numeric column to appear in the salaries table.

I expect at least one string column to appear in the employees table.

I expect at least one date column to appear in the employees table.

The departments table and the employees table are connected via the dept_emp table where 
each employee number is associated with a dept number that denotes which dept that are in.*/

SHOW create table dept_manager;