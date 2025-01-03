--Laborator 7
--1
CREATE TABLE emp_asi 
AS SELECT * FROM employees;

CREATE TABLE dept_asi 
AS SELECT * FROM departments;

--2
DESC employees;
DESC emp_asi;

--3
SELECT *
FROM emp_asi;

SELECT *
FROM dept_asi;

--4
ALTER TABLE emp_asi
ADD CONSTRAINT pk_emp_asi PRIMARY KEY(employee_id);

ALTER TABLE dept_asi
ADD CONSTRAINT pk_dept_asi PRIMARY KEY(department_id);

ALTER TABLE emp_asi
ADD CONSTRAINT fk_emp_dept_asi
FOREIGN KEY(department_id) REFERENCES 
    dept_asi(department_id);
    
--5
--a NU
INSERT INTO dept_asi
VALUES (300, 'Programare');

DESC dept_asi;

--b DA
INSERT INTO dept_asi (department_id, department_name)
VALUES (300, 'Programare');

ROLLBACK;

--c NU
INSERT INTO dept_asi (department_name, department_id)
VALUES (300, 'Programare');

--d DA
INSERT INTO dept_asi (department_id, department_name, location_id)
VALUES (300, 'Programare', NULL);

--e NU
INSERT INTO dept_asi (department_name, location_id)
VALUES ('Programare', NULL);

--6
DESC emp_asi;
SELECT * 
FROM emp_asi;
SELECT *
FROM jobs;

INSERT INTO emp_asi (employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (207,'Marcel', 'marcel@email.ro', SYSDATE-10, 'AD_PRES', 300);

COMMIT;

--8
INSERT INTO emp_asi (employee_id, last_name, email, hire_date, job_id, department_id)
VALUES ((SELECT MAX(employee_id) + 1 FROM emp_asi),'Marcel', 'marcel@email.ro', SYSDATE-10, 'AD_PRES', 300);

--ASA NU
INSERT INTO emp_asi (employee_id, last_name, email, hire_date, job_id, department_id)
VALUES ((SELECT employee_id + 1 FROM emp_asi),'Marcel', 'marcel@email.ro', SYSDATE-10, 'AD_PRES', 300);


--9
DESC employees;

CREATE TABLE emp1_asi (
    employee_id NUMBER(6) PRIMARY KEY,
    first_name VARCHAR2(20),
    LAST_NAME  VARCHAR2(25) NOT NULL, 
    EMAIL VARCHAR2(25) NOT NULL, 
    PHONE_NUMBER  VARCHAR2(20), 
    HIRE_DATE DATE NOT NULL,         
    JOB_ID VARCHAR2(10) NOT NULL,  
    SALARY NUMBER(8,2), 
    COMMISSION_PCT NUMBER(2,2),  
    MANAGER_ID NUMBER(6),    
    DEPARTMENT_ID NUMBER(4)
);

--14
SELECT *
FROM emp_asi;

UPDATE emp_asi
SET salary = salary * 1.05;

ROLLBACK;

--15
UPDATE emp_asi
SET job_id = 'SA_REP'
WHERE department_id = 80;

SELECT employee_id, department_id, job_id
FROM emp_asi
WHERE department_id = 80;

ROLLBACK;

--22
--cele care nu apar in emp_asi ca cheie straina
DELETE FROM dept_asi;

--23 
DELETE FROM emp_asi
WHERE commission_pct IS NOT NULL;

ROLLBACK;

--31
DELETE FROM emp_asi
WHERE commission_pct IS NOT NULL;

MERGE INTO emp_asi
USING employees b
ON (emp_asi.employee_id = b.employee_id)
WHEN MATCHED THEN 
    UPDATE SET 
        first_name=b.first_name,
        last_name=b.last_name,
        email=b.email,
        phone_number=b.phone_number,
        hire_date=b.hire_date,
        job_id=b.job_id,
        salary=b.salary,
        COMMISSION_PCT=b.COMMISSION_PCT,
        MANAGER_ID=b.MANAGER_ID,
        department_id=b.department_id
WHEN NOT MATCHED THEN 
    INSERT (employee_id, first_name,last_name,
        email, phone_number, hire_date, job_id,
        salary, COMMISSION_PCT, MANAGER_ID,
        department_id)
    VALUES (b.employee_id, b.first_name, b.last_name,
        b.email, b.phone_number, b.hire_date, b.job_id,
        b.salary, b.COMMISSION_PCT, b.MANAGER_ID,
        b.department_id);

DESC employees;

SELECT *
FROM emp_asi;

COMMIT;
--TEMA ex 7, continuare ex 9, 10, 12, 13, 16-20, 24, 26-30


