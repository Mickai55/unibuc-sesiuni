--Laborator 6
DESC works_on;

--Exemplu
--Metoda 1
SELECT DISTINCT employee_id
FROM works_on a
WHERE NOT EXISTS
    (SELECT 1
    FROM project p
    WHERE budget=10000
AND NOT EXISTS
    (SELECT 'x'
    FROM works_on b
    WHERE p.project_id=b.project_id
    AND b.employee_id=a.employee_id));

--Metoda 2
SELECT employee_id
FROM works_on
WHERE project_id IN
    (SELECT project_id
    FROM project
    WHERE budget=10000)
GROUP BY employee_id
HAVING COUNT(project_id)=
        (SELECT COUNT(*)
        FROM project
        WHERE budget=10000);

--Metoda 3
SELECT employee_id
FROM works_on
MINUS
SELECT employee_id from
    ( SELECT employee_id, project_id
    FROM (SELECT DISTINCT employee_id FROM works_on) t1,
    (SELECT project_id FROM project WHERE budget=10000) t2
    MINUS
    SELECT employee_id, project_id FROM works_on
    ) t3;

--Metoda 4
SELECT DISTINCT employee_id
FROM works_on a
WHERE NOT EXISTS (
    (SELECT project_id
    FROM project p
    WHERE budget=10000)
    MINUS
    (SELECT p.project_id
    FROM project p, works_on b
    WHERE p.project_id=b.project_id
    AND b.employee_id=a.employee_id));

--1
DESC works_on;
DESC projects;
SELECT *
FROM projects;
SELECT DISTINCT employee_id
FROM works_on w
WHERE NOT EXISTS ((SELECT project_id
                   FROM projects
                   WHERE EXTRACT(YEAR FROM start_date) = 2006
                   AND TO_CHAR(start_date, 'MM') <= 6)
                  MINUS
                  (SELECT project_id
                   FROM works_on w1
                   WHERE w1.employee_id = w.employee_id));

--2
DESC job_history;

--7
SELECT employee_id
FROM employees e
WHERE EXISTS (SELECT 'x'
              FROM projects p, employees m
              WHERE p.project_manager = m.employee_id
              AND m.department_id = e.department_id);

--8
with project_managers as(
    SELECT DISTINCT project_manager AS employee_id
    from projects
)
SELECT first_name, last_name, department_id
from employees
WHERE department_id NOT IN (
    SELECT DISTINCT department_id
    from departments
    inner join employees
    using (department_id)
    inner join project_managers
    using (employee_id)
);

--14
--a
DESC job_grades;

SELECT *
FROM job_grades;

--b
SELECT DISTINCT last_name, first_name, grade_level
FROM employees e, job_grades j
WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal
ORDER BY 1;

--15
--I.
SELECT employee_id, last_name, salary, department_id
FROM employees WHERE employee_id = &p_cod;
--II. 
DEFINE p_cod; -- Ce efect are?
SELECT employee_id, last_name, salary, department_id
FROM employees WHERE employee_id = &p_cod;
UNDEFINE p_cod;
--III. 
DEFINE p_cod=100;
SELECT employee_id, last_name, salary, department_id
FROM employees WHERE employee_id = &&p_cod;
UNDEFINE p_cod;
--IV. 
ACCEPT p_cod PROMPT "cod= ";
SELECT employee_id, last_name, salary, department_id
FROM employees WHERE employee_id = &p_cod;

--19
ACCEPT start_date PROMPT "start_date= ";
ACCEPT end_date PROMPT "end_date= ";
SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN TO_DATE('&start_date', 'MM/DD/YY') 
        AND TO_DATE('&end_date', 'MM/DD/YY');
SELECT hire_date
FROM employees;

--21
--a
ACCEPT start_date PROMPT "start_date= ";
ACCEPT end_date PROMPT "end_date= ";
SELECT TO_DATE('&end_date', 'MM/DD/YY') - TO_DATE('&start_date', 'MM/DD/YY')
FROM DUAL;

--TEMA 2 (job_history), 3, 4, 5, 6, 9, 10, 11, 12, 13, 16, 17, 18, 20, 21(b)