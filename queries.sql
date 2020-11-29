--List the following details of each employee: employee number, last name, first name, sex, and salary.
DROP TABLE IF EXISTS public.rpt_employee_details;
CREATE TABLE public.rpt_employee_details AS
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM public.employees LEFT JOIN salaries ON employees.emp_no = salaries.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.
DROP TABLE IF EXISTS public.rpt_employees_hired_in_1986;
CREATE TABLE public.rpt_employees_hired_in_1986 AS
SELECT employees.first_name, employees.last_name, employees.hire_date 
FROM public.employees WHERE hire_date between '1986-01-01' AND '1987-01-01';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
DROP TABLE IF EXISTS public.rpt_manager_info;
CREATE TABLE public.rpt_manager_info AS
SELECT dept_manager.dept_no, dept_manager.emp_no, departments.dept_name, employees.first_name, employees.last_name
FROM public.dept_manager 
LEFT JOIN public.departments ON dept_manager.dept_no = dept_manager.dept_no
LEFT JOIN public.employees ON dept_manager.emp_no = employees.emp_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
DROP TABLE IF EXISTS public.rpt_employees_and_deptname;
CREATE TABLE public.rpt_employees_and_deptname AS
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM public.employees
LEFT JOIN public.dept_emp ON employees.emp_no = dept_emp.emp_no
LEFT JOIN public.departments ON dept_emp.dept_no = departments.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
DROP TABLE IF EXISTS public.rpt_hercules_b;
CREATE TABLE public.rpt_hercules_b AS
SELECT employees.first_name, employees.last_name, employees.sex
FROM public.employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
DROP TABLE IF EXISTS public.rpt_sales_dept_employees;
CREATE TABLE public.rpt_sales_dept_employees AS
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM public.employees
LEFT JOIN public.dept_emp ON employees.emp_no = dept_emp.emp_no
LEFT JOIN public.departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
DROP TABLE IF EXISTS public.rpt_sales_and_dev_employees;
CREATE TABLE public.rpt_sales_and_dev_employees AS
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM public.dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name IN ('Sales', 'Development');

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
DROP TABLE IF EXISTS public.rpt_last_name_count;
CREATE TABLE public.rpt_last_name_count AS
SELECT employees.last_name,
COUNT(last_name) AS frequency
FROM public.employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;