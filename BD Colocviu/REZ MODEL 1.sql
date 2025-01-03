-- STUDENT (COD_STUDENT, nume, prenume, data_nasterii, nr_matricol, grupa, an , cnp, sectie)
-- PROFESOR (COD_PROFESOR, nume, prenume, data_nasterii, data_angajarii, titlu, salariu)
-- CURS (COD_CURS, denumire, nr_credite, COD_PROFESOR)
-- NOTE (COD_STUDENT, COD_CURS, nota, data_examinare) 


--1. Afi?a?i numele ?i prenumele profesorilor, împreun? cu numele ?i prenumele studen?ilor,
--n?scu?i în aceea?i lun? cu profesorii, care au urmat cel pu?in un curs al acestora. (2p)  

select * from student;
select * from profesor;
select * from curs;
select * from note;

select Distinct p.nume,p.prenume, s.nume, s.prenume
from profesor p join curs using (cod_profesor)
                join note using (cod_curs)
                join student s using(cod_student)
where to_char(p.data_nasterii,'MON') = to_char(s.data_nasterii,'MON');

--2. Numele ?i prenumele studen?ilor care au avut restan?e la cel pu?in acelea?i cursuri ca ?i
--studentul care are codul 1. (2.5p) 

select * from student;
select * from profesor;
select * from curs;
select * from note;

select nume, prenume, s.cod_student
from student s
where  EXISTS (
        (select cod_curs
         from note
         where nota < 5 and cod_student = 1
        )
        MINUS
        (select cod_curs
         from note n2
         where s.cod_student = n2.cod_student and nota < 5
        )
);
       
--3. Pentru fiecare profesor ?i pentru fiecare curs ?inut de ace?tia afi?a?i num?rul total de
--studen?i care au promovat. (2p)  

select * from student;
select * from profesor;
select * from curs;
select * from note;

select nume, prenume, c2.denumire, (
        select count(*)
        from note n join curs c1 on n.cod_curs = c1.cod_curs
        where nota >= 5 and c1.cod_curs = c2.cod_curs 
        ) "Nr. studenti promovati"
from profesor join curs c2 using (cod_profesor);

--4. Crea?i tabelul credite care s? con?in? codul, cnp-ul ?i num?rul total de credite pe care le
--de?ine fiecare student. Ad?uga?i o constrângere de tip not null ?i o constrângere de tip foreign
--key. (2.5p)

-- tabelul care trebuie facut
select cod_student, cnp ,NVL(c.nr_credite,0) 
from student s left join (select sum(nr_credite) nr_credite, cod_student
                          from curs join note n  using (cod_curs) 
                          where nota >= 5
                          group by n.cod_student
                         ) c using(cod_student);
                         
--creare tabel                         
create table credite_lp as (select cod_student, cnp ,NVL(c.nr_credite,0) "nr_credite" 
from student s left join (select sum(nr_credite) nr_credite, cod_student
                          from curs join note n  using (cod_curs) 
                          where nota >= 5
                          group by n.cod_student
                         ) c using(cod_student);

select * from credite_lp; -- verif

alter table credite_lp 
add constraint credite_studentfk_lp FOREIGN KEY(cod_student)

references student(cod_student)ON DELETE CASCADE;
alter table credite_lp
MODIFY cnp varchar2(13) NOT NULL;
