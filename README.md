# Task 4 — SQL for Data Analysis (PostgreSQL)

This project contains SQL scripts and queries to analyze an **customer Dataset** using PostgreSQL.  
The dataset includes employee details such as `employee_id`, `first_name`, `last_name`, `department`, `salary`, and `joining_date`.

---

## 📂 Repository Structure
task4-sql-data-analysis/
├── data/ # (Optional) contains employees.csv
├── schema.sql # Table creation script
├── task4_queries.sql # All queries for the task
├── screenshots/ # Query outputs & EXPLAIN ANALYZE screenshots
└── README.md # Documentation


---

## 🛠️ Setup Instructions

### 1. Install PostgreSQL
- Download from: [https://www.postgresql.org/download/](https://www.postgresql.org/download/)
- Verify installation:
  ```bash
  psql --version

### 2. Create Database
  createdb employee_db
psql -d employee_db -U postgres

### 3. Create Tables
CREATE TABLE employees (
  employee_id   SERIAL PRIMARY KEY,
  first_name    TEXT,
  last_name     TEXT,
  department    TEXT,
  salary        NUMERIC(10,2),
  joining_date  DATE
);

### 4. Import Dataset
 import  dateset which  downloanded  from the kiggle -- 
\copy employees
(employee_id, first_name, last_name, department, salary, joining_date) 
FROM 'full/path/to/employees.csv'
CSV HEADER;

### 5. Run Queries
SQL Queries Implemented
a) Basic SELECT / WHERE / ORDER BY
Filter employees by department
Top N highest-paid employees
Employees joined after a specific year

b) Aggregates & GROUP BY
Average salary
Total salary per department
Count of employees per department

c) JOINS (with departments table)
INNER JOIN (employees + department info)
LEFT JOIN (all employees, even if no department info)
RIGHT JOIN (all departments, even if no employees)

d) Subqueries
Employees earning above department average
Average salary per department

e) Views & Materialized Views
high_salary_employees view
mv_avg_salary_by_dept materialized view

f) Window Functions
Rank employees by salary within department
Running salary total by joining date
Salary percentile across all employees

 
 



