-- tema lab 5

--2

select department_name,  job_title, round(avg(salary), 2) "Media salariilor"
from employees e join departments d on e.department_id = d.department_id
                 join jobs j on e.job_id = j.job_id
group by cube(department_name, job_title);

--3

select department_name, job_title, e.manager_id, min(salary), max(salary)
from employees e join departments d on e.department_id = d.department_id
                 join jobs j on e.job_id = j.job_id
group by rollup(department_name, job_title, e.manager_id);

--6

-- all
select last_name, salary
from employees
where salary > all (
        select avg(salary)
        from employees
        group by department_id
        );
-- max
select last_name, salary
from employees
where salary > (
        select max(avg(salary))
        from employees
        group by department_id
        );

--7

--subcerere sincronizata
select department_id, last_name, first_name, salary
from employees e
where salary in (
        select  min(salary)
        from employees e1
        where e1.department_id = e.department_id
        group by department_id
        )
group by department_id, last_name, first_name, salary;

--subcerere nesincronizata
select last_name, department_name, salary
from employees e join departments d on e.department_id = d.department_id
where (salary, department_name) in (
        select min(salary), department_name
        from employees e join departments d
        on e.department_id = d.department_id
        group by department_name
        );

--8

select last_name, department_name, to_char(hire_date, 'DD-MON-YYYY')
from employees e join departments d on e.department_id = d.department_id
where (to_char(hire_date, 'DD-MON-YYYY'), department_name) in (
        select min(to_char(hire_date, 'DD-MON-YYYY')), department_name
        from employees e join departments d
        on e.department_id = d.department_id
        group by department_name
        );  

--10

with angajati as (
        select last_name, first_name, salary
        from employees
        order by salary desc
)
select last_name, first_name, salary
from angajati
where rownum <= 3;        
        
--11

select e2.employee_id, e2.last_name, e2.first_name
from employees e1, employees e2
where e1.manager_id = e2.employee_id
group by e2.employee_id, e2.last_name, e2.first_name
having count(e1.employee_id) >= 2;

--12

select count(department_name), city
from departments d join locations l on d.location_id = l.location_id
group by l.location_id, city
having count(department_name) > 0;

--13

select e.department_id, department_name
from employees e, departments d
where e.department_id = d.department_id
    and exists (
            select department_id
            from employees
            group by department_id
            )
group by e.department_id, department_name;

--15

select manager_id, employee_id
from employees 
start with manager_id = (
        select employee_id
        from employees
        where employee_id = 114
        )
connect by prior employee_id = manager_id; 

--17

select employee_id, manager_id, level
from employees
start with manager_id is null
connect by prior employee_id = manager_id;

--18

select employee_id, manager_id, level
from employees
where salary >= 5000
start with manager_id = (
        select employee_id
        from employees
        where salary = (
                select max(salary)
                from employees
        )
)
connect by prior employee_id = manager_id;

--22

with angajati as (
        select last_name, first_name, salary
        from employees
        order by salary
)
select last_name, first_name, salary
from angajati
where rownum <= 3;
























