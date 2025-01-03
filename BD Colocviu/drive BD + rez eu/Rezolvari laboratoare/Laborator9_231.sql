--Laborator 9
--1
CREATE GLOBAL TEMPORARY TABLE TEMP_TRANZ_ASI
(
    x NUMBER
) ON COMMIT DELETE ROWS;

INSERT INTO TEMP_TRANZ_ASI
VALUES (10);

SELECT *
FROM temp_tranz_asi;

COMMIT;

SELECT *
FROM temp_tranz_asi;

--2
CREATE GLOBAL TEMPORARY TABLE TEMP_SESIUNE_ASI
(
    x NUMBER
) ON COMMIT PRESERVE ROWS;

INSERT INTO TEMP_SESIUNE_ASI
VALUES (10);

SELECT *
FROM temp_sesiune_asi;

COMMIT;

SELECT *
FROM temp_sesiune_asi;

--7
CREATE OR REPLACE VIEW viz_emp30_asi
AS (SELECT employee_id, last_name, email, salary,
        department_id
    FROM employees
    WHERE department_id = 30);
    
SELECT *
FROM viz_emp30_asi;

INSERT INTO viz_emp30_asi
VALUES (1, 'Nume', 'nume@email.com', 3000, 30);

SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VIZ_EMP30_ASI';

DESC viz_emp30_asi;

--8
CREATE OR REPLACE VIEW viz_emp30_asi
AS (SELECT employee_id, last_name, email, salary,
        department_id, hire_date, job_id
    FROM employees
    WHERE department_id = 30);
    
SELECT *
FROM viz_emp30_asi;

INSERT INTO viz_emp30_asi
VALUES (1, 'Nume', 'nume@email.com', 3000, 
        30, SYSDATE, 'PU_MAN');

SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VIZ_EMP30_ASI';

SELECT *
FROM employees
WHERE employee_id = 1;

ROLLBACK;

--12
CREATE VIEW VIZ_DEPT_SUM_ASI (dept_id, min_sal, max_sal, med_sal)
AS (SELECT department_id, MIN(salary), MAX(salary),
        ROUND(AVG(salary), 2)
    FROM employees
    GROUP BY department_id);

SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VIZ_DEPT_SUM_ASI';

--20
CREATE SEQUENCE SEQ_DEPT_ASI
START WITH 200
INCREMENT BY 10
MAXVALUE 10000
NOCYCLE
NOCACHE;

--26
DROP SEQUENCE seq_dept_asi;

--21
SELECT *
FROM USER_SEQUENCES;

DESC departments;
INSERT INTO departments (department_id, department_name)
VALUES (SEQ_DEPT_ASI.NEXTVAL, 'Nou');

SELECT *
FROM departments;

ROLLBACK;

--27
DESC EMP_ASI;

CREATE INDEX IDX_EMP_LAST_NAME_ASI
ON emp_asi(last_name);

--32
DROP INDEX IDX_EMP_LAST_NAME_ASI;

--33
CREATE CLUSTER angajati_asi
(angajat NUMBER(6))
SIZE 512
STORAGE (initial 100 next 50);

--34
CREATE INDEX idx_angajati_asi 
ON CLUSTER angajati_asi;

--35
CREATE TABLE ang_1_asi
CLUSTER angajati_asi(employee_id)
AS SELECT * FROM employees WHERE salary < 5000;

CREATE TABLE ang_2_asi
CLUSTER angajati_asi(employee_id)
AS SELECT * FROM employees WHERE salary BETWEEN 5000 AND 10000;

CREATE TABLE ang_3_asi
CLUSTER angajati_asi(employee_id)
AS SELECT * FROM employees WHERE salary > 10000;

--36
SELECT *
FROM user_clusters;

--37
SELECT *
FROM user_tables
WHERE table_name = 'ANG_3_ASI';

--38
DROP TABLE ang_3_asi;

--39
SELECT *
FROM user_tables
WHERE table_name = 'ANG_3_ASI';

--41
DROP CLUSTER angajati_asi
INCLUDING TABLES 
CASCADE CONSTRAINTS;

--42
CREATE SYNONYM EMP_PUBLIC_ASI
FOR emp_asi;

--45
SET FEEDBACK OFF
SET HEADING OFF
SET TERMOUT OFF
SPOOL "delete_synonym.sql"
SELECT 'DROP SYNONYM ' || synonym_name ||'; '
FROM user_synonyms
WHERE lower(synonym_name) LIKE '%asi'
/
SPOOL OFF
SET FEEDBACK ON
SET HEADING ON
SET TERMOUT ON

--46
CREATE MATERIALIZED VIEW job_dep_sal_asi
BUILD IMMEDIATE
REFRESH COMPLETE
ENABLE QUERY REWRITE
AS SELECT d.department_name, j.job_title, SUM(salary) suma_salarii
    FROM employees e, departments d, jobs j
    WHERE e.department_id = d. department_id
    AND e.job_id = j.job_id
    GROUP BY d.department_name, j.job_title;

SELECT *
FROM job_dep_sal_asi;

--41
DROP MATERIALIZED VIEW job_dep_sal_asi;

--TEMA 3-6, 9-11, 13-19, 22-25, 28-31, 43-44, 47-49