Select Deparment, Manager, 
	Previous_Manager 
    from
	#create a query (table) and select the columns that we need
    (select distinct departments.dept_name as Deparment, 
    #this counts only diferent departments
    concat(employees.first_name, ' ', employees.last_name)as Manager ,
    lag(concat(employees.first_name, ' ', employees.last_name), 1) 
    #this function takes the value of the index before this and create a column with this
    over (partition by departments.dept_name  order by dept_manager.to_date) as Previous_Manager,
    #this sentence create a partition 
    from_date as Starts_Contract,
    to_date as End_Contract
    from departments

    join dept_manager on departments.dept_no = dept_manager.dept_no
    join employees on dept_manager.emp_no = employees.emp_no) as Managers
where End_Contract = '9999-01-01'
;


