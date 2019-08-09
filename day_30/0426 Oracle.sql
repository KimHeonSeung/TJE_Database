select *
from departments;

select *
from locations;

select *
from regions;

select *
from countries;

select *
from jobs;

select *
from job_history;

select *
from employees;

-- ���̺� ��Ī �ο��ϱ�. ������ ������ ���̺� �̸��� ����ϰ� ������ �ΰ� �����ϸ� �ȴ�.
select  e.first_name, d.department_name, e.employee_id, d.department_id
from employees e, departments d
where e.department_id = d.DEPARTMENT_ID and lower(e.first_name) = 'david'
order by first_name;

-- �þ�Ʋ���� �ٹ��ϴ� ����� �̸��� �޿� ���
select e.first_name || ' ' || e.last_name as �̸�, salary as �޿�
from employees e, departments d, locations l
where e.DEPARTMENT_ID = d.DEPARTMENT_ID and d.LOCATION_ID = l.LOCATION_ID and lower(l.CITY) = 'seattle'
order by salary desc;

-- Accounting �μ����� �ٹ��ϴ� ����� ���
select e.first_name || ' ' || e.last_name as �̸�, hire_date as �Ի���
from employees e, departments d
where e.department_id = d.department_id and d.department_name = 'Accounting';

-- ������ manager�� ����� �̸�, �μ���
select e.first_name || ' ' || e.last_name as �̸�, d.DEPARTMENT_name as �μ���, j.job_title as ����
from employees e, departments d, jobs j
where e.department_id = d.department_id and e.job_id= j.job_id and lower(j.job_title) like '%manager%'
order by ����;

-- �� ������ �ٹ����� ����� ���
-- ������, �����
-- ���μ� -1 = ���Ǽ�
select c.country_name as ������, count(*) as �����
from locations l, countries c, employees e, departments d
where e.department_id = d.department_id and d.location_id = l.location_id and l.country_id = c.country_id
group by c.country_name
order by �����;

-- ���̺� ����
create table Salary_Grade (
  grade number(1), 
  min_salary number(10,2),
  max_salary number(10,2)
);

select *
from salary_grade;

select *
from employees
order by salary desc;

-- ���� �߰�
insert into salary_grade values (1, 2000, 5000);
insert into salary_grade values (2, 5001, 10000);
insert into salary_grade values (3, 10001, 15000);
insert into salary_grade values (4, 15001, 20000);
insert into salary_grade values (5, 20001, 25000);

-- ����� �޿��� ����� ���
select first_name||' '||last_name as �̸�, salary as �޿�, grade as ���
from employees e, salary_grade s
where e.salary between s.min_salary and s.max_salary;

-- ��޺� ����� ���
select grade as ���, count(*) as �����
from employees e, salary_grade s
where e.salary between s.min_salary and s.max_salary
group by grade
order by grade;

-- �׷캰 ��ձ޿�
select grade as ���, count(*) as �����, round(avg(salary),2) as ��ձ޿�
from employees e, salary_grade s
where e.salary between s.min_salary and s.max_salary
group by grade
order by grade;

-- manager_id �� ���ӻ��
select *
from employees;

select e1.first_name||' '||e1.last_name as �����, e2.first_name||' '||e2.last_name as �����ڸ�
from employees e1, employees e2
where e1.manager_id = e2.employee_id;

-- �� �����ں� �����
select e2.first_name||' '||e2.last_name as �����ڸ�, count(*) as �����
from employees e1, employees e2
where e1.manager_id = e2.employee_id
group by e2.first_name||' '||e2.last_name
order by ����� desc;

-- john chen�� ���� �ٹ��ϴ� ����� ���
select e1.first_name||' '||e1.last_name as "John Chen�� ���� ���ϴ� ���", e1.salary as �޿�, e1.department_id as �μ���ȣ
from employees e1, employees e2
where lower(e2.first_name) = 'john' and lower(e2.last_name) = 'chen' and e1.department_id = e2.department_id
  -- e2�� ���� ��þ��. ��þ�� �����ϴ� ������
  and e2.employee_id != e1.employee_id
order by �޿�;

