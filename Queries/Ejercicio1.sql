select distinct dept_name, 
	# create a case statement, when the value on employees.gender == 'M' return 1,
    # and then count resulting the number of cases of Male or Female in the column
    count(case employees.gender when 'M' then 1 end) as Male, 
    count(case employees.gender when 'F' then 1 end) as Female
    from employees
    # join to employees the department employees table throw the number of employee
    join dept_emp on employees.emp_no = dept_emp.emp_no
    #join the departments table on department employees table throw department number
    join departments on departments.dept_no = dept_emp.dept_no 
    # this two joins  are necessary to obtain the departments and the employee per deparment

    group by departments.dept_name;
    # finish with group by per deparment