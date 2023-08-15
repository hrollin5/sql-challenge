-- DATA ANALYSIS

/*List the employee number, last name, first name, sex, 
and salary of each employee.*/

SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary
  FROM employees AS emp
	   JOIN salaries AS sal
	   ON emp.emp_no = sal.emp_no

/*List the first name, last name, and hire date for the 
employees who were hired in 1986.*/

SELECT first_name, last_name, hire_date
  FROM employees
 WHERE (EXTRACT(YEAR FROM hire_date)) = 1986
	
/*List the manager of each department along with their department 
number, department name, employee number, last name, and first name.*/

SELECT dm.dept_no, d.dept_name, emp.last_name, emp.first_name
  FROM dept_manager as dm
	   JOIN departments AS d
	   ON dm.dept_no = d.dept_no
	   JOIN employees as emp
	   ON dm.emp_no = emp.emp_no
		
/*List the department number for each employee along with that 
employee’s employee number, last name, first name, and department name.*/

SELECT de.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
  FROM employees AS e
	   JOIN dept_emp as de
	   ON de.emp_no = e.emp_no
	   JOIN departments AS d
	   ON d.dept_no = de.dept_no
 ORDER BY dept_no, last_name, first_name

/*List first name, last name, and sex of each employee whose first name is 
Hercules and whose last name begins with the letter B.*/

SELECT first_name, last_name, sex
  FROM employees
 WHERE first_name = 'Hercules'
   AND last_name LIKE 'B%'
 ORDER BY last_name

/*List each employee in the Sales department, including their employee 
number,last name, and first name.*/

--With JOIN
SELECT e.emp_no, e.last_name, e.first_name
  FROM employees AS e
	   JOIN dept_emp AS de
	     ON de.emp_no = e.emp_no
	   JOIN departments AS d
	     ON d.dept_no = de.dept_no
 WHERE dept_name = 'Sales'
 
--With subquery
SELECT emp_no, last_name, first_name
  FROM employees
 WHERE emp_no IN
	   (SELECT emp_no
	      FROM dept_emp
	     WHERE dept_no IN
			   (SELECT dept_no
			      FROM departments
			     WHERE dept_name = 'Sales'))
 ORDER BY emp_no

/*List each employee in the Sales and Development departments, including 
their employee number, last name, first name, and department name.*/

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
  FROM employees AS e
	   JOIN dept_emp AS de
	     ON de.emp_no = e.emp_no
	   JOIN departments AS d
	     ON d.dept_no = de.dept_no
 WHERE dept_name IN ('Sales', 'Development')
 
/*List the frequency counts, in descending order, of all the employee 
last names (that is, how many employees share each last name)*/
 
SELECT COUNT(last_name) AS last_name_count, last_name
  FROM employees
 GROUP BY last_name
 ORDER BY 1 DESC