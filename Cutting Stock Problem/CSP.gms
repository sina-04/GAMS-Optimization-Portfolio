Set
    i  'decision–variable index' /1*19/
    j  'constraint index'        /c1*c5/ ;

* Objective-function coefficients
Parameter c(i) /
 1  10
 3   5
 4  10
 5  10
 7   5
 8  10
10   5
11  10
13   5
14  10
16   5
17  10
19   5 / ;

* Constraint matrix a(j,i)
Table a(j,i)
          1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19
c1        3  2  2  2  1  1  1  1                    1  1
c2           2  1     3  2  1     5  4  3  2  1     1     2  1
c3              1  2     2  3  4     1  2  4  5  6     1     2  3
c4        1  1  1  1  1  1  1  1  1  1  1  1  1  1
c5                                                  1  1  1  1  1  ;

* Right-hand-side values
Parameter rhs(j) / c1 65, c2 80, c3 100, c4 150, c5 100 / ;

* decision variables (x1 … x19)
Positive Variable x(i) ;
* objective (cost)
Variable          z   ;

Equation
    obj        'objective function'
    gcon(j)    '≥-type constraints (c1 – c3)'
    lcon(j)    '≤-type constraints (c4 – c5)' ;

obj..  z =e= sum(i, c(i)*x(i)) ;

gcon(j)$(ord(j) <= 3)..  sum(i, a(j,i)*x(i)) =g= rhs(j) ;
lcon(j)$(ord(j)  > 3)..  sum(i, a(j,i)*x(i)) =l= rhs(j) ;

Model lpModel /all/ ;
Solve lpModel using lp minimizing z ;
Display z.l, x.l ;