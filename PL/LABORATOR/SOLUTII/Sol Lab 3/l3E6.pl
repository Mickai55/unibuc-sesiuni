
/* Animal  database */

animal(alligator). 
animal(tortue) .
animal(caribou).
animal(ours) .
animal(cheval) .
animal(vache) .
animal(lapin) .


mutation(X):- animal(Y),animal(Z),Y\==Z,
              name(Y,Ny),name(Z,Nz),
              append(Yl,Y2,Ny),Yl\==[],
			  append(Y2,_,Nz),Y2\==[],
			  append(Yl,Nz,LX),name(X,LX).