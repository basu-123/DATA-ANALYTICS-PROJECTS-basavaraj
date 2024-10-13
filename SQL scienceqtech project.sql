create database employee;
use employee;
select * from emp_record_table;
-- query to fetch emp id, first name.last name, gender,department from employee record table and list employees and their details of department
select emp_id,first_name,last_name,gender,dept as department
from emp_record_table;
select emp_id,first_name,last_name,gender,dept,emp_rating from emp_record_table where emp_rating <2 or emp_rating >4 or emp_rating between 2 and 4;
select * from emp_record_table;
select concat(first_name,'',last_name) as name from emp_record_table
where dept = 'finance';
-- query to list only those employees who have someone reporting to them.also showing number of repoerters(including president)
select * from emp_record_table;
select m.emp_id,e.first_name,e.last_name,m.emp_id as m_id,m.first_name as m_name from emp_record_table e
join emp_record_table m on e.manager_id=m.emp_id;

select m.emp_id as m_id , m.first_name as m_name, e.emp_id,e.first_name from emp_record_table e
join emp_record_table m on e.manager_id=m.emp_id;

select m_id as employee_id,m_name as employee_name,
count(emp_id) number_of_eporting from(
select m.emp_id as m_id , m.first_name as m_name,e.emp_id,e.first_name
from emp_record_table e
join emp_record_table m on e.manager_id=m.emp_id)a
group by m_id, m_name;

-- query to list down all employees from the healthcare and finamce departments using union 
select * from emp_record_table;
select * from emp_record_table where dept= 'healthcare'
union
select * from emp_record_table where dept='finance';

/*  query to list down all employee details such as emp_id, first name, last name, role, department, 
and emp rating grouped by dept. also incluse respective employee  rating along with max emp rating
for department*/
select * from emp_record_table;
select emp_id, first_name,last_name,a.role,dept as department,emp_rating
from emp_record_table a;
select dept as department, max(emp_rating) as max_rating_depat
from emp_record_table where dept !='all' group by dept;
with emp as (select emp_id,first_name,last_name,a.role, dept as department,emp_rating
from emp_record_table a),
groupby as (select dept as department,max(emp_rating) as max_rating_depat
from emp_record_table where dept != 'all'group by dept)
select a.*,b. max_rating_depat from emp a join   groupby b on a.department=b.department;
/* query ton calculate max and min salary of employees in each role*/
select * from emp_record_table;
select dept as department , min(salary) as minimum_sal_department,
max(salary) as maximum_sal_department
from emp_record_table where dept!= 'all'
group by dept;
/* query to assign ranks to each employee based on their experience*/
select * from emp_record_table;
select *, dense_rank() over (order by exp desc) rnk from emp_record_table;
/* query to create a view that displays employees in various countries whose salary more than six thousand*/
select * from emp_record_table;
create view empview as select emp_id ,first_name +''+last_name as name,gender,country,salary
from emp_record_table where salary>6000;
select * from empview;
/* nested query to find employees with experience of mopre than ten years */
select * from emp_record_table;
select * from emp_record_table where exp in (
select exp  from emp_record_table where exp>10);


/* query using stored functions in the project table to check whether job profile assigned to each employee in the data 
science team matches the organization set standard */
/*employee with exp less than 2 years assign junior data scienists
employee with exp from 2 to 5 years assign associate data scienist
employees with exp from 5 to 10 years assid=gn senior datascienist
employes with exp from 10 t0 12 years assign lead data scietist*/
select * from  data_science_team;
alter function employeeexp (@exp int)
return nvarchar(50)
begin
declare @jobprofile nvarchar(50)
if @exp<= 2
set @jobprofile='junior data scientisst'
else if @exp<=5
set @jobprofile = 'associate data scientist'
else if @exp <=10
set @jobprofile <='senior data scientist'
else if @exp<- 12
set @jobprofile = 'lead data scientist'
else
set @jobprofile = 'manager'
return @jobprofile
end;

/* index to improve the cost and performance of the query to find employee whose firstname is eric in employee table*/
create index idx_emp_rec_table on emp_record_table (first_name);
select * from emp_record_table where first_name = 'ERIC';

-- query to calculate the bonus for all employees based on rating and szalaries*/
select * from emp_record_table;
select * into demo from emp_record_table;
select * from demo;
select emp_rating , (0.05*emp_rating) hike from demo;
update demo set salary = (select salary +(select salary * 0.05emp_rating));
select * from demo;
select * from emp_record_table;




 