--Laborator 2
--Exercitii 
--1
--v1
SELECT last_name || ' ' || 
    first_name || ' castiga ' ||
    salary || ' lunar dar doreste '
    || salary*3 info
FROM employees;

--v2
SELECT CONCAT(last_name, CONCAT(' ', 
    CONCAT(first_name, CONCAT(
    ' castiga ', CONCAT(salary,
    CONCAT(' lunar dar doreste ',
    salary*3)))))) info
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
SELECT last_name, employee_id, first_name,
    department_id
FROM employees
WHERE INITCAP(TRIM(BOTH FROM first_name)) = 
    'Steven';
    
--5
SELECT *
FROM employees
WHERE MOD(ROUND(SYSDATE-hire_date), 7) = 0;

--6
SELECT employee_id, last_name, 
    TRUNC(salary*1.15,2) "Salariu nou",
    ROUND(TRUNC(salary*1.15,2)/100,2) "Numar sute"
FROM employees
WHERE MOD(salary, 1000) <> 0;

--8
SELECT TO_CHAR(SYSDATE + 30, 
    'MONTH DAY YYYY HH24:MI:SS') data_peste_30_zile
FROM dual;

--9

--10
--a
SELECT TO_CHAR(SYSDATE + 0.5, 'DD.MM.YYYY HH24:MI')
FROM dual;

--b
--24*60=1440
SELECT TO_CHAR(SYSDATE + 5/1440, 'DD.MM.YYYY HH24:MI')
FROM dual;

--11
SELECT last_name || ' ' || first_name Nume_ang,
    hire_date, NEXT_DAY(ADD_MONTHS(hire_date,6),
        'Monday') "Negociere"
FROM employees;

--12
SELECT last_name, 
    CEIL(MONTHS_BETWEEN(SYSDATE, hire_date)) 
        "Luni lucrate"
FROM employees
ORDER BY CEIL(MONTHS_BETWEEN(SYSDATE, hire_date));

SELECT UID,USER
FROM dual;

SELECT VSIZE(salary)
FROM employees
WHERE employee_id=200;

--16
SELECT last_name, job_id, salary, 
    CASE job_id
        WHEN 'IT_PROG' THEN salary*1.2
        WHEN 'SA_REP' THEN salary * 1.25
        WHEN 'SA_MAN' THEN salary * 1.35
        ELSE salary
    END "Salariu renegociat"
FROM employees;
    
                    