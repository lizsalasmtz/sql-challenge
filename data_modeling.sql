-- Steps to perform before running this code:
-- 1. create a database called sql-challenge
-- 2. check that csv files are readable by the database user and change permissions
-- 3. update the path to the csv files

--Create a table of titles, set title_id as primary key
DROP TABLE IF EXISTS public.titles CASCADE;
CREATE TABLE public.titles (
	title_id VARCHAR NOT NULL PRIMARY KEY,
	title VARCHAR NOT NULL
);
COPY public.titles FROM 'C:\Users\habib\OneDrive\Documents\ANALYTICS\Github\sql-challenge\data_titles.csv' DELIMITER ',' CSV HEADER;

--Create a table of departments, set dept_no as primary key
DROP TABLE IF EXISTS public.departments CASCADE;
CREATE TABLE public.departments (
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR NOT NULL
);
COPY public.departments FROM 'C:\Users\habib\OneDrive\Documents\ANALYTICS\Github\sql-challenge\data_departments.csv' DELIMITER ',' CSV HEADER;

-- Import the employees table, set emp_no as primary key and emp_title_id as a foreign key
DROP TABLE IF EXISTS public.employees CASCADE;
CREATE TABLE public.employees (
		emp_no INTEGER NOT NULL PRIMARY KEY,
		emp_title_id VARCHAR NOT NULL,
		birth_date VARCHAR NOT NULL,
		first_name VARCHAR NOT NULL,
		last_name VARCHAR NOT NULL,
		sex VARCHAR NOT NULL,
		hire_date VARCHAR NOT NULL,
		FOREIGN KEY (emp_title_id) REFERENCES public.titles(title_id)
	);
COPY public.employees FROM 'C:\Users\habib\OneDrive\Documents\ANALYTICS\Github\sql-challenge\data_employees.csv' DELIMITER ',' CSV HEADER;

-- update the two date fields from varchar to dates
ALTER TABLE public.employees ALTER COLUMN birth_date TYPE DATE 
USING to_date(birth_date, 'MM/DD/YYYY');

ALTER TABLE public.employees ALTER COLUMN hire_date TYPE DATE 
USING to_date(hire_date, 'MM/DD/YYYY');

-- import the dept-emp table and create a new primary key and make emp_no and dept_no a foreign key
DROP TABLE IF EXISTS public.dept_emp CASCADE;
CREATE TABLE public.dept_emp (
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES public.departments(dept_no)
);
COPY public.dept_emp FROM 'C:\Users\habib\OneDrive\Documents\ANALYTICS\Github\sql-challenge\data_dept_emp.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS public.dept_manager CASCADE;
CREATE TABLE public.dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INTEGER NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES public.departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no)
);
COPY public.dept_manager FROM 'C:\Users\habib\OneDrive\Documents\ANALYTICS\Github\sql-challenge\data_dept_manager.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS public.salaries CASCADE;
CREATE TABLE public.salaries (
	emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no)
);
COPY public.salaries FROM 'C:\Users\habib\OneDrive\Documents\ANALYTICS\Github\sql-challenge\data_salaries.csv' DELIMITER ',' CSV HEADER;
