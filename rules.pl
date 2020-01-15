/* Rules */
father_of(X,Y):- male(X), first_degree(X,Y).

mother_of(X,Y):- female(X), first_degree(X,Y).

