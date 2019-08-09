-- concatenation : �� ��ġ��
select first_name || '''s phone number is ' || phone_number
from employees;

select *
from employees;

select first_name || ' ' || last_name
from employees;

-- distinct : �ߺ�����
select department_id
from employees;

select distinct nvl(department_id, 0) as "�μ� ��ȣ(0�� ����)"
from employees;

-- where Į�� ������ �񱳴�� : ���� ������ ��ȸ
-- �� ���� ���ε��� ����. 

select distinct nvl(department_id, 0) as "�μ� ��ȣ(0�� ����)"
from employees
where department_id >= 50;

-- ���� ���� ���鼭 �������� �����ϴ°� �����´�
select *
from employees
where salary >= 5000;

-- where Į�� ������ '��������'; : ���� ������ ��ȸ. ''�� "" �����ϴ� ���α׷����� �ٸ�.
-- ����ִ� ���� ��ҹ��� ������ �ؾ��Ѵ�.
select employee_id, first_name, salary
from employees
where first_name = 'Alexander';

select *
from employees
where first_name = 'Donald';

-- where Į�� ������ 'YYYY/MM/DD' : ��¥ ������ ��ȸ. ������ ����ó�� ���� ���������� ��ȯ�Ͽ� ���Ѵ�.
select *
from employees
where hire_date >= '2007/01/01';

-- ������ 100000�� �̻��� ����� ���� ��� �� �μ���ȣ 60(���α׷���) ���
select *
from employees
where 12*(salary + salary*nvl(commission_pct,0)) >= 100000 and department_id = 60;

-- �޿��� 5000�ҿ��� 7000�� ������ ����� ������ ���
select *
from employees
where salary >= 5000 and salary <= 7000;

-- �μ���ȣ�� 10, 70, 110�� ����� ���� ���
select *
from employees
where department_id = 10 or department_id = 70 or department_id = 110;

-- between and : ������ Į���� ���� and�� ����ϰ��� �� ��
-- where Į���� between ���� and ��;
select *
from employees
where salary between 5000 and 7000;

select *
from employees
where salary not between 5000 and 7000;

select *
from employees
where hire_date between '2001/01/01' and '2001/12/31';

-- in : Į���� in (��, ��, ...)
select *
from employees
where department_id in (10, 70, 110);

-- job_id�� ���� it_prog �̰ų� st_man �̰ų� sa_man�� ����� ���
-- �޿��� 8000���� 10000 ������ ��� ���
select *
from employees
where (job_id in ('ST_MAN', 'IT_PROG', 'SA_MAN')) 
and (salary + (salary*nvl(commission_pct,0)) between 8000 and 10000);

-- ���� ����� �����ʹ� ��ҹ��ڸ� �����ؾ���
select *
from employees
where (lower(job_id) in ('st_man', 'it_prog', 'sa_man')) 
and (salary + (salary*nvl(commission_pct,0)) between 8000 and 10000);

-- Į�� like ���� ���� �Ϻ��� ������ ��Ȯ�� �𸣴� ������ ����� �� �ִ�.
-- %�� ����ġ�� ��������
select *
from employees
where first_name like '%m';

-- first_name �� w�� ���Ե� ����� �˻� (��ҹ��� ���� x)
select *
from employees
where lower(first_name) like '%w%';

-- _�� �տ� �� �ѱ��ڸ� ������
select *
from employees
where upper(first_name) like '_A%';

-- A�� ���Ե� �̸��� ���ܽ�Ű�� ���� ��
select *
from employees
where upper(first_name) not like '%A%';

-- �ΰ��� =�� �Ǵ��� �� ����.
-- is null �� is not null �� ���
-- ����÷� is null
-- ���Į�� is not null
select employee_id, nvl(commission_pct,0) as COMMISSION_PCT
from employees
where commission_pct is null or commission_pct >= 0.2;

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- ���� order by asc, desc
-- order by Į���� asc(desc)
-- order by Į���� �ϸ� �⺻���� asc�� ���ش�.
select *
from employees
where upper(first_name) not like '%A%'
order by first_name asc;

select *
from employees
order by salary desc;

select employee_id as "�����ȣ", first_name || ' ' || last_name as "�����" , job_id as "����", hire_date as "�Ի���"
from employees
order by �Ի��� desc;

-- �μ���ȣ�� �������� �������� ������ ��
-- ������ �μ���ȣ�� ���� ��� �޿��÷��� �������� ���� 
select *
from employees
order by department_id asc, salary desc;

select employee_id as "��� ��ȣ", first_name || ' ' || last_name as "��� �̸�", job_id as ����, hire_date as �Ի���, salary as �޿�, department_id as "�μ� ��ȣ"
from employees
order by "�μ� ��ȣ" asc, �Ի��� desc;

-- ���� ���ϴ� �Լ� sum
select sum(salary+salary*nvl(commission_pct, 0)) as "�޿��� ����"
from employees;

select sum( (salary + salary*nvl(commission_pct, 0))*12 ) as "������ �հ�"
from employees;

-- ��հ��� ���� �� 
select avg(salary)
from employees;

select avg(commission_pct)
from employees;

select sum(commission_pct)
from employees;
-- ������ 107��, ������ 7.8

-- sql���� �����ϴ� avg�Լ��� null���� ������ ������ �հ�� ���� ���� ��ȯ�Ѵ�.
-- count �Լ��� �����ϴ�.
select count(commission_pct)
from employees;

-- �ùٸ��� ����� ���ϱ� ���� nvl�� �̿��Ѵ�.
select avg( nvl(commission_pct,0) )
from employees;

-- ���� �ȸ���. ���ϵǴ� ���� �ٸ�
--select employee_id, max(salary)
--from employees;

-- ������ �׷������ ������
-- ���÷���� �ִ� ��� ���̺���� ������ ����Ʈ��Ʈ ���̵𺰷� ���� �׷��� ����
-- �ƽ��� �׷찹����ŭ�����Եȴ�.
select DEPARTMENT_ID as "�μ� ��ȣ", max(salary) as "�޿��� �ִ�"
from employees
group by DEPARTMENT_ID
order by "�޿��� �ִ�";

-- ���ǽ��� �߰��ϴ� ���. where���� �׷��Լ��� ����� �� ����. ������ ���ڵ� �����͸� �񱳰���
select DEPARTMENT_ID as "�μ� ��ȣ", max(salary) as "�޿��� �ִ�"
from employees
-- 90�� �׷��� �����ϰ� ������ ���
where DEPARTMENT_ID <> 90
group by DEPARTMENT_ID
-- group by�� ���ǽ��� �߰��� �� �ִ� ����� having �̴�. �����Լ�, �׷��Լ��� ���Ҷ�
having max(salary) >= 10000
order by "�޿��� �ִ�";

select count(commission_pct) as "80�� �μ� �Ҽ� ��� �� Ŀ�̼��� �޴� ����� ��"
from employees
where department_id = 80;

-- �� �μ��� �ο����� ����ϼ���
select DEPARTMENT_ID, count(*)
from EMPLOYEES
group by DEPARTMENT_ID;

-- �� �μ��� ������ 7000 �̻��� �ο����� ����ϼ���
select department_id as "�μ� ��ȣ", count(*) as "�ο���"
from employees
where salary + salary*nvl(COMMISSION_PCT,0) >= 7000
group by department_id
order by department_id;

-- �� �μ��� ��� �޿��� ���
-- round(����, �ڸ���) �ϸ� �Ҽ��� �ڸ�����ŭ ����
select department_id as "�μ� ��ȣ" , round(avg( salary + salary*nvl(COMMISSION_PCT,0) ), 2) as "��� �޿�"
from employees
group by department_id
order by "�μ� ��ȣ";

-- �� �μ��� ��� �޿��� ���
-- ( �� �μ��� �ο��� 7�� �̻��� �μ��� ���ؼ� ��� )
select department_id as "�μ� ��ȣ", round(avg( salary + salary*nvl(COMMISSION_PCT,0) ), 2) as "��� �޿�"
from employees
group by department_id
having count(*) >= 7
order by department_id;

select department_id as "�μ� ��ȣ", job_id as ����, round(avg( salary + salary*nvl(COMMISSION_PCT,0) ), 2) as "��� �޿�"
from employees
group by department_id, job_id
having count(*) >= 7
order by department_id;

select *
from tabs;

-- ���⿡ �ִ� ��ȣ��
select employee_id, department_id
from employees;
-- ���⿡ �ִ� ���̺�� �����Ǿ��ִ�.
select *
from departments;

select *
from employees, departments;

-- ���̺��� �̸��� ������� ���� �������� �����´�. equi join
select *
from employees, departments
where employees.department_id = departments.department_id;

select *
from jobs;
-- employees ���̺�� jobs ���̺��� �����Ͽ�
-- �����ȣ, job_id, �� �޿�, min_salary, max_salary ���
-- ��� ���̺��� �װ��� ���� ����������Ѵ�. select����.
select employee_id, employees.job_id, job_title, salary + salary*nvl(commission_pct, 0) as "�� �޿�", min_salary, max_salary
from employees, jobs
where employees.job_id = jobs.job_id;

-- employees ���̺�� jobs ���̺��� �����Ͽ�
-- �����ȣ, job_id, job_title, �� �޿�, min_salary, max_salary ���
-- (�ش� ��å�� ���� �޿� ü���� ��� �̻��� �޿��� �����ϴ� ����� ���)
select employee_id, employees.job_id, job_title, salary + salary*nvl(commission_pct, 0) as "�� �޿�", (max_salary + min_salary)/2 as "��� �޿�", min_salary, max_salary
from employees, jobs
where employees.job_id = jobs.job_id and salary + salary*nvl(commission_pct, 0) >= (max_salary + min_salary)/2;