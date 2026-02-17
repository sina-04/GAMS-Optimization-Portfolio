Sets
i Power Plants /P1, P2, P3/
j Cities /C1, C2, C3, C4/;

Table P(i, j)
        C1      C2      C3      C4
P1      08      06      10      09
P2      09      12      13      07
P3      14      09      16      05
;
Variable
OF Objective Function;
Positive Variable
x(i,j) Decision Variable;

Equations Obj,SC1,SC2,SC3,DC1,DC2,DC3,DC4;

Obj.. OF =e= sum((i,j),P(i,j)*x(i,j));

SC1.. sum(j,x('P1',j)) =l= 35;
SC2.. sum(j,x('P2',j)) =l= 50;
SC3.. sum(j,x('P3',j)) =l= 40;

DC1.. sum(i,x(i,'C1')) =g= 45;
DC2.. sum(i,x(i,'C2')) =g= 20;
DC3.. sum(i,x(i,'C3')) =g= 30;
DC4.. sum(i,x(i,'C4')) =g= 30;

Model S4Problem3 /all/;
solve S4Problem3 using LP minimizing OF;