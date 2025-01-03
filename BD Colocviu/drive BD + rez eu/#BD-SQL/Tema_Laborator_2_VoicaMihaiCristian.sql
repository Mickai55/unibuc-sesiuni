--tema lab 2

--4

SELECT last_name, employee_id, LENGTH(last_name) lungime, INSTR(last_name, 'a') aparitie
FROM employees
WHERE last_name LIKE('%e');

--7

SELECT last_name "Nume angajat", hire_date "Data angajarii"
FROM employees
WHERE commission_pct <> 0;

--9

SELECT ROUND(TO_DATE('01-JAN-2021', 'DD-MON-YYYY') - SYSDATE)
FROM dual;

--13

SELECT last_name, hire_date, TO_CHAR(hire_date, 'day') "Zi"
FROM employees
ORDER BY MOD(TO_CHAR(hire_date, 'd') + 5, 7);

--14

SELECT last_name, DECODE(commission_pct, NULL, 'Fara comision', commission_pct) "Comision"
FROM employees;

--15

SELECT last_name, salary, commission_pct
FROM employees
WHERE salary > 10000;

--19

SELECT last_name, department_name, city
FROM employees e JOIN departments d ON e.department_id = d.department_id
                 JOIN locations l ON l.location_id = d.location_id
WHERE commission_pct IS NOT NULL;

--20

SELECT last_name, department_name, d.department_id
FROM employees e JOIN departments d ON e.department_id = d.department_id
WHERE UPPER(last_name) LIKE('%A%');

--21

SELECT last_name, job_id, e.employee_id, department_name
FROM employees e JOIN departments d ON e.department_id = d.department_id
                    JOIN locations l ON l.location_id = d.location_id
WHERE initcap(city) = 'Oxford';

--22

SELECT e1.employee_id "Ang#", e1.last_name "Angajat", e2.last_name "Manager", e2.employee_id "Mgr#" 
FROM employees e1 JOIN employees e2 ON e1.manager_id = e2.employee_id;

--23

SELECT e1.employee_id "Ang#", e1.last_name "Angajat", e2.last_name "Manager", e2.employee_id "Mgr#" 
FROM employees e1 LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;

--27

SELECT e1.last_name "Angajat", e1.hire_date "Data_ang", e2.last_name "Manager", e2.hire_date "Data_mgr"
FROM employees e1 ,employees e2
WHERE e1.manager_id = e2.employee_id AND e1.hire_date < e2.hire_date;
    

