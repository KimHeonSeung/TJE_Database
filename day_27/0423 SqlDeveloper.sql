-- �ش� ������ �����ϴ� ���̺��� ����� �˻��ϴ� SQL ��

select *
from TAB;

desc employees;

-- �� �ȹٲ� �� varchar2 ���. ������ �ٿ��� ��������. �ѹ� ���� ���� �ٲ��� ���� �͵�
-- char�� �������� ���� ������ ������ �ٲ� ���ɼ� ���� ��

-- �������� ��� �ۼ��ϴ°��� ����.


select *
from employees;

select employee_id, first_name, last_name
from employees;

-- ����� �̸��� �޿�, �Ի����ڸ� �˻��ϴ� ������
select  first_name, last_name, salary, hire_date
from employees;

desc employees;

-- ����� �̸��� �޿�, ������ �˻��ϴ� ������.
select first_name, last_name, salary, salary*12
from employees;

-- �ΰ��� �����ϸ� �ΰ��� ����� ���´�.
select first_name, last_name, salary, commission_pct, salary*12, salary*12+commission_pct
from employees;

-- nvl(��, ��) �� �ش� ���� �ΰ��� �־��� ������ �ٲ��ش�.
select first_name, last_name, salary, commission_pct, salary*12, salary*12+commission_pct, nvl(commission_pct, 0), salary*12+nvl(commission_pct, 0)
from employees;

-- as ��Ī �� ����ϸ� ���� �� �̸����� �ٲ��. ���� ����� �ȵ�.
-- ��ҹ��� ������ �ֵ���ǥ�� ��� ( "A n n s a l" ) �̷��� �ϸ� ���鵵 ��� ����
select first_name, last_name, salary, commission_pct, salary*12 as annsal, salary*12+commission_pct as annsalcomm, nvl(commission_pct, 0) as comm_nvl, salary*12+nvl(commission_pct, 0) as annsalcomm_nvl
from employees;

select *
from departments;

select department_id as "�μ���ȣ" , department_name as "�μ���"
from departments;