select * from departments;
desc departments;
select * from employees;

select first_name || ' ' || last_name as "e_name", department_name as "d_name", job_title as "j_title", city, salary
from EMPLOYEES inner join DEPARTMENTS using(DEPARTMENT_ID)
  inner join Locations using(location_id)
	inner join jobs using(job_id)
		where salary BETWEEN 7000 AND 15000
				 and first_name || ' ' || last_name like '%a%';