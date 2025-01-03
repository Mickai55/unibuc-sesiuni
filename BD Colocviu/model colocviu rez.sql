--AUTOCARE(autocar_id, nr_inmatriculare, nr_locuri)
--CURSE(cursa_id, autocar_id, destinatie_id, data_plecare,  pret)
--BILETE(bilet_id, client_id, cursa_id, anulat)
--CLIENTI(client_id, nume, prenume, data_nasterii)
--DESTINATII(destinatie_id, tara, oras);


--1. Sa se afiseze clientii (nume, prenume) care au cumparat bilete spre Timisoara
--la preturi cuprinse intre 50 si 100 ron.

select nume, prenume 
from clienti cl join bilete b on (cl.client_id = b.client_id)
join curse c on (c.cursa_id = b.cursa_id) 
join destinatii d on (c.destinatie_id = d.destinatie_id)
where oras = 'Timisoara';


---2.Sa se afiseze clientii care au bilete spre toate destinatiile 
--la care a achizitionat bilete clientul cu numele tudor Tudor (3).

Tudor       c.client_id      c.client_id      c.client_id   
1               1               1                 1
2               2               5
                5
select nume, prenume 
from clienti cl
where not exists 
(   
    select distinct destinatie_id
    from curse c join bilete b on (c.cursa_id = b.cursa_id)
    where client_id = (select client_id  from clienti where nume ='Tudor')
    minus 
    select distinct destinatie_id
    from curse c join bilete b on (c.cursa_id = b.cursa_id)
    where client_id = cl.client_id
);

--3. Sa se afiseze destinatiie (tara, orasul) la care vor pleca autocare
--cu toate locurile ocupate.
select d.tara, d.oras
from destinatii d join  curse c on (c.destinatie_id = d.destinatie_id)
                  join bilete b on (b.cursa_id = c.cursa_id)
                  join autocare a on (a.autocar_id = c.autocar_id)
group by c.cursa_id, d.tara, d.oras, a.nr_locuri
having count(*) = a.nr_locuri   ;


--4. Sa se creeze coloana ora de tipul varchar2(5) si locuri_libere de tipul number 
--in tabelul cursa 
--Sa se actualizeze aceste coloane conform cu datele existente in tabelele
--curse si BILETE.

alter table curse  add (ora varchar2(5), locuri_libere number) ;

update curse c
set ora = to_char(data_plecare , 'hh24:mi');

--update curse c
--set locuri_libere = (select a.nr_locuri - ocupate
--                    from autocare a , (select count(*)  ocupate
--                                       from  bilete b 
--                                       where b.cursa_id = c.cursa_id)                     
--                    where a.autocar_id = c.autocar_id
--                    );
                    
update curse c
set locuri_libere = (select a.nr_locuri - co.ocupate 
                     from autocare a, co
                     where a.autocar_id = co.autocar_id 
                     and c.cursa_id = co.cursa_id
                     );

create table co as 
select b.cursa_id , c.autocar_id , count(*)  ocupate
from  bilete b , curse c
where b.cursa_id = c.cursa_id
group by b.cursa_id, c.autocar_id;

drop table co;
