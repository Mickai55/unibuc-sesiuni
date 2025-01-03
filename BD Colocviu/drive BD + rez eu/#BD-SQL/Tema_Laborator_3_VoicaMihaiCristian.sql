--tema lab 3

--1

select e1.last_name, TO_CHAR(e1.hire_date, 'MONTH-YYYY') "Luna - An"
from employees e1 join employees e2 on e1.department_id = e2.department_id
where INITCAP(e2.last_name) = 'Gates'
    and INITCAP(e1.last_name) <> 'Gates'
    and lower(e1.last_name) like('%a%');

--4

select e.department_id, department_name, last_name, job_id, TO_CHAR(e.salary, '$99,999.99')
from departments d join employees e on e.department_id = d.department_id
where lower(department_name) like ('%ti%')
order by department_name, last_name;

--5

select last_name, e.department_id, department_name, city, job_id
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id
where initcap(city) = 'Oxford';

--8

select department_name, salary, last_name
from departments d left join employees e on e.department_id = d.department_id;

--sau

select department_name, salary, last_name
from departments d, employees e
where d.department_id = e.department_id (+);

--12

select department_name 
from departments
    minus 
select distinct department_name
from departments d join employees e
on e.department_id = d.department_id;

--sau

select distinct department_name
from departments d left join employees e
on e.department_id = d.department_id
    minus 
select distinct department_name
from departments d join employees e
on e.department_id = d.department_id;

--17

select last_name, salary, manager_id
from employees
where manager_id = (
        select employee_id
        from employees
        where manager_id  is null);

--18

select last_name, department_id, salary
from employees
where (department_id, salary) in (
        select department_id, salary
        from employees
        where commission_pct is not null);

--20

select last_name
from employees
where salary > all(
        select salary
        from employees e join jobs j on e.job_id = j.job_id
        where upper(job_title) like('%CLERK%'))
order by salary desc;

--22

select last_name, department_id, salary, job_id
from employees
where (salary, commission_pct) in (
        select salary, commission_pct
        from employees
        where department_id in (
                select department_id
                from departments d inner join locations l on d.location_id = l.location_id
                where l.city = 'Oxford'));
    
--23

select last_name, department_id, job_id
from employees
where department_id = (
        select d.department_id
        from departments d inner join locations l on d.location_id = l.location_id
        where l.city = 'Toronto');