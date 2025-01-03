--tema lab 1

--14

SELECT last_name, salary
FROM employees
WHERE department_id IN (10,30) AND salary > 3500
ORDER BY last_name;

--18

SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;

--20

SELECT last_name
FROM employees
WHERE UPPER(last_name) LIKE('__A%');

--22

SELECT last_name, job_id, salary
FROM employees
WHERE (LOWER(job_id) LIKE ('%clerk%') OR LOWER(job_id) LIKE ('%rep%'))
        AND salary NOT IN (1000, 2000, 3000);