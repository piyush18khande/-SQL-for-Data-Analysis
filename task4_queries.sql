CREATE DATABASE customer;

 CREATE TABLE customer (
employee_id	 VARCHAR(30) PRIMARY KEY,
first_name	 VARCHAR(30) NOT NULL,
last_name	 VARCHAR(30) NOT NULL,
department	 VARCHAR(30),	
salary	NUMERIC(10,2)	,
joining_date DATE, 	
age	INTEGER	);
SELECT *FROM CUSTOMER;


SELECT * FROM customer;


SELECT employee_id, first_name, last_name, department
FROM customer
WHERE department = 'HR' ORDER BY employee_id ASC;

SELECT employee_id, first_name, last_name, salary
FROM customer
ORDER BY salary DESC
LIMIT 5;

SELECT first_name, last_name, joining_date
FROM customer
WHERE joining_date > '2022-01-01'
ORDER BY joining_date ASC;



-- 1. Average salary of all employees
SELECT AVG(salary) AS avg_salary FROM customer;

-- Total salary by department
SELECT department, SUM(salary) AS total_salary
FROM customer
GROUP BY department
ORDER BY total_salary DESC;

-- . Count of employees in each department
SELECT department, COUNT(*) AS num_customer
FROM customer
GROUP BY department;



CREATE TABLE departments (
  dept_name TEXT PRIMARY KEY,
  location  TEXT
);



-- INNER JOIN: customer with matching department info
SELECT e.employee_id, e.first_name, e.department, d.location
FROM customer e
INNER JOIN departments d ON e.department = d.dept_name;

-- LEFT JOIN: show all employees even if no department info
SELECT e.employee_id, e.first_name, e.department, d.location
FROM customer e
LEFT JOIN departments d ON e.department = d.dept_name;

-- RIGHT JOIN: show all departments even if no employees
SELECT e.first_name, e.department, d.location
FROM customer e
RIGHT JOIN departments d ON e.department = d.dept_name;





SELECT *FROM customer;

-- Subquery: employees earning above department average
SELECT employee_id, first_name, department, salary
FROM customer e
WHERE salary > (
    SELECT AVG(salary)
    FROM  customer
  WHERE  department= e.department
);

-- Average salary per department
SELECT department, AVG(salary) AS avg_salary
FROM  customer
GROUP BY department;





-- View: employee summary with salary > 50,000
CREATE VIEW high_salary_employees AS
SELECT employee_id, first_name, last_name, department, salary
FROM customer
WHERE salary > 50000;

-- Materialized view: avg salary by department
CREATE MATERIALIZED VIEW mv_avg_salary_by_dept AS
SELECT department, AVG(salary) AS avg_salary
FROM customer
GROUP BY department;

-- Refresh materialized view when data changes
REFRESH MATERIALIZED VIEW mv_avg_salary_by_dept;






-- Rank employees by salary within each department
SELECT employee_id, first_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_in_dept
FROM customer;

-- Running total of salaries by joining date
SELECT employee_id, first_name, salary, joining_date,
       SUM(salary) OVER (ORDER BY joining_date) AS running_total_salary
FROM customer;

-- Percent rank of salary across all employees
SELECT employee_id, first_name, salary,
       PERCENT_RANK() OVER (ORDER BY salary) AS salary_percentile
FROM customer;






-- =====================================================
-- Task 4: SQL for Data Analysis (Employee Dataset)
-- =====================================================

-- 1. Create base table
DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE employees (
  employee_id   SERIAL PRIMARY KEY,
  first_name    TEXT,
  last_name     TEXT,
  department    TEXT,
  salary        NUMERIC(10,2),
  joining_date  DATE
);

-- 2. (Optional) Sample data insert if CSV not imported
-- INSERT INTO employees (first_name, last_name, department, salary, joining_date) VALUES
-- ('John', 'Doe', 'HR', 55000, '2021-01-15'),
-- ('Jane', 'Smith', 'Finance', 72000, '2019-03-20'),
-- ('Ali', 'Khan', 'IT', 65000, '2020-07-11'),
-- ('Maria', 'Garcia', 'Sales', 48000, '2022-05-30'),
-- ('David', 'Lee', 'Finance', 80000, '2018-11-02');

-- =====================================================
-- a) Basic SELECT / WHERE / ORDER BY
-- =====================================================

-- All employees
SELECT * FROM employees;

-- Employees from HR
SELECT employee_id, first_name, last_name, department
FROM employees
WHERE department = 'HR';

-- Top 5 highest paid employees
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 5;

-- Employees joined after 2020
SELECT first_name, last_name, joining_date
FROM employees
WHERE joining_date > '2020-01-01'
ORDER BY joining_date ASC;

-- =====================================================
-- b) Aggregates & GROUP BY
-- =====================================================

-- Average salary of all employees
SELECT AVG(salary) AS avg_salary FROM employees;

-- Total salary by department
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC;

-- Count of employees in each department
SELECT department, COUNT(*) AS num_employees
FROM employees
GROUP BY department;

-- =====================================================
-- c) JOINS (with departments table)
-- =====================================================

DROP TABLE IF EXISTS departments CASCADE;
CREATE TABLE departments (
  dept_name TEXT PRIMARY KEY,
  location  TEXT
);

INSERT INTO departments VALUES
('HR', 'New York'),
('Finance', 'London'),
('IT', 'San Francisco'),
('Sales', 'Dubai');

-- INNER JOIN
SELECT e.employee_id, e.first_name, e.department, d.location
FROM employees e
INNER JOIN departments d ON e.department = d.dept_name;

-- LEFT JOIN
SELECT e.employee_id, e.first_name, e.department, d.location
FROM employees e
LEFT JOIN departments d ON e.department = d.dept_name;

-- RIGHT JOIN
SELECT e.first_name, e.department, d.location
FROM employees e
RIGHT JOIN departments d ON e.department = d.dept_name;

-- =====================================================
-- d) Subqueries & Avg salary per department
-- =====================================================

-- Employees earning above department average
SELECT employee_id, first_name, department, salary
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department = e.department
);

-- Average salary per department
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

-- =====================================================
-- e) Views & Materialized Views
-- =====================================================

-- View: high salary employees
DROP VIEW IF EXISTS high_salary_employees CASCADE;
CREATE VIEW high_salary_employees AS
SELECT employee_id, first_name, last_name, department, salary
FROM employees
WHERE salary > 50000;

-- Materialized view: avg salary by department
DROP MATERIALIZED VIEW IF EXISTS mv_avg_salary_by_dept;
CREATE MATERIALIZED VIEW mv_avg_salary_by_dept AS
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

-- Refresh materialized view
REFRESH MATERIALIZED VIEW mv_avg_salary_by_dept;

-- =====================================================
-- f) Window Functions
-- =====================================================

-- Rank employees by salary within department
SELECT employee_id, first_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_in_dept
FROM employees;

-- Running total of salaries by joining date
SELECT employee_id, first_name, salary, joining_date,
       SUM(salary) OVER (ORDER BY joining_date) AS running_total_salary
FROM employees;

-- Percent rank of salary across all employees
SELECT employee_id, first_name, salary,
       PERCENT_RANK() OVER (ORDER BY salary) AS salary_percentile
FROM employees;

-- =====================================================
-- END OF SCRIPT
-- =====================================================

