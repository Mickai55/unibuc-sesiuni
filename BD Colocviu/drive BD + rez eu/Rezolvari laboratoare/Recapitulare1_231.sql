--Recapitulare 1
--1
SELECT denumire
FROM excursie e, achizitioneaza a
WHERE e.id_excursie = a.cod_excursie
AND data_start = (SELECT MIN(data_start)
                  FROM achizitioneaza);
                  
--SAU
SELECT *
FROM (SELECT denumire
      FROM excursie e, achizitioneaza a
      WHERE e.id_excursie = a.cod_excursie
      ORDER BY data_start)
WHERE ROWNUM = 1;

--4
--a
SELECT nume, prenume, COUNT(cod_excursie) nr_ex
FROM turist t, achizitioneaza a
WHERE t.id_turist = a.cod_turist
GROUP BY t.id_turist, nume, prenume
HAVING COUNT(cod_excursie) >= 2;

--SAU
SELECT MAX(nume), MAX(prenume), COUNT(cod_excursie) nr_ex
FROM turist t, achizitioneaza a
WHERE t.id_turist = a.cod_turist
GROUP BY t.id_turist
HAVING COUNT(cod_excursie) >= 2;

--b
SELECT COUNT(*) nr_turisti
FROM (SELECT 'x'
      FROM turist t, achizitioneaza a
      WHERE t.id_turist = a.cod_turist
      GROUP BY t.id_turist
      HAVING COUNT(cod_excursie) >= 2);

--7
SELECT a.denumire, 
    SUM(e.pret - e.pret * NVL(ac.discount, 0)) profit
FROM agentie a, excursie e, achizitioneaza ac
WHERE a.id_agentie = e.cod_agentie
AND e.id_excursie = ac.cod_excursie
GROUP BY a.id_agentie, a.denumire;

--8
SELECT a.id_agentie, a.denumire, a.oras
FROM agentie a
WHERE 3 <= (SELECT COUNT(e.id_excursie)
            FROM excursie e
            WHERE e.cod_agentie = a.id_agentie
            AND pret < 2000);

SELECT id_excursie, pret, cod_agentie
FROM excursie
ORDER BY 3;

--pt 11
SELECT *
FROM excursie
ORDER BY denumire;

--12
SELECT t.id_turist, t.nume, t.prenume
FROM turist t, achizitioneaza a
WHERE t.id_turist = a.cod_turist
AND data_end - data_start >= 10;

--au achizitionat numai excursii de mai mult de 10 zile
SELECT id_turist, nume, prenume
FROM turist s, achizitioneaza ac
WHERE s.id_turist = ac.cod_turist 
AND NOT EXISTS(
        SELECT t.id_turist
        FROM turist t, achizitioneaza a
        WHERE t.id_turist = a.cod_turist
        AND t.id_turist = s.id_turist
        AND data_end - data_start < 10);
        
--15
SELECT DISTINCT id_turist, nume, prenume
FROM turist t, achizitioneaza a, excursie e, agentie ag
WHERE t.id_turist = a.cod_turist
AND a.cod_excursie = e.id_excursie
AND ag.id_agentie = e.cod_agentie
AND LOWER(e.denumire) LIKE ('%1 mai%')
AND INITCAP(ag.oras) = 'Bucuresti';

SELECT id_excursie, cod_agentie, cod_turist
FROM excursie e, achizitioneaza a
WHERE LOWER(denumire) LIKE ('%1 mai%')
AND e.id_excursie = a.cod_excursie;

SELECT id_agentie
FROM agentie
WHERE INITCAP(oras) = 'Bucuresti';

--17
SELECT id_excursie, e.denumire
FROM excursie e
WHERE nr_locuri = (SELECT COUNT(a.cod_turist)
                   FROM achizitioneaza a
                   WHERE a.cod_excursie = e.id_excursie
                   AND TO_CHAR(data_start,'DD-MON-YYYY') = '14-AUG-2011');

--SAU
SELECT id_excursie, e.denumire
FROM excursie e, achizitioneaza a
WHERE a.cod_excursie = e.id_excursie
AND TO_CHAR(data_start,'DD-MON-YYYY') = '14-AUG-2011'
GROUP BY id_excursie, e.denumire, nr_locuri
HAVING nr_locuri - COUNT(a.cod_turist) = 0;

--23
WITH tabel AS (
     SELECT COUNT(e.id_excursie) nr_ex, oras
     FROM excursie e, agentie a
     WHERE e.cod_agentie = a.id_agentie
     GROUP BY e.cod_agentie, oras)
SELECT COUNT(id_excursie) "Numar excursii",
    s "Nr. ex Constanta",
    s1 "Nr. ex Bucuresti"
FROM excursie, (SELECT SUM(nr_ex) s
                FROM tabel t
                WHERE INITCAP(t.oras) = 'Constanta'),
                (SELECT SUM(nr_ex) s1
                FROM tabel t
                WHERE INITCAP(t.oras) = 'Bucuresti')
GROUP BY s, s1;

SELECT COUNT(id_excursie) "Numar excursii",
    DECODE(oras, 'Constanta', COUNT(id_excursie)) "Nr. ex Constanta"
FROM excursie e, agentie a
WHERE e.cod_agentie = a.id_agentie
GROUP BY id_agentie, oras;