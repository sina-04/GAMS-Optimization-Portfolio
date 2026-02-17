Sets
i Plants /PL1,PL2/
j Seat Types /Type1*Type3/;

Table S(i,j)
      Type1   Type2   Type3
PL1     20      30      40
PL2     50      35      45;

Parameters
PC(i) Production Cost /PL1 1000,PL2 2000/
Sa(i) Salary          /PL1 400,PL2 600/;

Variable
OF Objective Function;
Integer Variable
x(i) Number of Workers Employed in Line i;
Binary Variable
y(i) If Line i is used;

Equations Obj,Const1,Const2,Const3,Const4;

Obj .. OF =e= sum(i,PC(i)*y(i))+sum(i,Sa(i)*x(i));

Const1(j) .. sum(i,S(i,'Type1')*x(i)) =g= 120;
Const2(j) .. sum(i,S(i,'Type2')*x(i)) =g= 150;
Const3(j) .. sum(i,S(i,'Type3')*x(i)) =g= 200;
Const4(i) .. x(i) =l= 30*y(i);

model S5Problem2 /all/;
Solve S5Problem2 using MIP minimize OF;