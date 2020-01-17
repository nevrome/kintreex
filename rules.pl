/* Rules */

all_relations(F,M,B,S,So,Da,Gf,Gm,U,A,Y):-
    %% first degree %%
    % male
    (father_of(F,Y), F \== B, F \== So;
     brother_of(B,Y), B \== F, B \== So;
     son_of(So,Y), So \== F, So \== B;
     false),
    % female
    (mother_of(M,Y), M \== B, M \== Da;
     sister_of(S,Y), S \== F, S \== Da;
     daughter_of(Da,Y), Da \== M, Da \== S;
     false),
    %% second degree %%
    % male
    (grandfather_of(Gf,Y), Gf \== U;
     uncle_of(U,Y), U \== Gf;
     % nephew
     % halfbrother
     % grandson
     false),
    % female
    (grandmother_of(Gm,Y), Gm \== A;
     aunt_of(U,Y), A \== Gm;
     % niece
     % halfsister
     % granddaughter
     false).

% parents
father_of(F,Y):- male(F), first_degree(F,Y).
mother_of(M,Y):- female(M), first_degree(M,Y).

parent_of(P,Y):- father_of(P,Y).
parent_of(P,Y):- mother_of(P,Y).

parents_of(F,M,Y):- father_of(F,Y), mother_of(M,Y).

% children
child_of(Y,P):- parent_of(P,Y).
child_of(Y,F,M):- parents_of(F,M,Y).
son_of(Y,P):- male(Y), child_of(Y,P).
daughter_of(Y,P):- female(Y), child_of(Y,P).

% siblings
brother_of(B,Y):- 
    male(B), 
    first_degree(B,Y),
    parents_of(F,M,B), parents_of(F,M,Y), F \= B.

sister_of(S,Y):- 
    female(S), 
    first_degree(S,Y),
    parents_of(F,M,S), parents_of(F,M,Y), M \= S.

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

% nephews and nieces
nephew_of(Ne, Y):- 
    male(Ne), 
    second_degree(Ne,Y),
    parent_of(P,Ne), sibling_of(P,Y).

niece_of(Ni, Y):- 
    female(Ni), 
    second_degree(Ni,Y),
    parent_of(P,Ni), sibling_of(P,Y).

% half siblings
halfbrother_of(Hb,Y):- 
    male(Hb), 
    second_degree(Hb,Y),
    parent_of(P,Hb), parent_of(P,Y).

halfsister_of(Hs,Y):- 
    female(Hs), 
    second_degree(Hs,Y),
    parent_of(P,Hs), parent_of(P,Y).

halfsibling_of(Hsib,Y):- halfbrother_of(Hsib, Y).
halfsibling_of(Hsib,Y):- halfsister_of(Hsib, Y).



