# kintreex

Data source: https://en.wikipedia.org/wiki/Template:War_of_the_Spanish_Succession_family_tree

start prolog interpreter

```
swipl -s pedigree.pl
```

ask questions

```
father_of(X, anne).
mother_of(X, anne).
```

only distinct solutions: `distinct(sister_of(X,philipiv)).`
show all solutions: `findall(X,distinct(sister_of(X,philipiv)),L).`

quit

```
halt.
```

