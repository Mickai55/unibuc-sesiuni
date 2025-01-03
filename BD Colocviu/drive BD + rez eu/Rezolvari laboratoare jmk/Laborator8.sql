--Laborator 8
SELECT *
FROM user_tables;

--1
CREATE TABLE angajati_asi (
    cod_ang NUMBER(4),
    nume VARCHAR2(20),
    prenume VARCHAR2(20), 
    email CHAR(15),
    data_ang DATE DEFAULT SYSDATE,
    job VARCHAR2(10),
    cod_sef NUMBER(4),
    salariu NUMBER(8,2),
    cod_dep NUMBER(2)
);

--b
DROP TABLE angajati_asi;

CREATE TABLE angajati_asi (
    cod_ang NUMBER(4) PRIMARY KEY,
    nume VARCHAR2(20) NOT NULL,
    prenume VARCHAR2(20), 
    email CHAR(15),
    data_ang DATE DEFAULT SYSDATE,
    job VARCHAR2(10),
    cod_sef NUMBER(4),
    salariu NUMBER(8,2) NOT NULL,
    cod_dep NUMBER(2)
);

DESC angajati_asi;

--c
DROP TABLE angajati_asi;

CREATE TABLE angajati_asi (
    cod_ang NUMBER(4),
    nume VARCHAR2(20) NOT NULL,
    prenume VARCHAR2(20), 
    email CHAR(15),
    data_ang DATE DEFAULT SYSDATE,
    job VARCHAR2(10),
    cod_sef NUMBER(4),
    salariu NUMBER(8,2) NOT NULL,
    cod_dep NUMBER(2),
    CONSTRAINT pk_cod_ang PRIMARY KEY(cod_ang)
);

--2
INSERT INTO ANGAJATI_ASI (cod_ang, nume, prenume, 
                          job, salariu, cod_dep)
VALUES ( 100, 'Nume1', 'Prenume1', 
    'Director', 20000, 10);


INSERT INTO ANGAJATI_ASI
VALUES ( 101, 'Nume2', 'Prenume2', 'Nume2',
    TO_DATE('02-02-2004', 'DD-MM-YYYY'), 'Inginer',
    100, 10000, 10);

INSERT INTO ANGAJATI_ASI
VALUES ( 102, 'Nume3', 'Prenume2', 'Nume3',
    TO_DATE('05-06-2000', 'DD-MM-YYYY'), 'Analist', 
    101, 5000, 20);

INSERT INTO ANGAJATI_ASI (cod_ang, nume, prenume, 
                          job, cod_sef, salariu, 
                          cod_dep)
VALUES ( 103, 'Nume4', 'Prenume4', 
    'Inginer', 100, 9000, 20);

INSERT INTO ANGAJATI_ASI
VALUES ( 104, 'Nume5', 'Prenume5', 'Nume5',
    NULL, 'Analist', 
    101, 3000, 30);
    
UPDATE angajati_asi
SET data_ang = NULL
WHERE cod_ang IN (100,103);

SELECT *
FROM angajati_asi;

--4
ALTER TABLE angajati_asi
ADD comision NUMBER(4,2);

--5 
--NU, PENTRU CA AVEM DATE PE COLOANA RESPECTIVA 
--DIFERITE DE NULL => NU SE POATE MICSORA DIMENSIUNEA

--6
ALTER TABLE angajati_asi
MODIFY salariu NUMBER(8,2) DEFAULT 0;

--7
ALTER TABLE angajati_asi
MODIFY (comision NUMBER(2,2), salariu NUMBER(10,2));

INSERT INTO angajati_asi(cod_ang, nume)
VALUES (106, 'nume7');

DELETE FROM angajati_asi
WHERE cod_ang = 106;

SELECT *
FROM angajati_asi;

--8
UPDATE angajati_asi
SET comision = 0.1
WHERE UPPER(job) LIKE ('A%');

--12
RENAME angajati_asi TO angajati3_asi;

--13
SELECT *
FROM tab;

RENAME angajati3_asi TO angajati_asi;

--14
TRUNCATE TABLE angajati10_asi;

--VERIFICARE => CONSTRAINT ck_nume CHECK(cod_dep > 0) 

--21
--suprimarea tabelului departamente_pnu este posibila,
--doar daca nicio linie din acesta nu are copii in 
--tabelul angajati_pnu

--22
DESC tab;
DESC user_tables;
DESC user_constraints;

SELECT * FROM tab;

SELECT table_name FROM user_tables;

SELECT * FROM user_constraints;

--23
--a
SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE lower(table_name) IN ('angajati_asi', 'departamente_asi');

--b
SELECT constraint_name, table_name, column_name
FROM user_cons_columns
WHERE lower(table_name) IN ('angajati_asi', 'departamente_asi');

--34
--constrangerea on delete set null

--35
ALTER TABLE angajati_asi
ADD CONSTRAINT ck_salariu CHECK(salariu <= 30000);

--36
UPDATE angajati_asi
SET salariu = 35000
WHERE cod_ang = 100;

--37
ALTER TABLE angajati_asi
DISABLE CONSTRAINT ck_salariu;

UPDATE angajati_asi
SET salariu = 35000
WHERE cod_ang = 100;

ALTER TABLE angajati_asi
ENABLE CONSTRAINT ck_salariu;

--TEMA: 3, 9, 10, 11, 15, 16, 17, 18, 19, 20, 24-34 