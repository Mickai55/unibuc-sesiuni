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

--5
SELECT COUNT(DISTINCT manager_id) "Nr.manageri"
FROM employees;

--7
DESC departments;
SELECT department_name, location_id, 
    COUNT(employee_id) nr_ang, ROUND(AVG(salary),2) media
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_id, department_name, 
    location_id;
    
--SAU
SELECT MAX(department_name) dept_id, MAX(location_id) loc_id, 
    COUNT(employee_id) nr_ang, ROUND(AVG(salary),2) media
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_id;

--9
SELECT m.employee_id, MIN(e.salary)
FROM employees e, employees m
WHERE e.manager_id = m.employee_id
--AND e.manager_id IS NOT NULL
GROUP BY m.employee_id
HAVING MIN(e.salary) >= 1000
ORDER BY 2 DESC;

--21
SELECT d.department_id, SUM(salary)
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.department_id <> 30
GROUP BY d.department_id
HAVING COUNT(employee_id) > 10
ORDER BY 2;

--22
SELECT d.department_id, MAX(department_name),
    COUNT(employee_id), AVG(salary),
    MAX(last_name), employee_id, MAX(job_id)
FROM employees e, departments d
WHERE e.department_id (+) = d.department_id
GROUP BY d.department_id, employee_id;
    

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
SELECT j.job_id job, (SELECT DECODE(d.department_id, 30, SUM(salary))
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
FROM departments d, (SELECT SUM(salary) salariu, 
                        em.department_id
                     FROM employees em
                     GROUP BY em.department_id) e
WHERE d.department_id = e.department_id;

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
