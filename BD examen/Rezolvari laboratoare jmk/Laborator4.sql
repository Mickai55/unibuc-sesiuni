--LABORATOR 4
--1
--a da, in afara de COUNT
--b In HAVING putem avea comparari cu functii grup, 
--iar in WHERE nu putem

--2
SELECT MAX(salary) "Maxim", MIN(salary) "Minim", 
       SUM(salary) "Suma",
       ROUND(AVG(salary), 2) "Media"
FROM employees;
--WHERE salary > 5000
--HAVING ROUND(AVG(salary), 2) > 5000;

--3
SELECT j.job_id, 
       MAX(salary) "Maxim", MIN(salary) "Minim", 
       SUM(salary) "Suma",
       ROUND(AVG(salary), 2) "Media"
       --(min_salary + max_salary)/2
FROM employees e, jobs j
WHERE e.job_id = j.job_id
GROUP BY j.job_id; --, (min_salary + max_salary)/2;

--4
SELECT j.job_id, COUNT(last_name) nr_angajati
FROM employees e, jobs j
WHERE e.job_id = j.job_id
GROUP BY j.job_id;

--5
SELECT COUNT(DISTINCT manager_id) "Nr.manageri"
FROM employees;

--6

SELECT MAX(salary) - MIN(salary) diferenta 
FROM employees e;

--7
DESC departments;

SELECT department_name, location_id, 
    COUNT(employee_id) nr_ang, ROUND(AVG(salary),2) media
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_id, department_name, location_id;
    
--8

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (
        SELECT AVG(salary)
        FROM employees
        )
ORDER BY salary DESC;       

--9
SELECT m.employee_id, MIN(e.salary)
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
--AND e.manager_id IS NOT NULL
GROUP BY m.employee_id
HAVING MIN(e.salary) >= 1000
ORDER BY 2 DESC;

--10

SELECT d.department_id, d.department_name, max(e.salary)
FROM employees e, departments d
WHERE d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING MAX(e.salary) >= 3000;

-- 11

select min(avg(salary))
from employees
group by job_id;

-- 12

select e.department_id, department_name, sum(salary)
from employees e, departments d 
WHERE e.department_id = d.department_id
group by e.department_id, department_name;

-- 13

select round(max(avg(salary)), 2)
from employees
group by department_id;

-- Exercitiul 14
select e.job_id, job_title, avg(salary)
from employees e join jobs j on e.job_id = j.job_id
group by e.job_id, job_title
having avg(salary) in (
        select min(avg(salary))
        from employees e join jobs j
        on e.job_id = j.job_id
        group by e.job_id
        );
                        
--15

select round(avg(salary), 2)
from employees
having avg(salary) > 2500;

--16

select department_id, job_id, sum(salary)
from employees
group by department_id, job_id
order by department_id;

--17

select department_name, min(salary)
from employees e, departments d 
WHERE e.department_id = d.department_id
group by department_name
having avg(salary) = (select max(avg(salary))
                      from employees
                      group by department_id);
                      
--18

-- a
select e.department_id, department_name, count(employee_id)
from employees e, departments d 
WHERE e.department_id = d.department_id
group by department_name, e.department_id
having count(employee_id) <  4;

-- b
select e.department_id, department_name, count(employee_id)
from employees e, departments d 
WHERE e.department_id = d.department_id
group by department_name, e.department_id
having count(employee_id) = (
        select max(count(employee_id))
        from employees
        group by department_id
        );
        
--19

select last_name, hire_date
from employees
where hire_date in (
        select hire_date
        from employees
        group by hire_date
        having count(employee_id) = (
                select max(count(employee_id))
                from employees
                group by hire_date
                )
        );
        
--20

select count(department_id)
from departments
where department_id in (
        select e.department_id
        from departments d, employees e
        WHERE d.department_id = e.department_id
        group by e.department_id
        having count(employee_id) >= 15
        );

--21
SELECT d.department_id, SUM(salary)
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_id
HAVING COUNT(employee_id) > 10
AND d.department_id <> 30
ORDER BY 2;

