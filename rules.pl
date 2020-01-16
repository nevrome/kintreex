/* Rules */
father_of(X,Y):- male(X), first_degree(X,Y).
mother_of(X,Y):- female(X), first_degree(X,Y).

parent_of(X,Y):- father_of(X,Y).
parent_of(X,Y):- mother_of(X,Y).
parents_of(X,Y,Z):- mother_of(X,Z), father_of(Y,Z).

grandfather_of(X,Y):- male(X),
    parent_of(X,Z),
    parent_of(Z,Y).

grandmother_of(X,Y):- female(X),
    parent_of(X,Z),
    parent_of(Z,Y).

