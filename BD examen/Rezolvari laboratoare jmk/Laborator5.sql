--Laborator 5
--exercitii
--1
--a
SELECT department_name, job_title, ROUND(AVG(salary), 2) media
FROM departments d, jobs j, employees e
WHERE d.department_id = e.department_id
    AND j.job_id = e.job_id
GROUP BY ROLLUP(d.department_id, j.job_id), 
    department_name, job_title;
    
--b
SELECT department_name, job_title, 
    ROUND(AVG(salary), 2) media,
    GROUPING(department_name) dep, 
    GROUPING(job_title) job
FROM departments d, jobs j, employees e
WHERE d.department_id = e.department_id
AND j.job_id = e.job_id
GROUP BY ROLLUP(d.department_name, j.job_title);

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

--4
SELECT MAX(salary)
FROM employees
HAVING MAX(salary) > 15000;

--5
--a
SELECT last_name, salary
FROM employees e
WHERE salary > (SELECT AVG(salary)
                FROM employees e1
                WHERE e1.department_id = e.department_id
                AND e1.employee_id <> e.employee_id);

--b
--subcerere necorelata in from
SELECT department_name, em.medie, em.nr_ang
FROM departments d, (SELECT ROUND(AVG(salary), 2) medie,  
                     COUNT(employee_id) nr_ang,
                     e.department_id
                     FROM employees e
                     GROUP BY e.department_id) em
WHERE d.department_id = em.department_id;
       
--subcerere corelata in select
SELECT department_name, 
    (SELECT COUNT(employee_id)
     FROM employees e
     WHERE e.department_id = d.department_id) s1,
    (SELECT ROUND(AVG(salary), 2)  
     FROM employees e
     WHERE e.department_id = d.department_id) s2
FROM departments d;   

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

--9
SELECT last_name, department_id
FROM employees e3
WHERE EXISTS(SELECT 1
             FROM employees e1
             WHERE e1.salary = (SELECT MAX(e2.salary)
                                FROM employees e2
                                WHERE e2.department_id = 30)
             AND e1.department_id = e3.department_id);
             
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
having count(department_name) >= 1;

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
             
             
--14
--a
SELECT employee_id, last_name, hire_date, salary, manager_id
FROM employees
WHERE manager_id = (SELECT employee_id
                    FROM employees
                    WHERE UPPER(last_name) = 'DE HAAN');

--b
SELECT employee_id, last_name, hire_date, salary, manager_id
FROM employees
START WITH manager_id = (SELECT employee_id
                         FROM employees
                         WHERE UPPER(last_name) = 'DE HAAN')
CONNECT BY PRIOR employee_id = manager_id;

SELECT employee_id, last_name, hire_date, salary, manager_id
FROM employees
START WITH manager_id = (SELECT employee_id
                         FROM employees
                         WHERE UPPER(last_name) = 'DE HAAN')
CONNECT BY PRIOR manager_id = employee_id;

--15

select manager_id, employee_id
from employees 
start with manager_id = (
        select employee_id
        from employees
        where employee_id = 114
        )
connect by prior employee_id = manager_id; 

--16
SELECT employee_id, manager_id, last_name
FROM employees
WHERE LEVEL = 2
START WITH manager_id = (SELECT employee_id
                         FROM employees
                         WHERE UPPER(last_name) = 'DE HAAN')
CONNECT BY PRIOR employee_id = manager_id;

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

--19
WITH tabel AS (
    SELECT department_name, 
            SUM(salary) sum_sal,
            COUNT(employee_id) nr_ang
    FROM departments d, employees e
    WHERE e.department_id = d.department_id
    GROUP BY e.department_id, department_name
) 
SELECT department_name
FROM tabel
WHERE sum_sal > (SELECT SUM(sum_sal)/SUM(nr_ang)
                 FROM tabel);
                 
--21
--NU ESTE BUN
SELECT employee_id, last_name, salary
FROM employees
WHERE ROWNUM <= 10
ORDER BY salary DESC;

SELECT employee_id, last_name, salary
FROM employees
ORDER BY salary DESC;

--ESTE BUN
WITH emp_desc AS (
    SELECT employee_id, last_name, salary
    FROM employees
    ORDER BY salary DESC
)
SELECT *
FROM emp_desc
WHERE ROWNUM <= 10;

--22

with angajati as (
        select last_name, first_name, salary
        from employees
        order by salary
)
select *
from angajati
where rownum <= 3;

--23
DESC departments;

SELECT 'Departamentul ' || department_name || '
    este condus de ' || 
    NVL(TO_CHAR(d.manager_id), 'nimeni') || 
    ' si ' || CASE COUNT(employee_id)
                    WHEN 0 THEN 'nu are salariati'
                    ELSE 'are numarul de salariati ' 
                        || COUNT(employee_id)
              END info
FROM employees e, departments d
WHERE e.department_id (+) = d.department_id
GROUP BY d.department_id, department_name, 
    d.manager_id;

--24
SELECT last_name, first_name, LENGTH(last_name)
FROM employees
WHERE NULLIF(LENGTH(last_name),LENGTH(first_name)) IS NOT NULL;

--25
--persoanele care incep cu s
SELECT last_name, INSTR(UPPER(last_name),'S')
FROM employees;

SELECT j.job_id, 
DECODE(INSTR(UPPER(job_title),'S'), 
    1, '1. ' || SUM(salary), 
    DECODE(MAX(salary), 
           (SELECT MAX(salary)
            FROM employees), '2. ' || AVG(salary),
           '3. ' || MIN(salary)))
FROM employees e, jobs j
WHERE j.job_id = e.job_id
GROUP BY j.job_id, job_title;