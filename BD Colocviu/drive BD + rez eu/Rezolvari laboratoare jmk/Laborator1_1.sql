----5 sus
--SELECT employee_id, last_name,
--    salary * 12 ANNUAL_SALARY
--FROM employees;

--Exercitii
--3
DESC EMPLOYEES;

--4
SELECT *
FROM EMPLOYEES;

--5
SELECT employee_id, first_name || ' ' || last_name AS emp_name, job_id, hire_date
FROM employees;

--6
SELECT job_id 
FROM employees;

SELECT DISTINCT job_id 
FROM employees;

--7
SELECT last_name|| ', ' || job_id "Angajat si titlu"
FROM employees;

--8
DESC employees;

SELECT employee_id || ', ' || first_name || ', ' ||
    last_name || ', ' || email || ', ' || 
    NVL(phone_number, 'Nu are nr. de tel.') || ', ' || 
    hire_date || ', ' || 
    job_id || ', ' || salary || ', ' || 
    NVL(commission_pct, 0) || ', ' ||
    manager_id || ', ' ||
    department_id "Informatii complete"
FROM employees;

SELECT *
FROM employees;

--9
SELECT last_name, salary
FROM employees
WHERE salary > 2850;

--10
SELECT last_name, department_id
FROM employees
WHERE employee_id = 104;

--11
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 1500 AND 2850;

--12
SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date
    BETWEEN TO_DATE('20-FEB-1987', 'DD-MON-YY') 
        AND TO_DATE('1-MAY-1989', 'DD-MON-YY') 
ORDER BY hire_date ASC;

--13
SELECT last_name, department_id, salary
FROM employees
WHERE department_id IN (10,30)
ORDER BY last_name;

--14

SELECT last_name, salary
FROM employees
WHERE department_id IN (10,30) AND salary > 3500
ORDER BY last_name;

--15
SELECT SYSDATE
FROM dual;

--16
--v1
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE ('%87');

--v2
SELECT first_name, last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY')='1987';

--17
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

--18
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary, commission_pct;

--19
SELECT last_name, salary, commission_pct
FROM employees
ORDER BY salary DESC, commission_pct DESC;

--20
SELECT last_name
FROM employees
WHERE UPPER(last_name) LIKE('__A%');

--21
SELECT first_name
FROM employees
WHERE UPPER(first_name) LIKE ('%L%L%')
    AND (department_id = 30 OR manager_id = 101);

--22
SELECT last_name, job_id, salary
FROM employees
WHERE (LOWER(job_id) LIKE ('%clerk%') OR LOWER(job_id) LIKE ('%rep%'))
        AND salary NOT IN (1000, 2000, 3000);

--23
SELECT last_name, salary, salary * NVL(commission_pct, 0) comision
FROM employees
WHERE salary > salary * commission_pct*5;