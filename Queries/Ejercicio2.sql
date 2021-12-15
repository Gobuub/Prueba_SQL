Select Deparment, Manager, Previous_Manager from
	(select distinct departments.dept_name as Deparment, 
    concat(employees.first_name, ' ', employees.last_name)as Manager ,
    lag(concat(employees.first_name, ' ', employees.last_name), 1) 
    over (partition by departments.dept_name  order by dept_manager.to_date) as Previous_Manager,
    from_date as Starts_Contract,
    to_date as End_Contract
    from departments

    join dept_manager on departments.dept_no = dept_manager.dept_no
    join employees on dept_manager.emp_no = employees.emp_no) as Managers
where End_Contract = '9999-01-01'
;


