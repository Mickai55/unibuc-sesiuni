--5 sus
SELECT employee_id, last_name,
    salary * 12 "ANNUAL SALARY"
FROM employees;

--Exercitii
--3
DESC countries;

DESC employees;

--4
SELECT * 
FROM departments;

--5
SELECT employee_id, last_name || ' ' || 
    first_name emp_name, job_id, hire_date
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
    phone_number || ', ' || hire_date || ', ' ||
    job_id || ', ' || salary || ', ' || 
    NVL(commission_pct, 0) || ', ' || manager_id || 
    ', ' || department_id "Informatii complete"
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

--sau

SELECT last_name, salary
FROM employees
WHERE salary <= 1500 
OR salary >= 2850;

--12
SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN
    TO_DATE('20-FEB-1987', 'DD-MON-YYYY')
        AND TO_DATE('1-MAY-1989', 'DD-MON-YYYY')
ORDER BY hire_date ASC;

--13
SELECT last_name, department_id
FROM employees
WHERE department_id IN (10,30)
ORDER BY last_name;