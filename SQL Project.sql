##load the database
select * from employees; 

## view all the tables in database
show tables;

## view details of columns of table
show columns from employees;

select * from employees;
SELECT first_name FROM employees WHERE first_name LIKE 'A%'; ## view the names starting with A
select last_name from employees where last_name like '%M'; ## view the last_names ending with M
select birth_date from employees WHERE birth_date >= '1950-01-01' AND birth_date <= '1999-01-01'; ## view the date between certain period
select count(gender) from employees where gender like 'M'; ## value count of M in gender
SELECT * FROM employees where gender IS NULL;  ## check null values --- (no null value)
select * from employees where hire_date is not null; ## view not null

## lets view all the other tables in database one by one
select * from departments; --- (nine unique rows with 2 columns with information of department)
show columns from departments; --- (details of columns)
select * from departments order by dept_no; ### (ordered the table in ascending manner by dept_no)
/* So departments table consists the information of all the departments and the unique code by which they are denoted*/
 
select * from dept_emp; --- (4 columns with 331603 rows giving information of employees department where they work )
show columns from dept_emp; --- (details of columns)

select * from dept_manager; --- (4 columns with 24 rows giving information of employees department )
show columns from dept_manager; --- (details of columns)

select * from employees; --- (6 columns with 300024 rows giving information of employees )
show columns from employees; --- (details of columns )

select * from salaries; --- (4 columns with 967330 rows giving information of salary of employees )
show columns from salaries; --- (details of columns)

select * from titles; --- (4 columns with 443308 rows giving information of employees post )
show columns from titles; --- (details of columns)

/* here the database employees consist of 6 tables 
 this 6 tables give the information of employees, there salary, department, post */

### Unique values
select distinct dept_name from departments; --- (9 unique departments)
select distinct dept_no from dept_emp; --- (9 unique numbers each department has given unique number)
select distinct from_date from dept_emp; --- (6393 unique dates on which employees started their first working day)
select distinct to_date from dept_emp; --- (6085 unique dates when employees contract will end)
select distinct from_date from dept_manager; --- (16 unique dates when manager got appointed at particular department)
select distinct to_date from dept_manager; --- (16 unique dates when manager was removed from his post of manager at particular department)
select distinct first_name from employees; --- (1275 unique first names, that means lot of employees have same first_name)
select distinct last_name from employees; --- (1637 unique last names)
select distinct gender from employees; --- (2 unique gender)
select distinct hire_date from employees; --- (5434 unique dates when employees got hired)
select distinct title from titles; --- (7 unique post on which employees got posted)

### max and min values
select min(to_date) from dept_emp; --- (1985-02-17 is min date)
select max(from_date) from dept_emp; --- (2002-08-01 is max date)
select min(to_date) from dept_manager; --- (1988-09-09is min date)
select max(from_date) from dept_manager; --- (1996-08-30 is max date)
select min(birth_date) from employees; --- (1952-02-01 is the birth_date of the oldest employee hired)
select max(birth_date) from employees; --- (1965-02-01 is the birth_date of the youngest employee hired)
select min(hire_date) from employees; --- (1985-01-01 is the date on which first employee was hired)
select max(hire_date) from employees; --- (2000-01-28 is the date on which last employee was hired)
select min(salary) from salaries; --- (38735 is the lowest salary employee gets paid)
select max(salary) from salaries; --- (158220 is the highest salary employee gets paid)
select min(from_date) from salaries; --- (1985-01-01 is the date on which employee first working day started)
select max(to_date) from salaries; --- (9999-01-01 is the date till which employees will get paid)

### here the max date year is 9999, lets see whether it's is typing mistake or anything else
select * from salaries;
/* the contract period of many employee is renewed and after renwal of contract many times the employee must have got permenant
   post in the company so the year 9999 is fixed to identify that he or she is permanent*/
   
### let's count which department has what number of employees
SELECT departments.dept_name, COUNT(*) AS employee_count FROM departments 
JOIN dept_emp ON departments.dept_no = dept_emp.dept_no GROUP BY dept_name ORDER BY employee_count;
/* Finance department has the least number of employees and then comes Human Resources, Quality Management, Marketing, Research, 
Customer Service, Sales, Production and Development contains the most number of employees in ascending order*/  

### let's view the total amount of salary each department gets paid
select b.dept_name, sum(c.salary) Total_salary from dept_emp a
 left join departments b on a.dept_no = b.dept_no
 join salaries c on a.emp_no = c.emp_no group by  b.dept_name order by Total_salary ;
/* here Human Resources is the least paid department and then comes Quality Management, Finance, Research, 
Customer Service, Marketing, Sales, Production and Development are most paid departments in ascending order */

### now let's view the distribution of employees on 7 different post
select title, count(emp_no) Total_employees from titles group by title order by Total_employees;
/* Manager post has least number of employees that is 24 employee, 
and then Assistant Engineer with 15128 employees, then comes Technique Leader, Senior Staff, Senior Engineer,
Staff and Engineer with most employees that is 115003*/

### gender wise count of employees 
select gender, count(emp_no) Total_employees from employees group by gender ;
/* there are 179973 Male employee and 120051 Female employee */

### now we will see which post gets highest salary
select b.title as Post, max(a.salary) as Highest_salary  from titles b join salaries a on b.emp_no = a.emp_no group by Post order by Highest_salary;
/* Manager has low salary and then comes Assistant Engineer, Engineer, Senior Engineer, Technique Leader, Staff and  
Senior staff is gets highest salary in all post */