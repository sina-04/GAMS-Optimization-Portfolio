* Define Set or Sets
Set
i Product Type /'Desk','TBL','Chair'/;

* Define Parameters (What is this constraint about?)
Parameters
L Lumber(ft) /'Desk' 8,'TBL' 6,'Chair' 1/
F Finishing Hours /'Desk' 4,'TBL' 2,'Chair' 1.5/
C Carpentary Hours /'Desk' 2,'TBL' 1.5,'Chair' 0.5/
P Price of Selling /'Desk' 60,'TBL' 30,'Chair' 20/;

* Define Decision Variables
Variable
OF Objective Function;
Positive Variable
x(i) Decision Variable;

* Define Equations for Objective Function and Constraints
Equations Obj,Const1,Const2,Const3,Const4;
Obj.. OF =e= sum(i,P(i)*x(i));
Const1.. sum(i,L(i)*x(i)) =l= 48;
Const2.. sum(i,F(i)*x(i)) =l= 20;
Const3.. sum(i,C(i)*x(i)) =l= 8;
Const4.. x('TBL') =l= 5;

* Solving Stage
model S4Problem2 /all/;
Solve S4Problem2 using LP maximizing OF;