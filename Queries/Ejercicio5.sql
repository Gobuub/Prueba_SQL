# if appears group by error close workbench and run this line of command on the
#mysql terminal >>
# SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
select older_emp.Title as Title,
older_emp.Employees as Employees, 
Former_Employee, New_Employee
from (select ehd.Title as Title, 
concat(employees.first_name, ' ', employees.last_name) as Former_Employee,
Employees
from
(select titles.title as Title, 
count(distinct(employees.emp_no)) As Employees,
min(titles.from_date) as Min_from_date,
max(titles.from_date) as Max_from_date,
min(employees.hire_date) as Min_hire_date,
max(employees.hire_date) as Max_hire_date 
from employees
join titles on employees.emp_no = titles.emp_no
group by Title ) as ehd

join titles on ehd.Title = titles.title
join employees on titles.emp_no = employees.emp_no

where titles.from_date = ehd.Min_from_date 
and titles.title = ehd.Title 
group by ehd.Title
order by from_date) as older_emp 

join (select ehd.Title as Title, 
concat(employees.first_name, ' ', employees.last_name) as New_Employee
from
(select titles.title as Title, 
count(distinct(employees.emp_no)) As Employees,
min(titles.from_date) as Min_from_date,
max(titles.from_date) as Max_from_date,
min(employees.hire_date) as Min_hire_date,
max(employees.hire_date) as Max_hire_date 
from employees
join titles on employees.emp_no = titles.emp_no
group by Title ) as ehd

join titles on ehd.Title = titles.title
join employees on titles.emp_no = employees.emp_no

where titles.from_date = ehd.Max_from_date 
and titles.title = ehd.Title 
group by ehd.Title
order by from_date) as new_emp on older_emp.Title = new_emp.Title
;
