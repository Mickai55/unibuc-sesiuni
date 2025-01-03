--Laborator 3
--1
SELECT e1.last_name, TO_CHAR(e1.hire_date, 'MONTH-YYYY') luna_an_angajare
FROM employees e1 JOIN employees e2 USING (department_id)
WHERE INITCAP(e2.last_name) = 'Gates' AND LOWER(e1.last_name) LIKE '%a%';

--sau

SELECT e1.last_name, TO_CHAR(e1.hire_date, 'MONTH-YYYY') luna_an
FROM employees e1 JOIN employees e2 ON e1.department_id = e2.department_id
WHERE INITCAP(e2.last_name) = 'Gates'
AND LOWER(e1.last_name) LIKE('%a%')
AND INITCAP(e1.last_name) <> 'Gates';

--2
SELECT DISTINCT e1.employee_id, e1.last_name
FROM employees e1 JOIN employees e2
    ON (e1.department_id = e2.department_id AND e1.employee_id <> e2.employee_id)
WHERE UPPER(e2.last_name) LIKE '%T%'
ORDER BY last_name;

--3
SELECT e1.last_name, e1.salary, job_title, city, country_name
FROM employees e1, employees e2, departments d, locations l, countries c, jobs j
WHERE e1.manager_id = e2.employee_id
AND INITCAP(e2.last_name) = 'King'
AND e1.department_id = d.department_id
AND d.location_id = l.location_id
AND l.country_id = c.country_id
AND j.job_id = e1.job_id;

DESC jobs;
DESC employees;

--4

select e.department_id, department_name, last_name, job_id, TO_CHAR(e.salary, '$99,999.99')
from departments d join employees e on
    e.department_id = d.department_id
where lower(department_name) like ('%ti%')
order by department_name, last_name;

--5

select last_name, e.department_id, department_name, city, job_id
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id
where initcap(city) = 'Oxford';

--6
SELECT DISTINCT e1.employee_id, e1.last_name, e1.salary
FROM employees e1 JOIN employees e2
    ON (e1.department_id = e2.department_id AND e1.employee_id <> e2.employee_id)
WHERE UPPER(e2.last_name) LIKE '%T%'
    AND e1.salary > (
             SELECT AVG(e3.salary)
             FROM employees e3
             WHERE e1.job_id = e3.job_id
             );

--7
SELECT last_name, department_name
FROM departments d RIGHT JOIN employees e1
    ON (d.department_id = e1.department_id);
    

SELECT last_name, department_name
FROM employees e1, departments d
WHERE d.department_id (+) = e1.department_id;

--8

select department_name, salary, last_name
from departments d left join employees e on e.department_id = d.department_id;

select department_name, salary, last_name
from departments d, employees e
where d.department_id = e.department_id (+);

--9
SELECT last_name, department_name
FROM employees e1, departments d
WHERE d.department_id (+) = e1.department_id
UNION
SELECT last_name, department_name
FROM employees e1, departments d
WHERE e1.department_id (+) = d.department_id;

--10
SELECT DISTINCT e.department_id, d.department_name, e.job_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND (UPPER(d.department_name) LIKE '%RE%' OR UPPER(job_id) = 'SA_REP');

SELECT e.department_id, d.department_name, e.job_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND UPPER(d.department_name) LIKE '%RE%'
UNION
SELECT e.department_id, d.department_name, e.job_id 
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND UPPER(job_id) = 'SA_REP';

--11 APARE REZULTATUL CU DUPLICATE

--12

select department_name 
from departments
    minus 
select distinct department_name
from departments d join employees e on e.department_id = d.department_id;

--13
SELECT e.department_id 
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND UPPER(d.department_name) LIKE '%RE%'
INTERSECT
SELECT e.department_id 
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND UPPER(job_id) = 'HR_REP';

--14
DESC jobs;
SELECT employee_id, job_id, last_name
FROM employees 
WHERE salary > 3000
UNION
SELECT e.employee_id, j.job_id, last_name
FROM employees e, jobs j
WHERE e.job_id = j.job_id
AND salary = (min_salary+max_salary)/2;

--15
SELECT last_name, hire_date 
FROM employees
WHERE hire_date > (
        SELECT hire_date
        FROM employees
        WHERE UPPER(last_name) = 'GATES'
        );

--16
SELECT last_name, salary
FROM employees e
WHERE employee_id NOT IN 
        (SELECT employee_id
         FROM employees
         WHERE INITCAP(last_name) = 'Gates'
             AND e.department_id = department_id
        )
ORDER BY 1;

--daca subcererea returneaza mai mult de o linie
--atunci nu putem folosi =, altfel putem folosi 
--ambele variante


--17

select last_name, salary, manager_id
from employees
where manager_id IN (
        select employee_id
        from employees
        where manager_id is null
        );

--18

select last_name, department_id, salary
from employees
where (department_id, salary) in (
        select department_id, salary
        from employees
        where commission_pct is not null
        );

--20

select last_name
from employees
where salary > all(
        select salary
        from employees e join jobs j on e.job_id = j.job_id
        where upper(job_title) like('%CLERK%'))
order by salary desc;

--21
SELECT e.department_id, department_name, salary
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE commission_pct IS NULL
    AND e.manager_id IN (
             SELECT manager_id
             FROM employees
             WHERE manager_id = e.manager_id
             AND commission_pct IS NOT NULL
             );

--SAU nu
SELECT e.department_id, department_name, salary
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND commission_pct IS NULL
--              !!!!!!
AND e.manager_id = ANY (SELECT manager_id
                       FROM employees
                       WHERE manager_id = e.manager_id
                          AND commission_pct IS NOT NULL
                        );

--22

select last_name, department_id, salary, job_id
from employees
where (salary, commission_pct) in (
        select salary, commission_pct
        from employees
        where department_id in (
                select department_id
                from departments d inner join locations l on d.location_id = l.location_id
                where l.city = 'Oxford'
                )
        );

--23

select last_name, department_id, job_id
from employees
where department_id = (
        select d.department_id
        from departments d join locations l on d.location_id = l.location_id
        where l.city = 'Toronto'
        );
