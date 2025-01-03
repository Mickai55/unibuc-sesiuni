--tema recapitulare 1

--2

select denumire, count(cod_excursie)
from excursie e join achizitioneaza a on e.id_excursie = a.cod_excursie
group by denumire;

--3

select a.denumire, a.oras, count(e.denumire), avg(pret)
from excursie e join agentie a on e.cod_agentie = a.id_agentie
group by a.denumire, a.oras;

--5

select *
from turist 
where (nume, prenume) not in (
        select distinct nume, prenume
        from turist t join achizitioneaza a on t.id_turist = a.cod_turist
                      join excursie e on e.id_excursie = a.cod_excursie
        where upper(destinatie) = 'PARIS'
        );

--6

select nume, prenume, cod_turist, count(cod_turist)
from turist t join achizitioneaza a on t.id_turist = a.cod_turist
group by nume, prenume, cod_turist
having count(cod_turist) >= 2;        

--9

select *
from excursie
where id_excursie not in (
        select cod_excursie
        from achizitioneaza
        );

--10

select ex.denumire, ex.pret, NVL(a.denumire, 'agentie necunoscuta') denumire_agentie
from excursie ex left join agentie a on ex.cod_agentie = a.id_agentie;

--13

select nume, prenume, cod_excursie
from turist t join achizitioneaza a on t.id_turist = a.cod_turist
where (SYSDATE - data_nastere) / 365 < 30;

--14

select *
from turist
where id_turist not in(
        select cod_turist
        from achizitioneaza
        where cod_excursie in(
                select id_excursie
                from excursie
                where cod_agentie in(
                        select id_agentie
                        from agentie
                        where oras = 'Bucuresti'
                        )
                )
        );  

--16

select nume, prenume, ex.denumire
from turist t join achizitioneaza a on t.id_turist = a.cod_turist
              join excursie ex on ex.id_excursie = a.cod_excursie
              join agentie ag on ag.id_agentie = ex.cod_agentie
where upper(ag.denumire) = 'SMART TOUR';

--18

select cod_turist, max(data_achizitie)
from achizitioneaza
group by cod_turist;

--19

select * 
from(
        select *
        from excursie
        order by pret desc
        )
where rownum < 6;

--20

select nume
from turist t join achizitioneaza a on t.id_turist = a.cod_turist
where to_char(data_achizitie,'MON') = to_char(data_nastere, 'MON');

--21

select *
from turist t join achizitioneaza a on t.id_turist = a.cod_turist
              join excursie ex on ex.id_excursie = a.cod_excursie
              join agentie ag on ag.id_agentie = ex.cod_agentie
where ex.nr_locuri = 2 and upper(ag.oras) = 'CONSTANTA';

--24

select nume, prenume, a.cod_excursie
from turist t join achizitioneaza a on t.id_turist = a.cod_turist
where round((SYSDATE - data_nastere) / 365) = 24;

--25

select id_agentie, destinatie, sum(pret - pret * NVL(discount, 0)) valoare
from turist t join achizitioneaza a on t.id_turist = a.cod_turist
              join excursie ex on ex.id_excursie = a.cod_excursie
              join agentie ag on ag.id_agentie = ex.cod_agentie
group by cube(id_agentie, destinatie);

--26

select id_agentie, oras, avg(pret) pret_mediu
from agentie ag join excursie ex on ag.id_agentie = ex.cod_agentie
group by id_agentie, oras
order by oras;



















