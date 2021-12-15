Select Department, 
concat(employees.first_name, ' ', employees.last_name) as Manager,  
Number_of_Employees
from
(select  departments.dept_name as Department, 
count(distinct(employees.emp_no))-1 as Number_of_Employees
from departments
join dept_manager on departments.dept_no = dept_manager.dept_no
join dept_emp on departments.dept_no = dept_emp.dept_no
join employees on dept_emp.emp_no = employees.emp_no
group by departments.dept_name) as Employees_per_department

join departments on Employees_per_department.Department = departments.dept_name
join dept_manager on departments.dept_no = dept_manager.dept_no
join employees on dept_manager.emp_no = employees.emp_no

where dept_manager.to_date = '9999-01-01'


;