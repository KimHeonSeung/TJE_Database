
select rowid, first_name
from employees;

-- create table ���̺�� (); : ���̺� ����
create table emp01(
empno number(4),
ename varchar2(20),
sal number(7,2)
);
desc emp01;
select * from emp01;

create table dept_01 (
deptno number(2),
dname varchar2(14),
loc varchar2(13)
);
desc dept_01;

-- as �� ���� ���̺�� ������ ����� ������ ���� ���̺� ����
create table emp02
as
select * from employees;
select * from emp02;

-- || �� ����ϸ� ��Ī�� �����������.
create table emp_03
as
select employee_id, first_name from employees;
select * from emp03;
select * from emp_03;

create table emp04
as
select employee_id , first_name || ' ' || last_name , salary  from employees;
select * from emp04;

-- ���� ���� �̿��Ͽ� ���ϴ� ���� ������ �� �ִ�.
create table emp05
as
select * from employees
where department_id = 10;
select * from emp05;

-- where 1 = 0 ������ ÷���Ͽ� �����̺� ����
create table emp06
as
select * from employees where 1 = 0;
select * from emp06;

create table dept_02 (
deptno number(2),
dname varchar2(14),
loc varchar2(13)
);
desc dept_02;

-- alter : ���̺��� ����� �ٽ� ����°� ������ �ִ�.
--          ���̺��� ������ �����ϴ°� ���Ҽ��� ����.
--          Į�� �߰�, ����, �����ϴ� ���. add, modify, drop column
alter table emp01
add (job varchar2(9));
select * from emp01;

alter table dept_02
add (dmgr number(4));
desc dept_02;

-- modify : �̹� �����ϴ� �÷� ����
--          ���ڿ� ������ ������ ���� �߻����ɼ� ŭ
alter table emp01
modify (job varchar2(30));
desc emp01;

alter table dept_02
modify dmgr varchar2(30);
desc dept_02;

alter table emp01
drop column job;

-- drop table tablename : ���̺� ����
-- select * from tabs �ϸ� ������� ��� ���̺� ����.
-- mysql������ show tables �� �ϸ� �ȴ�.
select * from tabs order by table_name;

drop table dept02;
drop table dept01;
drop table dept_01;
drop table dept_02;
drop table emp04;
drop table emp01;
drop table emp02;
drop table emp_03;
drop table emp05;
drop table emp06;


-- truncate ���̺�� : ������ ����� �ο츦 ���� ����. 
-- ������ ���̺�� ������ ��� ������ �����. �뷮 ��ü�� �����
-- �ʱ�ȭ �� ���
-- ������ ��������
create table emp01
as
select * from employees;

select * from emp01;

truncate table emp01;

create table emp02
as
select * from employees;

select * from emp02;

-- �̰ŵ� ��� ���� ������.
-- �뷮�� ������ ��. ���̺�� ���õ� �ٸ���Ҵ� ����
-- ȸ��Ż��, �Խù� ���� � ����.
-- ���ǽĿ� ���� ���������� ��������
delete from emp02; 

-- rename �����̸� to ���̸� : ����Ŭ�� ����

-- insert into ���̺�� (�� �̸�, ..) values(�� ��, ..)
-- ���̺��� �Ϻθ� �������� ���������� �� Ǯ����.
create table emp01
as
select employee_id, last_name as employee_name, salary
from employees 
where 1=0;

select * 
from emp01;

desc emp01;
insert into emp01 (employee_id, employee_name, salary) 
values (1, 'ADMIN', 10000);
-- �� �Է��ҰŸ� ���� ���� �Է¾����൵ �ȴ�
insert into emp01
values (2, 'SuperVisor', 20000);
-- �ְ����ϴ°Ÿ� �Ҷ��� �̷��� �ϸ餧�ȵȴ�
insert into emp01
values (3, 'Prof_1');
-- �Ʒ��� ������ �ؾ��Ѵ�.
insert into emp01 (employee_id, employee_name)
values (3, 'Prof_1');