--22
SELECT d.department_id, MAX(department_name),
    COUNT(employee_id), AVG(salary),
    MAX(last_name), employee_id, MAX(job_id)
FROM employees e, departments d
WHERE e.department_id (+) = d.department_id
GROUP BY d.department_id, employee_id;

--23
select e.department_id "Cod", sum(salary) "Salariu total", job_id "Job",
       city "Oras", department_name "Nume departament"
from employees e join departments d on e.department_id = d.department_id
                 join locations l on d.location_id = l.location_id
where e.department_id > 80
group by e.department_id, job_id, city, department_name;

--24 

select j.employee_id, e.last_name nume
from job_history j join employees e on j.employee_id = e.employee_id
group by j.employee_id, e.last_name
having count(e.employee_id) >= 2;

--25

select sum(commission_pct) / count(employee_id)
from employees;

--26
--ATENTIE la rollup conteaza ordinea parametrilor, iar
--la cube nu conteaza.
--exemplu ROLLUP
SELECT department_id, TO_CHAR(hire_date, 'yyyy'), SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP(TO_CHAR(hire_date, 'yyyy'), department_id);

--exemplu CUBE
SELECT department_id, TO_CHAR(hire_date, 'yyyy'), SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY CUBE(TO_CHAR(hire_date, 'yyyy'), department_id);

--27
SELECT j.job_id job, 
    (SELECT DECODE(d.department_id, 30, SUM(salary))
     FROM employees
     WHERE j.job_id = job_id) dep30,
    (SELECT DECODE(d.department_id, 50, SUM(salary))
     FROM employees
     WHERE j.job_id = job_id)dep50,
    (SELECT DECODE(d.department_id, 80, SUM(salary))
     FROM employees
     WHERE j.job_id = job_id) dep80,
    SUM(salary) total
FROM jobs j, departments d, employees e
WHERE j.job_id = e.job_id
AND d.department_id = e.department_id
GROUP BY j.job_id, d.department_id;

--29
SELECT d.department_id, department_name,
    (SELECT COUNT(employee_id)
     FROM employees e1
     WHERE e1.department_id (+) = d.department_id) nr_ang, 
    (SELECT ROUND(AVG(salary), 2)
     FROM employees e1
     WHERE e1.department_id (+) = d.department_id) media_sal,
    last_name, employee_id, job_id
FROM employees e, departments d
WHERE e.department_id (+) = d.department_id; 

--30
SELECT d.department_id, department_name, salariu
FROM departments d, (
         SELECT SUM(salary) salariu, em.department_id
         FROM employees em
         GROUP BY em.department_id
         ) e
WHERE d.department_id = e.department_id;

--31 

select department_name, salariu
from departments d, 
        (select avg(salary) salariu, e.department_id
         from employees e
         group by e.department_id
        ) em
where d.department_id = em.department_id;

--32

select department_name, em.department_id, salariu, angajati
from departments d, 
        (select avg(salary) salariu,
         e1.department_id
         from employees e1
         group by e1.department_id
         ) em,
                     
        (select count(employee_id) angajati,
         e2.department_id
         from employees e2
         group by e2.department_id
         ) e3
where d.department_id = em.department_id
and d.department_id = e3.department_id;

--33

select last_name, department_name, salary
from employees e, departments d
where e.department_id = d.department_id
    and (salary, department_name) in (
            select min(salary), department_name
            from employees e, departments d
            where e.department_id = d.department_id
            group by department_name
            );    

--34
SELECT DISTINCT d.department_id, department_name,
    n.nr, 
    m.med,
    last_name, employee_id, job_id
FROM employees e, departments d,
    (SELECT COUNT(employee_id) nr, e1.department_id department_id
     FROM employees e1
     GROUP BY e1.department_id) n,
    (SELECT ROUND(AVG(salary), 2) med, e1.department_id department_id
     FROM employees e1
     GROUP BY e1.department_id) m
WHERE e.department_id (+) = d.department_id
AND m.department_id (+) = d.department_id
AND n.department_id (+) = d.department_id; 
