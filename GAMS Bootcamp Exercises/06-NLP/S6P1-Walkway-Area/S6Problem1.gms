Variable
OF Objective Function;

Positive Variables
x1 Outer Width
x2 Outer Length;

Equations Obj,Const1,Const2;

* Objective function: Maximize the area minus 180
Obj .. OF =e= x1 * x2 - 180;

* Constraint 1: Relates x1 and x2
Const1 .. 0.5 * x1 - 0.5 * x2 =l= -4;

* Constraint 2: Perimeter constraint
Const2 .. 2 * x1 + 2 * x2 =l= 194;

Model S6Problem1 /all/;
Solve S6Problem1 using NLP maximizing OF;