
select rowid, first_name
from employees;

-- create table 테이블명 (); : 테이블 생성
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

-- as 절 뒤의 테이블과 동일한 내용과 구조를 갖는 테이블 생성
create table emp02
as
select * from employees;
select * from emp02;

-- || 를 사용하면 별칭을 지정해줘야함.
create table emp_03
as
select employee_id, first_name from employees;
select * from emp03;
select * from emp_03;

create table emp04
as
select employee_id , first_name || ' ' || last_name , salary  from employees;
select * from emp04;

-- 웨얼 절을 이용하여 원하는 열만 가져올 수 있다.
create table emp05
as
select * from employees
where department_id = 10;
select * from emp05;

-- where 1 = 0 조건을 첨가하여 빈테이블 생성
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

-- alter : 테이블을 지우고 다시 만드는게 나을수 있다.
--          테이블의 구조를 변경하는건 안할수록 좋다.
--          칼럼 추가, 수정, 삭제하는 기능. add, modify, drop column
alter table emp01
add (job varchar2(9));
select * from emp01;

alter table dept_02
add (dmgr number(4));
desc dept_02;

-- modify : 이미 존재하는 컬럼 변경
--          문자열 데이터 수정시 문제 발생가능성 큼
alter table emp01
modify (job varchar2(30));
desc emp01;

alter table dept_02
modify dmgr varchar2(30);
desc dept_02;

alter table emp01
drop column job;

-- drop table tablename : 테이블 삭제
-- select * from tabs 하면 사용중인 모든 테이블 나옴.
-- mysql에서는 show tables 로 하면 된다.
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


-- truncate 테이블명 : 기존에 저장된 로우를 전부 삭제. 
-- 완전에 테이블과 연관된 모든 정보를 지운다. 용량 자체가 사라짐
-- 초기화 시 사용
-- 무조건 다지워짐
create table emp01
as
select * from employees;

select * from emp01;

truncate table emp01;

create table emp02
as
select * from employees;

select * from emp02;

-- 이거도 모든 행을 삭제함.
-- 용량은 유지가 됨. 테이블과 관련된 다른요소는 유지
-- 회원탈퇴, 게시물 삭제 등에 쓰임.
-- 조건식에 따라 선택적으로 삭제가능
delete from emp02; 

-- rename 기존이름 to 새이름 : 오라클에 국한

-- insert into 테이블명 (열 이름, ..) values(열 값, ..)
-- 테이블의 일부만 가져오면 제약조건이 다 풀린다.
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
-- 다 입력할거면 굳이 행을 입력안해줘도 된다
insert into emp01
values (2, 'SuperVisor', 20000);
-- 넣고자하는거만 할때는 이렇게 하면ㄷ안된다
insert into emp01
values (3, 'Prof_1');
-- 아래오 ㅏ같이 해야한다.
insert into emp01 (employee_id, employee_name)
values (3, 'Prof_1');

create table dept02
as
select * from departments where 1=0;
select * from dept02;
-- 바로 쿼리문으로 로우를 입력할 수 있다. ( 서브쿼리로 활용하는 예시 )
insert into dept02
select * from departments;

-- 부서번호가 10인 사원을 추가
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

-- update : 저장된 데이터 수정
-- set절 : 모든 레코트에 일괄적용됨 -> where 조건절을 이용하여 원하는 곳을 수정하게한다.

-- 모든 사원의 직원번호를 1로
update emp01
set empno = 1;
-- 모든 사원 급여를 10% 인상
update emp01
set sal = sal*1.1;
-- 모든 사원의 입사일을 오늘로 수정
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

-- 부서번호가 90인 사람을 수정
select * from emp where department_id = 90;
-- 부서 번호가 90번인 사람들의 급여를 90번 부서의 평균급여로 수정
update emp
set salary = (
    select avg(salary) 
    from emp 
    where department_id = 90
  )
where department_id = 90;


-- 탄탄히 다지기 6번.
create table sam02
as
select first_name || ' ' || last_name as ename, salary as sal, hire_date as hiredate, department_id as deptno
from employees;

select * from employees;
desc sam02;

select * from locations;
-- Oxford에 위치한 부서소속 사원들의 급여를 1000씩 인상
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

-- 서브 쿼리를 이용해서 부서번호가 20인 부서의 부서명과 지역ID를 부서 번호가 40번인 부서와 동일하게 변경하도록 해 봅시다.
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

-- 모든 사원의 급여와 입사일을 king과 같이
update sam02
set (sal, hiredate) = (
  select sal, hiredate
  from sam02
  where ename = 'Steven King'
);

-- delete from 테이블명 : 조건절 없이 하면 전체테이블이 삭제됨
delete from sam02;

delete from sam02
where deptno = 30;

drop table sam01;
create table sam01
as
select * from employees;

-- 커미션을 받지 않는 사원들을 제거하시오
delete from sam01
where commission_pct is null;

drop table emp01;

create table emp01
as 
select * from employees;

-- 부서에 it가 들어간 부서를 지운다
delete from emp01
where department_id in (
  select department_id
  from employees inner join departments d using(department_id)
  where lower(d.department_name) like '%it%'
);
