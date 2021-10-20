# Pewlett-Hackard-Analysis
 Pewlett-Hackard-Analysis

 ## Overview of Project
Management has asked that we determine the number of retiring employees by title. Additionally, they have requested that we identify employees who are eligible to participate in a mentorship program. Management has requested this information to prepare for the "silver tsunami" as many employees are reaching retirement age. 

### Results
Based on the following queries we can safely assume that 
-There are 90k+ employees that are of retirement age.
-57k+ employees are Senior level employees based off titles
-The number of Senior Engineers is the most exposed group with over 90% of all senior engineers being of retirement age
-There does seem to be a solid group of lower-level engineers that could be promoted
-There does not seem to be enough mentors to mentor lower-level employees should everyone of retirement age leave the company immediately

Began with a query to show all the employees were born between 1952 - 1955. 
        --retiring employees by titles
        SELECT  e.emp_no
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

![RetiringEmployeesByTitle](https://github.com/john10roberts/Pewlett-Hackard-Analysis/blob/main/Data/retirement_titles.csv)

Next, we removed duplicated employees that have had title changes over the years using the DISTINCT ON statement to retrieve the first occurrence of the employee number defined by the ON () clause.
        --Retrieve distinct employees by using DISTINCT ON emp_no
        SELECT DISTINCT ON (emp_no) emp_no
        ,first_name
        ,last_name
        ,title
        INTO unique_titles
        FROM retirement_titles
        ORDER BY emp_no, to_date DESC;

![RetiringEmployeesUniqueTitles](https://github.com/john10roberts/Pewlett-Hackard-Analysis/blob/main/Data/unique_titles.csv)

Then we grouped unique titles to get a count of the number of employees retiring by title
        SELECT COUNT (title)
        ,title
        INTO retiring_titles
        FROM unique_titles
        GROUP BY TITLE
        Order BY COUNT(title) DESC;

![RetiringEmployeesCountByTitle](https://github.com/john10roberts/Pewlett-Hackard-Analysis/blob/main/Data/retiring_titles.csv)

Then we created a query to show all the employees that would be eligible to participate in a mentorship program. These employees would be active employees who had birthdates between 1-1-1965 and 12-31-1965. We will once again use the DISTINCT ON clause to remove duplicates. 
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

![MentorshipEligibility](https://github.com/john10roberts/Pewlett-Hackard-Analysis/blob/main/Data/mentorship_eligibilty.csv)

Lastly, we created a mentorship eligibility count on Titles so that we could quickly show management the number of mentors we had vs the number of employees retiring by titles
        SELECT COUNT (title)
        ,title
        INTO mentorship_eligibility_count
        FROM mentorship_eligibility
        GROUP BY TITLE
        Order BY COUNT(title) DESC;

![MentorshipEligibilityCount](https://github.com/john10roberts/Pewlett-Hackard-Analysis/blob/main/Data/mentorship_eligibilty_count.csv)

### Summary
As the "silver tsunami" begins to have an impact on the company, there are a total of 90,398 employees that are of retirement age. Our total workforce is 300,024 if everyone who was of retirement age left the company today, we would a third of the workers. 

![MentorshipEligibilityCount](https://github.com/john10roberts/Pewlett-Hackard-Analysis/blob/main/Data/all_active_employees_count.csv)

Additionally, there does not appear to be enough workers eligible for the mentorship program to oversee all the employees that would be leaving. There are a total of 1549 employees that are eligible for the mentorship program. This would be 1% of the existing workforce. That does not seem substantial enough to prepare the company should a third of the workers decide to retire. 


