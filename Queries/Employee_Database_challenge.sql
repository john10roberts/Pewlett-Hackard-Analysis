-- drop all tables prior to running queries
drop table unique_titles;
drop table retirement_titles;
drop table retiring_titles;
drop table mentorship_eligibility;

--retiring employees by titles
SELECT 	e.emp_no
		,e.first_name
		,e.last_name
		,t.title
		,t.from_date
		,t.to_date
INTO retirement_titles		
FROM employees AS e INNER JOIN 
titles AS t ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

--Retrive distinct employees by using DISTINCT ON emp_no
SELECT DISTINCT ON (emp_no) emp_no
,first_name
,last_name
,title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

--Retrieve the count of retiring employees by job title
SELECT COUNT (title)
,title
INTO retiring_titles
FROM unique_titles
GROUP BY TITLE
Order BY COUNT(title) DESC;

--Query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no
,e.first_name
,e.last_name
,e.birth_date
,d.from_date
,d.to_date
,t.title
INTO mentorship_eligibility
FROM employees as e INNER JOIN
dept_emp as d on e.emp_no = d.emp_no INNER JOIN
titles as t on e.emp_no = t.emp_no
WHERE d.to_date = '9999-01-01' and e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no;

--Retrieve the count of mentorship eligible employees by title
SELECT COUNT (title)
,title
INTO mentorship_eligibility_count
FROM mentorship_eligibility
GROUP BY TITLE
Order BY COUNT(title) DESC;

--Query of all employees
SELECT DISTINCT ON (e.emp_no) e.emp_no
,e.first_name
,e.last_name
,e.birth_date
,d.from_date
,d.to_date
,t.title
INTO all_active_employees
FROM employees as e INNER JOIN
dept_emp as d on e.emp_no = d.emp_no INNER JOIN
titles as t on e.emp_no = t.emp_no
ORDER BY e.emp_no;

--Retrieve the count of all employees by title
SELECT COUNT (title)
,title
INTO all_active_employees_count
FROM all_active_employees
GROUP BY TITLE
Order BY COUNT(title) DESC;