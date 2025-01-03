--? ALBUM (id_album, id_formatie, gen, nume, data_l, pret)
--? FORMATIE (id_formatie, nume, data_lansare, data_retragere , website, tara_prov)
--? PREMIU (id_premiu, concurs, sectiune, frecventa, tara_prov)
--? CASTIGA(id_premiu, id_formatie, data_d, loc_ocupat, recompensa) 

--1. Pentru forma?iile care au participat la concursuri desf??urate anual, se cere numele,
--website-ul, împreun? cu albumele lansate (nume, pret) care au avut pre?ul de vânzare mai
--mare de 30 (3 p) 

select * from album;
select * from formatie;
select * from premiu;
select * from castiga;

select f.nume, f.website, a.nume, a.pret
from album a join formatie f on a.id_formatie = f.id_formatie
where f.website in ( 
        select website
        from formatie
        where id_formatie in (
                select distinct id_formatie
                from castiga c join premiu p on c.id_premiu = p.id_premiu
                where frecventa = 'Anual'
                )
    and a.pret > 30
    );

--2. Pentru fiecare premiu câ?tigat de o forma?ie s? se afi?eze numele, locul ocupat, precum ?i
--ultimul album lansat (id_album, nume) înainte de decernare. (2 p) 

select * from album;
select * from formatie;
select * from premiu;
select * from castiga;

select f.id_formatie, f.nume, c.id_premiu, c.loc_ocupat, a.id_album, a.nume
from formatie f join castiga c on f.id_formatie = c.id_formatie
                join album a on f.id_formatie = c.id_formatie
where a.id_formatie = f.id_formatie 
    and a.data_l = (
            select max(data_l)
            from album aa join formatie ff on aa.id_formatie = ff.id_formatie
                          join castiga cc on cc.id_formatie = ff.id_formatie
            where months_between(cc.data_d,aa.data_l)>0 and aa.id_formatie= a.id_formatie
            );
--3. Se cer numele, data lans?rii, num?rul de albume lansate, pentru forma?iile care au câ?tigat
--doar premii bianuale. (2 p) 

select * from album;
select * from formatie;
select * from premiu;
select * from castiga;

select f.id_formatie, f.nume, f.data_lansare, count(a.id_formatie)
from formatie f join album a on a.id_formatie = f.id_formatie
                join castiga c on f.id_formatie = c.id_formatie
                join premiu p on p.id_premiu = c.id_premiu
where p.frecventa not in (
        select frecventa
        from premiu
        where frecventa <> 'Bianual'
        )
    and p.frecventa  = 'Bianual'
group by a.id_formatie, f.nume, f.data_lansare, f.id_formatie;

--4. Crea?i o vizualizare care s? con?in? detalii despre forma?iile care au lansat albume pop ?i
--nu au câ?tigat premii. Insera?i o linie prin intermediul acestei vizualiz?ri. (2 p) 

create or replace view v_formatiepop_lp as (
select f.id_formatie "id_formatie", f.nume "nume",f.data_lansare "data_lansare",f.data_retragere "data_retragere",f.website "website",f.tara_prov "tara_prov"
from formatie f join album a on f.id_formatie=a.id_formatie
where lower(gen) = 'pop' and f.id_formatie not in (select c.id_formatie
                                                  from castiga c))
with CHECK OPTION CONSTRAINT verif_lp;
select * from v_formatiepop_lp;                                                  
insert into v_formatiepop_lp
values (0,'LALA',TO_DATE('10-03-99','dd-mm-yyyy'),NULL,'www.LALA.com','RO');