-- ŷ�� ���Ե��� ���� (manager_id = null)
-- e1�� ����� (employee ���̺��� ��ü ����� 107��)
-- e2�� employee_id�� �������
-- e1�� manager_id�� ������������� ����
-- e1�� manager_id�� �´°� ��� �׳� �߰������ְڴٴ� �ǹ�
select e1.first_name||' '||e1.last_name as �����, e2.first_name||' '||e2.last_name as �����ڸ�
-- ���ʿ��ִ� ���̺� ������ �ȸ¾Ƶ� �� �������ڴٴ� �ǹ�
from employees e1 LEFT OUTER JOIN employees e2 on e1.manager_id = e2.employee_id;

-- �Ʒ��� ���� �ۼ��ص� ��
-- select e1.first_name||' '||e1.last_name as �����, e2.first_name||' '||e2.last_name as �����ڸ�
-- from employees e1, employees e2 
-- where e1.manager_id = e2.employee_id(+);

-- ��� ���̺�� �μ� ���̺��� �����Ͽ� ��� ���̺��� �μ��� ������ �μ��� �̸��� ��µǵ���
select e.first_name||' '||e.last_name as �����, d.department_id as �μ���ȣ, d.department_name as �μ���
from employees e, departments d
where e.department_id(+) = d.department_id;
-- �Ʒ��� ���� �ᵵ �ȴ�.
select e.first_name||' '||e.last_name as �����, d.department_id as �μ���ȣ, d.department_name as �μ���
from employees e RIGHT OUTER JOIN departments d on e.department_id = d.department_id;

select e.first_name||' '||e.last_name as �����, e.hire_date, d.department_id as �μ���ȣ, d.department_name as �μ���
from employees e, departments d
where e.department_id = d.department_id(+);



-- on���� ������ ������ �����Ѵ�.
-- �׳� join���� �ᵵ inner join���� �ν�
select e.first_name||' '||e.last_name as �����, d.department_name as �μ���
from employees e inner join departments d
on e.department_id = d.department_id
where lower(e.first_name) = 'john' and lower(e.last_name) = 'chen';

-- �� ���̺� �Ȱ��� �÷��� �ִٸ� using (����Į����)���� ���� �÷��� ������ �� �ִ�.
-- using�� ���� �÷��� select���� ������ e.Į���� �̷������� �� �ʿ� ���� �׳� Į���� ������ �ȴ�.
select e.first_name||' '||e.last_name as �����, d.department_name as �μ���
from employees e inner join departments d
using (department_id)
where lower(e.first_name) = 'john' and lower(e.last_name) = 'chen';

-- natural : �÷����� �Ȱ����ų��� �˾Ƽ� ��������
-- �̸��� ���� Ÿ���� �ٸ��ٸ� ������ �߻�
select e.first_name||' '||e.last_name as �����, d.department_name as �μ���
from employees e natural join departments d
where lower(e.first_name) = 'john' and lower(e.last_name) = 'chen';

-- �� ��� �̸� ,�μ���ȣ, ������ ���� ��� (ansi Ȱ��)
-- ansi�� 3�� �̻��� �Ҷ� ������ ������ �ٽ� inner join ���̺�� on ������ �߰�
select e.first_name||' '||e.last_name as �����, department_name as �μ���, l.CITY as ���ø�
from employees e inner join departments d using (department_id) 
  inner join locations l using (location_id);

-- �� ���̺� ��� ����Ǵ� Į����  ����ϴ� �ڵ�
-- select e.first_name||' '||e.last_name as �����, department_id, l.CITY
-- from employees e natural join departments d natural join locations l;

select *
from departments;

-- table ���� ���
create table dept01
as
select *
from departments;

select *
from dept01;

create table dept02
as
select *
from departments;

select *
from dept02;

delete from dept02
where department_id > 100;

drop table dept01;
drop table dept02;
---------------------------------------------------------------
-- ���ǽĿ� ���� ���̺��� �����
create table dept01
as
select *
from departments
where mod(department_id/10 , 2) = 1;

create table dept02
as
select *
from departments
where mod(department_id/10 , 2) = 0;

select * from dept01;
select * from dept02;

-- �˻����ǿ� �������� �ʾƵ� �������ڴ�. (left/right/full) �� �ش��ϴ� ���ڵ带 ����
-- ������ ������ �˻��� �ȴ�. ���ʿ��ִ°͵�, ���ʰŴ� ���� null
select *
from dept01 left outer join dept02
on dept01.DEPARTMENT_ID = dept02.DEPARTMENT_ID;

