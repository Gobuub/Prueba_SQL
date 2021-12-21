# if appears group by error close workbench and run this line of command on the
#mysql terminal >>
# SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
Select Max_Salaries.Department as Department,
Employee_max_salary,
Max_salary,
Employee_min_salary,
Min_salary
from
#make two sub-queries one for MAX salary employee and other for MIN salary employee
#and then add it like a column
(select Department, 
concat(employees.first_name, ' ', employees.last_name) as Employee_max_salary,
Max_salary
from
(Select departments.dept_name as Department, 
max(salaries.salary) As Max_salary
from departments
join dept_emp on departments.dept_no = dept_emp.dept_no
join employees on dept_emp.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no

group by departments.dept_name) as Max_Salaries_per_Department

join departments on Max_Salaries_per_Department.Department = departments.dept_name
join dept_emp on departments.dept_no = dept_emp.dept_no
join employees on dept_emp.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no

where salaries.salary = Max_Salaries_per_Department.Max_salary) as Max_Salaries

join (select Department, 
concat(employees.first_name, ' ', employees.last_name) as Employee_min_salary,
Min_salary
from
(Select departments.dept_name as Department, 
min(salaries.salary) as Min_salary
from departments
join dept_emp on departments.dept_no = dept_emp.dept_no
join employees on dept_emp.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no

group by departments.dept_name) as Salaries_per_Department

join departments on Salaries_per_Department.Department = departments.dept_name
join dept_emp on departments.dept_no = dept_emp.dept_no
join employees on dept_emp.emp_no = employees.emp_no
join salaries on employees.emp_no = salaries.emp_no

where salaries.salary = Salaries_per_Department.Min_salary  ) as Min_Salaries 
on Max_Salaries.Department = Min_Salaries.Department 
;