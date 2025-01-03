--Laborator 2
--Exercitii 
--1
--v1
SELECT last_name || ' ' || 
    first_name || ' castiga ' ||
    salary || ' lunar dar doreste '
    || salary  *3 Facts
FROM employees;

--2
--V1
SELECT INITCAP(last_name) prenume,
    UPPER(first_name) nume, 
    LENGTH(first_name) lungime
FROM employees
WHERE UPPER(first_name) LIKE ('J%')
OR UPPER(first_name) LIKE ('M%')
OR UPPER(first_name) LIKE ('__A%')
ORDER BY lungime DESC;

--v2
SELECT INITCAP(last_name) prenume,
    UPPER(first_name) nume, 
    LENGTH(first_name) lungime
FROM employees
WHERE SUBSTR(UPPER(first_name),1,1)='J'
OR SUBSTR(UPPER(first_name),1,1)='M'
OR SUBSTR(UPPER(first_name),3,1)='A'
ORDER BY lungime DESC;

--3
SELECT last_name, employee_id, first_name, department_id
FROM employees
WHERE INITCAP(TRIM(BOTH FROM first_name)) = 'Steven';

--4
SELECT last_name, employee_id, LENGTH(last_name) lungime, INSTR(last_name, 'a') aparitie
FROM employees
WHERE last_name LIKE('%e');
    
--5
SELECT *
FROM employees
WHERE MOD(ROUND(SYSDATE-hire_date), 7) = 0;

--6
SELECT  employee_id, 
        last_name, 
        TRUNC(salary*1.15,2) "Salariu nou",
        ROUND(TRUNC(salary*1.15,2)/100,2) "Numar sute"
FROM employees
WHERE MOD(salary, 1000) <> 0;

--7
SELECT last_name "Nume angajat", hire_date "Data angajarii"
FROM employees
WHERE commission_pct <> 0;


--8
SELECT TO_CHAR(SYSDATE + 30, 'MONTH DAY YYYY HH24:MI:SS') data_peste_30_zile
FROM dual;

--9
SELECT ROUND(TO_DATE('01-JAN-2021', 'dd-mon-yyyy') - SYSDATE)
FROM dual;

--10
--a
SELECT TO_CHAR(SYSDATE + 0.5, 'DD.MM.YYYY HH24:MI')
FROM dual;
--b
--24*60=1440
SELECT TO_CHAR(SYSDATE + 5/1440, 'DD.MM.YYYY HH24:MI')
FROM dual;

--11
SELECT last_name || ' ' || first_name Nume_ang, hire_date,
       NEXT_DAY(ADD_MONTHS(hire_date,6),'Monday') "Negociere"
FROM employees;

--12
SELECT last_name, CEIL(MONTHS_BETWEEN(SYSDATE, hire_date)) "Luni lucrate"
FROM employees
ORDER BY CEIL(MONTHS_BETWEEN(SYSDATE, hire_date)) desc;

--SELECT UID,USER
--FROM dual;
--
--SELECT VSIZE(salary)
--FROM employees
--WHERE employee_id=200;
SELECT sysdate
from dual;
--13

SELECT last_name, hire_date, TO_CHAR(hire_date, 'Day') "Zi"
FROM employees
ORDER BY MOD(TO_CHAR(hire_date, 'd') + 5, 7);

--14

SELECT last_name, DECODE(commission_pct, NULL, 'Fara comision', commission_pct) "Comision"
FROM employees;

--15

SELECT last_name, salary, commission_pct
FROM employees
WHERE salary > 10000;

--16
SELECT last_name, job_id, salary, 
    CASE job_id
        WHEN 'IT_PROG' THEN salary * 1.2
        WHEN 'SA_REP' THEN salary * 1.25
        WHEN 'SA_MAN' THEN salary * 1.35
        ELSE salary
    END "Salariu renegociat"
FROM employees
ORDER BY job_id;

--sau

SELECT last_name, job_id, salary, 
    DECODE(job_id,'IT_PROG', salary * 1.2,
        'SA_REP', salary * 1.25,
        'SA_MAN', salary * 1.35,
        salary) "Salariu renegociat"
FROM employees;

------------------------------------------
--numarul de angajati
SELECT COUNT(*)
FROM employees;
        
--numarul de angajati pe departement
SELECT department_id, COUNT(employee_id)
FROM employees
GROUP BY department_id;
------------------------------------------

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
FROM employees e JOIN departments d ON e.department_id = d.department_id
                 JOIN jobs j ON j.job_id = e.job_id
WHERE d.department_id = 30;

--sau

SELECT DISTINCT d.department_id, j.job_id, job_title
FROM employees e, departments d, jobs j  
WHERE d.department_id = 30
    AND e.department_id = d.department_id
    AND j.job_id = e.job_id;

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
FROM employees e1 JOIN employees e2 ON e1.manager_id = e2.employee_id
order by e1.manager_id desc;

--23

SELECT e1.employee_id "Ang#", e1.last_name "Angajat", e2.last_name "Manager", e2.employee_id "Mgr#" 
FROM employees e1 LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id
order by e1.manager_id desc;

--24
SELECT e1.employee_id, e1.last_name, e1.department_id, e2.employee_id, e2.last_name
FROM employees e1, employees e2
WHERE e1.department_id = e2.department_id
AND e1.employee_id <> e2.employee_id;

--25
DESC jobs;

SELECT last_name, j.job_id, job_title, department_name, salary
FROM employees emp, departments d, jobs j
WHERE emp.department_id = d.department_id
AND j.job_id = emp.job_id;

--26
SELECT *
FROM employees
WHERE UPPER(last_name) = 'GATES';

SELECT e1.last_name, e1.hire_date
FROM employees e1, employees e2
WHERE UPPER(e2.last_name) = 'GATES' AND e1.hire_date > e2.hire_date
ORDER BY e1.hire_date;

SELECT e1.last_name, e1.hire_date
FROM employees e1 JOIN employees e2 ON e1.hire_date > e2.hire_date
WHERE UPPER(e2.last_name) = 'GATES'
ORDER BY e1.hire_date;

--27

SELECT e1.last_name "Angajat", e1.hire_date "Data_ang", e2.last_name "Manager", e2.hire_date "Data_mgr"
FROM employees e1 ,employees e2
WHERE e1.manager_id = e2.employee_id AND e1.hire_date < e2.hire_date;
    
                    