-- ������ ������ ���ʿ� �ִ� ���� ���� ���. ���ʰŴ� ���� null
select *
from dept01 right outer join dept02
on dept01.DEPARTMENT_ID = dept02.DEPARTMENT_ID;
-- ���� ����� �ϴ� �ڵ� ( �ݴ�� �����ϸ� �ȴ�. )
select *
from dept01, dept02
where dept01.DEPARTMENT_ID = dept02.DEPARTMENT_ID(+);

select *
from dept01 full outer join dept02
on dept01.DEPARTMENT_ID = dept02.DEPARTMENT_ID;

-------------------------------------------------------------------------------

-- ���������� �񱳿����� ������
-- it�� �ִ� ����� �˻��غ���
select *
from employees
where department_id = (
  select department_id 
  from departments
  where department_name = 'IT'
);

select e.first_name||' '||e.last_name as �����, e.department_id as �μ���ȣ
from employees e
where department_id = (
  select department_id
  from employees 
  where lower(first_name) = 'john' and lower(last_name) = 'chen'
);

select e.department_id as �μ���ȣ
from employees e
where lower(e.first_name) = 'john' and lower(e.last_name) = 'chen';

-- ��þ �޿� �̻��� �޴� �����
select e.first_name||' '||e.last_name as �����, e.salary as �޿�
from employees e
where e.salary >= (
  select salary
  from employees 
  where lower(first_name) = 'john' and lower(last_name) = 'chen'
) and e.first_name||' '||e.last_name != 'John Chen'
order by �޿�;

-- ��þ�� ���� ������ �����
select *
from employees
where job_id = (
  select job_id
  from employees
  where first_name = 'John' and last_name = 'Chen'
);

-- ��þ�� ���� �μ���ȣ�� �����
select e.first_name||' '||e.last_name as �����, e.department_id as �μ�ID
from employees e
where e.department_id = (
  select DEPARTMENT_ID
  from employees 
  where lower(first_name) = 'john' and lower(last_name) = 'chen'
) and e.first_name||' '||e.last_name != 'John Chen';

select e.first_name||' '||e.last_name as �����, e.salary as �޿�
from employees e
where e.salary > (
  select avg(salary)
  from EMPLOYEES
)
order by �޿�;

select e.first_name||' '||e.last_name as �����, e.salary as �޿�, e.department_id
from employees e
where e.department_id in ( 
  select DISTINCT department_id
  from employees
  where salary>=3000
)
order by department_id;

-- �� �׷쿡�� �ִ� �޿� ��� ���
select employee_id, first_name||' '||last_name as �����, salary as �޿�, department_id as �μ���ȣ
from employees
-- �������� ���� ���ÿ� ���� �� �ִ�.
where (department_id, salary) in (
  select department_id, max(salary)
  from employees
  group by department_id
);

-- ����(JOB)�� MANAGER�� ����� ���� �μ��� �μ� ��ȣ�� �μ���� ������ ����Ͻÿ�.
-- �׻���� ���� job_id�� �ش��ϴ� department_id�� ������ �̿� �ش��ϴ� location�� �˾Ƴ���
select department_id as �μ���ȣ, department_name as �μ���, city as ����
from departments inner join locations using (location_id)
where department_id in (
  select distinct department_id
  from employees
  where job_id in (
    select job_id
    from jobs
    where lower(job_title) like '%manager%'
  )
);

select salary
from employees
where department_id = 60;

-- ������������ �ִ� ���麸�� ū�� ���Ҷ�
select first_name, salary
from employees
where salary > all(
  select salary
  from employees
  where department_id = 60
);
-- �� �ڵ�� �Ʒ��� ����
select first_name, salary
from employees
where salary > (
  select max(salary)
  from employees
  where department_id = 60
);


-- ������������ �ִ� ���� �� ���� �����ź��� ū�� ���Ҷ�
select first_name, salary
from employees
where salary > any(
  select salary
  from employees
  where department_id = 60
);
-- �� �ڵ�� �Ʒ��� ����
select first_name, salary
from employees
where salary > (
  select min(salary)
  from employees
  where department_id = 60
);