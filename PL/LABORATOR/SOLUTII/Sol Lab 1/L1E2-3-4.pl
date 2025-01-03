%---------------------------------
% Jon Snow and Daenerys Targaryen
%---------------------------------

male(rickardStark).
male(eddardStark).
male(brandonStark).
male(benjenStark).
male(robbStark).
male(branStark).
male(rickonStark).
male(jonSnow).
male(aerysTargaryen).
male(rhaegarTargaryen).
male(viserysTargaryen).
male(aegonTargaryen).

%---------------------------

female(lyarraStark).
female(catelynStark).
female(lyannaStark).
female(sansaStark).
female(aryaStark).
female(rhaellaTargaryen).
female(eliaTargaryen).
female(daenerysTargaryen).
female(rhaenysTargaryen).

%---------------------------

parent_of(rickardStark,eddardStark).
parent_of(rickardStark,brandonStark).
parent_of(rickardStark,benjenStark).
parent_of(rickardStark,lyannaStark).
parent_of(lyarraStark,eddardStark).
parent_of(lyarraStark,brandonStark).
parent_of(lyarraStark,benjenStark).
parent_of(lyarraStark,lyannaStark).

parent_of(eddardStark,robbStark).
parent_of(eddardStark,sansaStark).
parent_of(eddardStark,aryaStark).
parent_of(eddardStark,branStark).
parent_of(eddardStark,rickonStark).
parent_of(catelynStark,robbStark).
parent_of(catelynStark,sansaStark).
parent_of(catelynStark,aryaStark).
parent_of(catelynStark,branStark).
parent_of(catelynStark,rickonStark).

parent_of(aerysTargaryen,rhaegarTargaryen).
parent_of(aerysTargaryen,viserysTargaryen).
parent_of(aerysTargaryen,daenerysTargaryen).

parent_of(rhaellaTargaryen,rhaegarTargaryen).
parent_of(rhaellaTargaryen,viserysTargaryen).
parent_of(rhaellaTargaryen,daenerysTargaryen).

parent_of(rhaegarTargaryen,jonSnow).
parent_of(lyannaStark,jonSnow).

parent_of(rhaegarTargaryen,aegonTargaryen).
parent_of(rhaegarTargaryen,rhaenysTargaryen).

parent_of(eliaTargaryen,aegonTargaryen).
parent_of(eliaTargaryen,rhaenysTargaryen).

%---------------------------
father_of(X,Y) :- male(X),
                  parent_of(X,Y).

mother_of(X,Y) :- female(X),
                  parent_of(X,Y).

grandfather_of(X,Y) :- father_of(X,Z),
                       parent(Z,Y).

grandmother_of(X,Y) :- mother_of(X,Z),
                       parent(Z,Y).

sister_of(X,Y) :- female(X), 
                  parent_of(Z,X),
                  parent_of(Z,Y),X\==Y.

brother_of(X,Y) :- male(X),
                   parent_of(Z,X),
                   parent_of(Z,Y),X\==Y.

aunt_of(X,Y) :- sister_of(X,Z),
                parent_of(Z,Y).

uncle_of(X,Y) :- brother_of(X,Z),
                 parent_of(Z,Y).

ancestor_of(X,Y) :- parent_of(X,Y).              
ancestor_of(X,Y) :- parent_of(X,Z), ancestor_of(Z,Y).   

%raspunde false pentru variabile instantiate, dar nu forteaza instantierea
%not_parent(X,Y) :-  \+ parent_of(X,Y).

%forteza instantierea

not_parent(X,Y) :- (male(X);female(X)), (male(Y);female(Y)), \+ parent_of(X,Y).              

ancestor_not_parent(X,Y) :- ancestor_of(X,Y),\+(parent_of(X,Y)).

/** examples

?- sister_of(sansaStark,rickonStark).
?- brother_of(aryaStark,branStark).
?- sister_of(aryaStark,branStark).
?- aunt_of(daenerysTargaryen,jonSnow).
?- aunt_of(X,Y). 
*/
