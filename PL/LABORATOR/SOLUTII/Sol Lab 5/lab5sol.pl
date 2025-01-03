%% inspirat de https://www.cpp.edu/~jrfisher/www/prolog_tutorial/2_13.html


:- op(630, xfy, sau).      
:- op(620, xfy, si).        
:- op(610, fy,  nu). 
:- op(640, xfy, imp). 


%% write vs display pentru a verifica precedenta

%% is_var(X) :- member(X,[a,b,c,d,e]).

is_var(a). is_var(b). is_var(c). is_var(d). is_var(e).





formula(X) :- is_var(X).
formula(nu X) :- formula(X).
formula(sau(X,Y)) :- formula(X), formula(Y).
formula(si(X,Y)) :- formula(X), formula(Y).
formula(imp(X,Y)) :- formula(X), formula(Y).

test :- catch(read(X), Error, false),X.

%% se executa cu 
%% ?- test.
%% :- formula (....).
%% va raspunde true sau false



%%  find_vars(N,V,V) :- is_var(N).   noi nu avem  0 si 1
%% in Vin suny variabilele care au fost deja gasite
 
%% se apeleaza cu find_vars(X,[],V).

find_vars(X,Vin,Vout) :- is_var(X), 
                         (member(X,Vin) -> Vout = Vin ;   
                            Vout = [X|Vin]).             
find_vars(X si Y,Vin,Vout) :- find_vars(X,Vin,Vtemp),
                               find_vars(Y,Vtemp,Vout).
find_vars(X sau Y,Vin,Vout) :-  find_vars(X,Vin,Vtemp),
                               find_vars(Y,Vtemp,Vout).
find_vars(X imp Y,Vin,Vout) :-  find_vars(X,Vin,Vtemp),
                               find_vars(Y,Vtemp,Vout).
find_vars(nu X,Vin,Vout) :-   find_vars(X,Vin,Vout).



ins0([],[]).
ins0([X|L], [[0|X]|L1]):-ins0(L,L1).
ins1([],[]).
ins1([X|L], [[1|X]|L1]):-ins1(L,L1).
all_assigns(0,[[]]).
all_assigns(N,V):- M is (N-1), all_assigns(M, V1), ins0(V1,L1), ins1(V1,L2), append(L1,L2,V).

 boole_not(0,1).
 boole_not(1,0).

boole_and(0,0,0).      
boole_and(0,1,0).          
boole_and(1,0,0).      
boole_and(1,1,1). 
  
boole_or(0,0,0).     
 boole_or(1,1,1).
   boole_or(0,1,1).
 boole_or(1,0,1).
 
 boole_to(0,0,1).      
boole_to(0,1,1).          
boole_to(1,0,0).      
boole_to(1,1,1). 

% truth_value(formula, lista var, atribuire, valoare)

truth_value(X,Vars,A,Val) :- is_var(X),
                             lookup(X,Vars,A,Val).
truth_value(X si Y,Vars,A,Val) :- truth_value(X,Vars,A,VX),
                                   truth_value(Y,Vars,A,VY),
                                   boole_and(VX,VY,Val).
truth_value(X sau Y,Vars,A,Val) :-  truth_value(X,Vars,A,VX),
                                   truth_value(Y,Vars,A,VY),
                                   boole_or(VX,VY,Val).
truth_value(X imp Y,Vars,A,Val) :-  truth_value(X,Vars,A,VX),
                                   truth_value(Y,Vars,A,VY),
                                   boole_to(VX,VY,Val).
truth_value(nu X,Vars,A,Val) :-   truth_value(X,Vars,A,VX),
                                   boole_not(VX,Val).
                                   
lookup(X,[X|_],[V|_],V).
lookup(X,[_|Vars],[_|A],V) :- lookup(X,Vars,A,V).

%% all_values(formula, lista variabilelor, lista de atribuiri, lista valorilor obtinute pentru fiecare atribuire)

all_values(X,Vars,[],[]). 
all_values(X,Vars,[A|L],[VX|VL]):- truth_value(X,Vars,A,VX), all_values(X,Vars,L,VL).

values_all_assigns(X,T):-find_vars(X,[],Lvar), length(Lvar,N), all_assigns(N, LA), all_values(X,Lvar, LA, T).



taut([],1).
taut([B|L],R) :- taut(L,R1), boole_and(B,R1,R). 


is_taut(X):- values_all_assigns(X,T), taut(T,R), ((R == 1) -> write('este tautologie');write('nu este tautologie')).

%% definitie in care is_taut intoarce true sau false (folosesc !)
% taut([]).
% taut([0|L]):- !,false.
% is_taut(X):- values_all_assigns(X,T), taut(T).









