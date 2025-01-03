--tema lab 4

--4

SELECT j.job_id, COUNT(last_name) nr_angajati
FROM employees e, jobs j
WHERE e.job_id = j.job_id
GROUP BY j.job_id;

--6

SELECT MAX(salary) - MIN(salary) diferenta 
FROM employees e;
    
--8

SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (
        SELECT AVG(salary)
        FROM employees
        )
ORDER BY salary DESC;    

--10

SELECT d.department_id, d.department_name, max(e.salary)
FROM employees e, departments d
WHERE d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING MAX(e.salary) >= 3000;

-- 11

SELECT MIN(avg(salary))
FROM employees
GROUP BY job_id;

-- 12

SELECT e.department_id, department_name, SUM(salary)
FROM employees e, departments d 
WHERE e.department_id = d.department_id
GROUP BY e.department_id, department_name;

-- 13

SELECT round(MAX(AVG(salary)), 2)
FROM employees
GROUP BY department_id;

--14

--15

SELECT round(AVG(salary), 2)
FROM employees
HAVING AVG(salary) > 2500;

--16

SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;

--17

SELECT department_name, MIN(salary)
FROM employees e, departments d 
WHERE e.department_id = d.department_id
GROUP BY department_name
HAVING AVG(salary) = (SELECT MAX(AVG(salary))
                      FROM employees
                      GROUP BY department_id);
                      
--18

-- a
SELECT e.department_id, department_name, count(employee_id)
FROM employees e, departments d 
WHERE e.department_id = d.department_id
GROUP BY department_name, e.department_id
HAVING COUNT(employee_id) <  4;

-- b
SELECT e.department_id, department_name, count(employee_id)
FROM employees e, departments d 
WHERE e.department_id = d.department_id
GROUP BY department_name, e.department_id
HAVING COUNT(employee_id) = (
        SELECT MAX(COUNT(employee_id))
        FROM employees
        GROUP BY department_id
        );
        
--19

SELECT last_name, hire_date
FROM employees
WHERE hire_date IN (
        SELECT hire_date
        FROM employees
        GROUP BY hire_date
        HAVING COUNT(employee_id) = (
                SELECT MAX(COUNT(employee_id))
                FROM employees
                GROUP BY hire_date
                )
        );

--20

SELECT COUNT(department_id)
FROM departments
WHERE department_id IN (
        SELECT e.department_id
        FROM departments d, employees e
        WHERE d.department_id = e.department_id
        GROUP BY e.department_id
        HAVING COUNT(employee_id) >= 15
        );
        
--24 

SELECT j.employee_id, e.last_name nume
FROM job_history j JOIN employees e on j.employee_id = e.employee_id
GROUP BY j.employee_id, e.last_name
HAVING COUNT(e.employee_id) >= 2;

--25

SELECT SUM(commission_pct) / COUNT(employee_id)
FROM employees;

--31 

SELECT department_name, salariu
FROM departments d, 
    (SELECT AVG(salary) salariu, e.department_id
     FROM employees e
     GROUP BY e.department_id
    ) em
WHERE d.department_id = em.department_id;

--32

SELECT department_name, em.department_id, salariu, angajati
FROM departments d, 
        (SELECT AVG(salary) salariu,
         e1.department_id
         FROM employees e1
         GROUP BY e1.department_id
         ) em,
                     
        (SELECT COUNT(employee_id) angajati,
         e2.department_id
         FROM employees e2
         GROUP BY e2.department_id
         ) e3
WHERE d.department_id = em.department_id
AND d.department_id = e3.department_id;

--33

SELECT last_name, department_name, salary
FROM employees e, departments d
WHERE e.department_id = d.department_id
    AND (salary, department_name) IN (
            SELECT MIN(salary), department_name
            FROM employees e, departments d
            WHERE e.department_id = d.department_id
            GROUP BY department_name
            );    













