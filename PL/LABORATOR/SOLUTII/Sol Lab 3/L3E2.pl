% A simple database

born(jan, date(20,3,1977)).
born(jeroen, date(2,2,1992)).
born(joris, date(17,3,1995)).
born(jelle, date(1,1,2004)).
born(joan, date(24,12,0)).
born(joop, date(30,4,1989)).
born(jannecke, date(17,3,1993)).
born(jaap, date(16,11,1995)).

year(Year,Person) :- born(Person,date(_,_,Year)).

before(date(Day1,Month1,Year1), date(Day2, Month2, Year2)) :-
        Year1 < Year2 ;
        Year1 =:= Year2, Month1 < Month2 ;
        Year1 =:= Year2, Month1 =:= Month2, Day1 < Day2 .

older(X,Y) :- 
        born(X,Date1), 
        born(Y,Date2), 
        before(Date1,Date2).

/** examples

?- year(1995, Person).
?- before(date(31,1,1990), date(7,7,1990)).
?- older(jannecke, X).
*/