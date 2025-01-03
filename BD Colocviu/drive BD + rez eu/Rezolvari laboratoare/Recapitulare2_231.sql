--Recapitulare 2
--27
DESC achizitioneaza;
DESC excursie;
SELECT destinatie, cod_agentie, SUM(pret)
FROM excursie
GROUP BY CUBE(cod_agentie, destinatie)
ORDER BY 1, 2;

SELECT destinatie, cod_agentie, SUM(pret)
FROM excursie
GROUP BY GROUPING SETS((cod_agentie, destinatie),(cod_agentie), (destinatie), ())
ORDER BY 1, 2;

--28
DESC achizitioneaza;
SELECT cod_agentie, TO_CHAR(data_achizitie, 'YYYY') an, SUM(e.pret*(1-discount)) suma
FROM excursie e, achizitioneaza ac
WHERE ac.cod_excursie = e.id_excursie
GROUP BY GROUPING SETS((cod_agentie, TO_CHAR(data_achizitie, 'YYYY')), ());

--29
SELECT ex.denumire
FROM excursie ex
WHERE ex.cod_agentie IS NULL
AND NOT EXISTS (
    SELECT 1
    FROM turist
    INNER JOIN achizitioneaza
    ON cod_turist = id_turist
    WHERE (TO_CHAR(data_nastere, 'YYYY') = '1984')
        AND (cod_excursie = ex.id_excursie)
);

SELECT ex.denumire
FROM excursie ex
WHERE ex.cod_agentie IS NULL
AND ex.id_excursie NOT IN (
    SELECT cod_excursie
    FROM turist
    INNER JOIN achizitioneaza
    ON cod_turist = id_turist
    WHERE (TO_CHAR(data_nastere, 'YYYY') = '1984')
);

--30
CREATE TABLE turist_asi AS SELECT * FROM turist;
CREATE TABLE achizitioneaza_asi AS 
    SELECT * FROM achizitioneaza;
CREATE TABLE excursie_asi AS 
    SELECT * FROM excursie;
CREATE TABLE agentie_asi AS 
    SELECT * FROM agentie;
    
ALTER TABLE turist_asi
ADD CONSTRAINT pk_turist_asi PRIMARY KEY(id_turist);

ALTER TABLE achizitioneaza_asi
ADD CONSTRAINT pk_achizitioneaza_asi PRIMARY KEY(cod_turist, cod_excursie, data_start);

ALTER TABLE excursie_asi
ADD CONSTRAINT pk_excursie_asi PRIMARY KEY(id_excursie);

ALTER TABLE agentie_asi
ADD CONSTRAINT pk_agentie_asi PRIMARY KEY(id_agentie);

ALTER TABLE achizitioneaza_asi
ADD CONSTRAINT fk_ac_turist_asi FOREIGN KEY(cod_turist) REFERENCES TURIST(id_turist)
    ON DELETE CASCADE;

ALTER TABLE achizitioneaza_asi
ADD CONSTRAINT fk_ac_excursie_asi FOREIGN KEY(cod_excursie) REFERENCES EXCURSIE(id_excursie)
    ON DELETE CASCADE;

ALTER TABLE excursie_asi
ADD CONSTRAINT fk_ex_agentie_asi FOREIGN KEY(cod_agentie) REFERENCES AGENTIE(id_agentie)
    ON DELETE CASCADE;
    
DROP TABLE achizitioneaza_asi;
DROP TABLE turist_asi;
DROP TABLE excursie_asi;
DROP TABLE agentie_asi;
SELECT * FROM achizitioneaza;

--31
DESC excursie_asi;
UPDATE achizitioneaza_asi
SET discount = (SELECT MAX(discount) 
                FROM achizitioneaza_asi)
WHERE (
    SELECT pret
    FROM excursie_asi
    WHERE id_excursie = cod_excursie
) > (SELECT AVG(pret) FROM excursie_asi);
ROLLBACK;

--34
CREATE OR REPLACE VIEW v_excursie
AS SELECT *
   FROM excursie_asi
   WHERE cod_agentie = 10
WITH CHECK OPTION;
   
DESC v_excursie;
SELECT id_excursie FROM excursie_asi;
SELECT id_excursie, cod_agentie FROM excursie_asi;
INSERT INTO v_excursie
VALUES (2, 'Ex_test', 100, 'Brasov', 5, 30, 5);
COMMIT;

--35
DELETE FROM achizitioneaza_asi;

SAVEPOINT a;

--36
INSERT INTO achizitioneaza_asi
    SELECT *
    FROM achizitioneaza
    WHERE TO_CHAR(data_achizitie, 'YYYY') = '2010';
 
UPDATE achizitioneaza_asi
SET data_start = ADD_MONTHS(data_start, 1),
    data_end = ADD_MONTHS(data_end, 1);

SELECT *
FROM achizitioneaza_asi
ORDER BY data_start, data_end;

SELECT *
FROM achizitioneaza_asi
ORDER BY data_start, data_end;

ROLLBACK;

--37
UPDATE achizitioneaza_asi ac
SET discount = discount * 1.1
WHERE (SELECT e.cod_agentie
       FROM excursie_asi e
       WHERE e.id_excursie = ac.cod_excursie) = 10;

ROLLBACK;

--42
SELECT *
FROM achizitioneaza_asi
WHERE data_start < SYSDATE
AND data_achizitie = (SELECT MIN(data_achizitie)
                      FROM achizitioneaza_asi)
FOR UPDATE;

UPDATE achizitioneaza_asi
SET data_start = SYSDATE
WHERE cod_excursie = 101
AND cod_turist = 3
AND data_start = '01-MAY-01';

COMMIT;

SELECT *
FROM achizitioneaza_asi;

--45
SELECT nume, prenume
FROM turist_asi
WHERE NOT EXISTS (SELECT cod_excursie
                  FROM achizitioneaza_asi
                  WHERE cod_turist = id_turist
                  MINUS
                  SELECT cod_excursie
                  FROM achizitioneaza_asi, turist_asi t
                  WHERE cod_turist = t.id_turist
                  AND UPPER(nume) = 'STANCIU')
AND NOT EXISTS (  SELECT cod_excursie
                  FROM achizitioneaza_asi, turist_asi t
                  WHERE cod_turist = t.id_turist
                  AND UPPER(nume) = 'STANCIU'
                  MINUS
                  SELECT cod_excursie
                  FROM achizitioneaza_asi
                  WHERE cod_turist = id_turist);

--46
DESC turist_asi;
ACCEPT t_cod PROMPT "Dati cod turist:"; 
ACCEPT t_nume PROMPT "Dati numele turist:";
INSERT INTO turist_asi
VALUES (&t_cod, '&t_nume', NULL, SYSDATE - 1000);
PRINT &t_cod;

DEFINE t_cod = 100;
INSERT INTO turist_asi
VALUES (&t_cod, '&t_nume', NULL, SYSDATE - 1000);
PRINT &t_cod;

--48
SELECT nume, prenume
FROM turist_asi
WHERE id_turist = 100;

DELETE FROM turist_asi
WHERE id_turist = 100;

COMMIT;

--TEMA 32, 33, 38, 39(1), 39(2), 40, 41, 43, 44, 46