create table dept02
as
select * from departments where 1=0;
select * from dept02;
-- �ٷ� ���������� �ο츦 �Է��� �� �ִ�. ( ���������� Ȱ���ϴ� ���� )
insert into dept02
select * from departments;

-- �μ���ȣ�� 10�� ����� �߰�
drop table emp01;
create table emp01
as
select employee_id as empno, first_name || ' ' || last_name as ename, job_id as job, salary as sal, hire_date as hiredate
from employees;
select *
from emp01;

insert into emp01
select employee_id,first_name || ' ' || last_name, job_id, salary, hire_date
from employees
where department_id = 10;

-- update : ����� ������ ����
-- set�� : ��� ����Ʈ�� �ϰ������ -> where �������� �̿��Ͽ� ���ϴ� ���� �����ϰ��Ѵ�.

-- ��� ����� ������ȣ�� 1��
update emp01
set empno = 1;
-- ��� ��� �޿��� 10% �λ�
update emp01
set sal = sal*1.1;
-- ��� ����� �Ի����� ���÷� ����
update emp01
set hiredate = sysdate;

select * from emp01;

create table sam01
as
select employee_id as empno, job_id as job, salary as sal
from employees;

select * from sam01;

update sam01
set sal = sal - 5000
where sal >= 10000;

create table emp
as select * from employees;

select * from emp;

update emp
set salary = 300000, department_id = 110
where first_name = 'Steven';

select * from departments;

drop table emp;

create table emp
as
select * from employees;

select * from emp;

-- �μ���ȣ�� 90�� ����� ����
select * from emp where department_id = 90;
-- �μ� ��ȣ�� 90���� ������� �޿��� 90�� �μ��� ��ձ޿��� ����
update emp
set salary = (
    select avg(salary) 
    from emp 
    where department_id = 90
  )
where department_id = 90;


-- źź�� ������ 6��.
create table sam02
as
select first_name || ' ' || last_name as ename, salary as sal, hire_date as hiredate, department_id as deptno
from employees;

select * from employees;
desc sam02;

select * from locations;
-- Oxford�� ��ġ�� �μ��Ҽ� ������� �޿��� 1000�� �λ�
update sam02
set sal = sal + 1000  
    where deptno = (select department_id
                    from departments inner join locations using(location_id)
                    where city = 'Oxford');
                    
drop table emp;
create table emp
as
select first_name || ' ' || last_name as ename, salary as sal, job_id as job, department_id as deptno
from employees;

select * 
from emp;
 
create table dept
as
select *
from departments;

-- ���� ������ �̿��ؼ� �μ���ȣ�� 20�� �μ��� �μ���� ����ID�� �μ� ��ȣ�� 40���� �μ��� �����ϰ� �����ϵ��� �� ���ô�.
update dept
set (department_name, location_id) = (
  select department_name, location_id
  from dept
  where department_id = 40
) 
where department_id = 20;

select * from dept;

drop table sam02;
create table sam02
as
select first_name || ' ' || last_name as ename, salary as sal, hire_date as hiredate, department_id as deptno
from employees;

select * from employees;
select * from sam02;

-- ��� ����� �޿��� �Ի����� king�� ����
update sam02
set (sal, hiredate) = (
  select sal, hiredate
  from sam02
  where ename = 'Steven King'
);

-- delete from ���̺�� : ������ ���� �ϸ� ��ü���̺��� ������
delete from sam02;

delete from sam02
where deptno = 30;

drop table sam01;
create table sam01
as
select * from employees;

-- Ŀ�̼��� ���� �ʴ� ������� �����Ͻÿ�
delete from sam01
where commission_pct is null;

drop table emp01;

create table emp01
as 
select * from employees;

-- �μ��� it�� �� �μ��� �����
delete from emp01
where department_id in (
  select department_id
  from employees inner join departments d using(department_id)
  where lower(d.department_name) like '%it%'
);
