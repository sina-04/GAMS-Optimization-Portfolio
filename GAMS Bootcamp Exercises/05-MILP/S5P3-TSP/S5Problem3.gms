Sets
i Cities /City1*City5/
alias(i,j);

Set
offtour(i,j);

* Initialize the offtour set: it excludes self-loops and trips from/to 'City1'
offtour(i,j) = yes;
offtour(i,i) = no;
offtour(i,'City1') = no;
offtour('City1',j) = no;

Table C(i,j)
        City1    City2   City3   City4   City5
City1    1000     132     217     164     58
City2    132      1000    290     201     79
City3    217      290     1000    113     303
City4    164      201     113     1000    196
City5    58       79      303     196     1000;

Scalar
N Number of Cities;
N = card(i);

Variable
OF Objective Function;

Positive Variable
u(i) Auxiliary;

Binary Variable
x(i,j) Decision Variable;

Equations Obj,Const1,Const2,Const3;

* Objective function: Minimize the total travel distance
Obj .. OF =e= sum((i,j), C(i,j)*x(i,j));

* Ensure each city is entered exactly once
Const1(j) .. sum(i,x(i,j)) =e= 1;

* Ensure each city is exited exactly once
Const2(i) .. sum(j,x(i,j)) =e= 1;

* Subtour elimination constraints for off-tour city pairs
Const3(offtour(i,j)).. u(i) - u(j) + N*x(i,j) =l= N-1;

model S5Problem3 /all/;
Solve S5Problem3 using MIP minimizing OF;

Display x.l, OF.l;