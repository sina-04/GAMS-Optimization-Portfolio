* Define Decision Variables
Variable
OF Objective Function;
Positive Variables
x1 Number of deluxe belts
x2 Number of regulr belts;

* Define Equations for Objective Function and Constraints
Equations Objective,Const1,Const2;
Objective.. OF =e= 4*x1+3*x2;
Const1.. x1+x2 =l= 40;
Const2.. 2*x1+x2 =l= 60;

* Solving Stage
model S4Problem1 /all/;
Solve S4Problem1 using LP maximizing OF;