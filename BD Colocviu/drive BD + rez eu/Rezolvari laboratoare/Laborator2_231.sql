--Laborator 2
--16
SELECT last_name, job_id, salary, 
    CASE job_id 
        WHEN 'IT_PROG' THEN salary * 1.2
        WHEN 'SA_REP' THEN salary * 1.25
        WHEN 'SA_MAN' THEN salary * 1.35
        ELSE salary
    END "Salariu renegociat"
FROM employees;

SELECT last_name, job_id, salary, 
    DECODE(job_id,'IT_PROG', salary * 1.2,
        'SA_REP', salary * 1.25,
        'SA_MAN', salary * 1.35,
        salary) "Salariu renegociat"
FROM employees;

--numarul de angajati
SELECT COUNT(*)
FROM employees;
        
--numarul de angajati pe departement
SELECT department_id, COUNT(employee_id)
FROM employees
GROUP BY department_id;

--17
SELECT last_name, d.department_id, department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id;

--VARIANTA STANDARD
SELECT last_name, d.department_id, department_name
FROM employees e JOIN departments d ON 
    e.department_id = d.department_id;
    
--18
SELECT DISTINCT d.department_id, j.job_id, job_title
FROM employees e JOIN departments d ON 
    e.department_id = d.department_id
    JOIN jobs j ON j.job_id = e.job_id
WHERE d.department_id = 30;

SELECT DISTINCT d.department_id, j.job_id, job_title
FROM employees e, departments d, jobs j  
WHERE d.department_id = 30
AND e.department_id = d.department_id
AND j.job_id = e.job_id;

--24
SELECT e1.employee_id, e1.last_name, 
    e1.department_id, e2.employee_id, e2.last_name
FROM employees e1, employees e2
WHERE e1.department_id = e2.department_id
AND e1.employee_id <> e2.employee_id;

--25
DESC jobs;

SELECT last_name, j.job_id, job_title, 
    department_name, salary
FROM employees emp, departments d, jobs j
WHERE emp.department_id = d.department_id
AND j.job_id = emp.job_id;

--26
SELECT *
FROM employees
WHERE UPPER(last_name) = 'GATES';

SELECT e1.last_name, e1.hire_date
FROM employees e1, employees e2
WHERE UPPER(e2.last_name) = 'GATES'
AND e1.hire_date > e2.hire_date
ORDER BY e1.hire_date;

SELECT e1.last_name, e1.hire_date
FROM employees e1 JOIN employees e2 ON
    e1.hire_date > e2.hire_date
WHERE UPPER(e2.last_name) = 'GATES'
ORDER BY e1.hire_date;
