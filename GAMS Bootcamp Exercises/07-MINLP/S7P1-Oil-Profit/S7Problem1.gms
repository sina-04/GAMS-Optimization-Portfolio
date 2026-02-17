

Variable
OF Objective Function

Integer Variables

x1 Millions of barrels of oil extracted during year1
x2 Millions of barrels of oil extracted during year2

Equations Obj,Const1,Const2;

Obj .. OF =e= 30*x1+35*x2-2*(x1**2)-3*(x2**2);

Const1 .. x1+x2 =l= 20;

Const2 .. (x1**2)+2*(x2**2) =l= 250;

model S7Problem1 /all/;

solve S7Problem1 using MINLP maximizing OF;

