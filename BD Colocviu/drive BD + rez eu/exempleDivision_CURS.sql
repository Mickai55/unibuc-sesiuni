--Sã se obþinã codurile salariaþilor ataºaþi 
--tuturor proiectelor pentru care s-a alocat un buget
--mai mic decat 10000.

select * from projects
where budget <=10000;

select employee_id
from employees 
where employee_id in (
    select employee_id from works_on
    where project_id in (select project_id from projects
                            where budget <= 10000)  
);

select employee_id
from employees e 
where not exists
(   select employee_id from works_on
    where project_id in (select project_id from projects
                            where budget <= 10000)  
    and employee_id = e.employee_id                        
);





select * from works_on;

-- angajatii pentru care nu exista proiecte cu un buget mai mic decat 10000
-- la care nu a lucrat angajatul.


select distinct employee_id
from works_on w
where not exists ( /*proiecte cu un buget mai mic decat 10000
-- la care nu a lucrat angajatul
*/ 
        select 'x' from projects p
        where budget <=10000
        --la care angajatul nu a lucrat
        and not exists  ( select 'x' from works_on w1
                            where w1.employee_id = w.employee_id
                            and   w1.project_id = p.project_id)
);



SELECT employee_id, last_name, first_name
FROM employees
WHERE employee_id IN
    (SELECT w.employee_id
    FROM works_on w join projects p on (p.project_id = w.project_id)
    WHERE p.budget <= 10000
    GROUP BY w.employee_id
    having count(*) =
                (SELECT COUNT(*)
                FROM projects
                WHERE budget <=10000));


SELECT COUNT(*)
FROM projects
WHERE budget <=10000;

SELECT w.employee_id, count(*)
FROM works_on w join projects p on (p.project_id = w.project_id)
WHERE p.budget <= 10000
GROUP BY w.employee_id;


--L6 exe1
--Sã se listeze informaþii despre angajaþii care au lucrat 
--în toate proiectele demarate în primele 6 luni
--ale anului 2006. Implementaþi toate variantele.

select distinct employee_id
from works_on w
where not exists ( /*proiecte demarate in primele 6 luni
-- la care nu a lucrat angajatul
*/ 
        select 'x' from projects p
        where months_between(sysdate, start_date) <= 6 
        and not exists  ( select 'x' from works_on w1
                            where w1.employee_id = w.employee_id
                            and   w1.project_id = p.project_id)
);


--Pentru fiecare tara, sa se afiseze numarul de angajati din cadrul acesteia.

select c.country_id, count(e.employee_id)
from countries c left join regions r
       on (c.region_id = r.region_id) 
    left join locations l
     on (c.country_id = l.country_id)
    left join departments d
        on (l.location_id = d.location_id)
    left join employees e
     on (d.department_id = e.department_id)
group by c.country_id;


--Sa se obtina numele angajatilor care au lucrat
--cel putin pe aceleasi proiecte ca si angajatul
--având codul 200.

select project_id 
from works_on
where employee_id = 200;

select e.employee_id
from employees e
where employee_id <> 200
and not exists (
        select project_id 
        from works_on
        where employee_id = 200
        minus
        select project_id 
        from works_on
        where employee_id = e.employee_id
);



