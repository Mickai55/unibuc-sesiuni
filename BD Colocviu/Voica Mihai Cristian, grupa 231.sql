--Voica Mihai Cristian, grupa 231

--fotografie(id_fotografie, titlu, id_artist, data_crearii)
--expusa(id_fotografie, id_expozitie, data_crearii, nr_zile)
--expozitie(id_expozitie, denumire, data_inceput, data_sfarsit, oras);
--artist(id_artist, nume, data_nasterii, nationalitate);

select * from fotografie;
select * from expusa;
select * from expozitie;
select * from artist;

--1. Sa se afiseze artistii care si-au expus fotografiile in
--expozitii care au inceput in anul 2019 pentru care se cunoaste
--nationalitatea.

select distinct a.nume
from artist a join fotografie f on f.id_artist = a.id_artist
              join expusa e on f.id_fotografie = e.id_fotografie
              join expozitie expoz on e.id_expozitie = expoz.id_expozitie
where to_char(expoz.data_inceput, 'YYYY') = 2019
    and a.nationalitate is not null;

--2. Sa se afiseze in ordine alfabetica dupa nume expozitiile 
--in care nu s-a expus nicio fotografie.

--fotografie(id_fotografie, titlu, id_artist, data_crearii)
--expusa(id_fotografie, id_expozitie, data_crearii, nr_zile)
--expozitie(id_expozitie, denumire, data_inceput, data_sfarsit, oras);
--artist(id_artist, nume, data_nasterii, nationalitate);

select e.denumire
from expozitie e
where id_expozitie not in (
        select distinct id_expozitie
        from expusa
)
order by e.denumire;

--3. Sa se afiseze artistii care au avut expuse cel putin 2 
--fotografii diferite.

--fotografie(id_fotografie, titlu, id_artist, data_crearii)
--expusa(id_fotografie, id_expozitie, data_crearii, nr_zile)
--expozitie(id_expozitie, denumire, data_inceput, data_sfarsit, oras);
--artist(id_artist, nume, data_nasterii, nationalitate);

select * from fotografie;
select * from expusa;
select * from expozitie;
select * from artist;

select a.id_artist, count(f.id_fotografie)
from artist a join fotografie f on a.id_artist = f.id_artist
              join expusa e on e.id_fotografie = f.id_fotografie 
group by a.id_artist
having count(distinct f.id_fotografie) >= 2;

--4. Sa se stearga expunerile fotografiilor care au avut cel putin 2 expozitii.
--Anulati modificarile.

delete from expusa e
where e.id_fotografie in(
        select id_fotografie
        from expusa
        group by id_fotografie
        having count(id_expozitie) >= 2
);

rollback;

--5. Sa se adauge coloana id_expozitie in tabelul artist care va permite sa 
--se cunoasca expozitia care a organizat artistul. Coloana va fi adaugata impreuna
--cu o constrangere de cheie externa.

alter table artist
add id_expozitie number(10)
constraint expozitie_fk references expozitie(id_expozitie);




