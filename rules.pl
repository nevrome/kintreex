/* Rules */

% parents
father_of(F,Y):- male(F), first_degree(F,Y).
mother_of(M,Y):- female(M), first_degree(M,Y).

parent_of(P,Y):- father_of(P,Y).
parent_of(P,Y):- mother_of(P,Y).

parents_of(M,F,Z):- mother_of(M,Z), father_of(F,Z).

% siblings
brother_of(B,Y):- 
    male(B), 
    first_degree(B,Y),
    parent_of(P,B), parent_of(P,Y), B \= Y, P \= B.

sister_of(S,Y):- 
    female(S), 
    first_degree(S,Y),
    parent_of(P,S), parent_of(P,Y), S \= Y, P \= S.

sibling_of(Sib,Y):- brother_of(Sib, Y).
sibling_of(Sib,Y):- sister_of(Sib, Y).

% grandparents
grandfather_of(Gf,Y):- 
    male(Gf),
    second_degree(Gf,Y),
    father_of(Gf,P), parent_of(P,Y), Gf \= P.
grandmother_of(Gm,Y):- 
    female(Gm),
    second_degree(Gm,Y),
    mother_of(Gm,P), parent_of(P,Y), Gm \= P.

grandparent_of(X,Y):- grandfather_of(X,Y).
grandparent_of(X,Y):- grandmother_of(X,Y).

grandparents_of(X,Y,Z):- grandmother_of(X,Z), grandfather_of(Y,Z).

% uncles and aunts
uncle_of(U, Y):- 
    male(U), 
    second_degree(U, Y),
    parent_of(P,Y), sibling_of(P,U), 
    grandparent_of(G,Y), parent_of(G,U).

aunt_of(A, Y):- 
    female(A), 
    second_degree(A, Y), 
    parent_of(P,Y), sibling_of(P,A),
    grandparent_of(G,Y), parent_of(G,A).


