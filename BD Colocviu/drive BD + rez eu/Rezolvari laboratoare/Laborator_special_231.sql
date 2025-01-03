--6 (lab 3)
--media salariilor
SELECT ROUND(AVG(salary), 2) med_sal, job_id
FROM employees
GROUP BY job_id;

--departementele in care exista un angajat cu litera t in nume
SELECT DISTINCT department_id
FROM employees
WHERE LOWER(last_name) LIKE '%t%';

--var 1
SELECT employee_id, last_name, salary
FROM employees e1
WHERE salary > (SELECT ROUND((MAX(e2.salary)+MIN(e2.salary))/2, 2) 
                FROM employees e2
                WHERE e1.job_id = e2.job_id 
                GROUP BY e2.job_id)
AND department_id IN (SELECT DISTINCT department_id
                      FROM employees
                      WHERE LOWER(last_name) LIKE '%t%');
        
--var 2              
SELECT employee_id, last_name, salary
FROM employees e1
WHERE salary > (SELECT ROUND((MAX(e2.salary)+MIN(e2.salary))/2, 2) 
                FROM employees e2
                WHERE e1.job_id = e2.job_id 
                GROUP BY e2.job_id)
AND EXISTS(SELECT 'X'
           FROM employees e2
           WHERE LOWER(last_name) LIKE '%t%'
           AND e1.department_id = e2.department_id);
     
--var 3    
WITH tabel AS (SELECT ROUND((MAX(salary)+MIN(salary))/2, 2) med_sal, job_id
               FROM employees
               GROUP BY job_id) 
SELECT employee_id, last_name, salary
FROM employees e1, tabel t
WHERE e1.job_id = t.job_id
AND salary > med_sal
AND EXISTS(SELECT 'X'
           FROM employees e2
           WHERE LOWER(last_name) LIKE '%t%'
           AND e1.department_id = e2.department_id);

--var 4
SELECT DISTINCT e.employee_id "Cod angajat", e.first_name||' '||e.last_name "Nume angajat", e.salary "Salariu"
FROM employees e, jobs j, employees e2
WHERE e.job_id = j.job_id
AND e2.department_id = e.department_id
AND e.employee_id <> e2.employee_id
AND LOWER(e2.last_name) LIKE '%t%'
AND e.salary > (j.min_salary + j.max_salary) / 2;

-- Lab2
-- 26 --v1
SELECT e1.last_name, e1.hire_date
FROM employees e1, employees e2
WHERE UPPER(e2.last_name) = 'GATES'
AND e1.hire_date > e2.hire_date
ORDER BY e1.hire_date;

-- Lab2
-- 26 --v2
SELECT e1.last_name, e1.hire_date
FROM employees e1, employees e2
WHERE e1.hire_date > e2.hire_date
AND UPPER(e2.last_name) = 'GATES'
ORDER BY e1.hire_date;

--LAB 5 EX 2
--a
SELECT DISTINCT MAX(department_name), MAX(job_title), 
    ROUND(AVG(salary), 2)
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND j.job_id = e.job_id
GROUP BY CUBE(d.department_id, j.job_id);

--SAU
SELECT DISTINCT MAX(department_name), MAX(job_title), 
    ROUND(AVG(salary), 2)
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND j.job_id = e.job_id
GROUP BY CUBE(j.job_id, d.department_id);

--b
SELECT DISTINCT MAX(department_name), MAX(job_title), 
    ROUND(AVG(salary), 2), 
    DECODE(GROUPING(d.department_id), 0, 'Dep', NULL),
    DECODE(GROUPING(j.job_id), 0, 'Job', NULL)
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND j.job_id = e.job_id
--NU FACE ASTA IN WHERE O FACEM IN HAVING: AND MAX(department_name) IS NOT NULL
GROUP BY CUBE(j.job_id, d.department_id);

--ASA NU
ALTER TABLE emp_asi
ADD COLUMN ceva NUMBER;

--ASA DA
ALTER TABLE emp_asi
ADD ceva NUMBER;

ALTER TABLE emp_asi
DROP COLUMN ceva;
