select distinct dept_name, 
    count(case employees.gender when 'M' then 1 end) as Male, 
    count(case employees.gender when 'F' then 1 end) as Female
    from employees
    join dept_emp on employees.emp_no = dept_emp.emp_no
    join departments on departments.dept_no = dept_emp.dept_no 

    group by departments.dept_name;