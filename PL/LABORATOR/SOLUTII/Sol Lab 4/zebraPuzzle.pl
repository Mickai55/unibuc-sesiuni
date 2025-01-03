la_dreapta(X,Y) :- X is Y + 1.

la_stanga(X,Y) :- la_dreapta(Y,X).

langa(X,Y) :- la_dreapta(X,Y) ; la_stanga(X,Y).

solutie(Strada,PosesorZebra) :- 
  Strada = [
      casa(1,_,_,_,_,_),
      casa(2,_,_,_,_,_),
      casa(3,_,_,_,_,_),
      casa(4,_,_,_,_,_),
      casa(5,_,_,_,_,_)],
    member(casa(_,englez,rosie,_,_,_), Strada),
    member(casa(_,spaniol,_,caine,_,_), Strada),
    member(casa(_,_,verde,_,cafea,_), Strada),
    member(casa(_,ucrainean,_,_,ceai,_), Strada),
    member(casa(A,_,verde,_,_,_), Strada),
    member(casa(B,_,bej,_,_,_), Strada),
    la_dreapta(B,A),
    member(casa(_,_,_,melci,_,'Old_Gold'), Strada),
    member(casa(_,_,galben,_,_,'Kools'), Strada),
    member(casa(3,_,_,_,lapte,_), Strada),
    member(casa(1,norvegian,_,_,_,_), Strada),
    member(casa(C,_,_,_,_,'Chesterfields'), Strada),
    member(casa(D,_,_,vulpe,_,_), Strada),
    langa(C,D),
    member(casa(E,_,_,_,_,'Kools'), Strada),
    member(casa(F,_,_,cal,_,_), Strada),
    langa(E,F),
    member(casa(_,japonez,_,_,_,'Parliaments'), Strada),
    member(casa(G,norvegian,_,_,_,_), Strada),
    member(casa(H,_,albastra,_,_,_), Strada),
    langa(G,H),
    member(casa(_,PosesorZebra,_,zebra,_,_), Strada).

