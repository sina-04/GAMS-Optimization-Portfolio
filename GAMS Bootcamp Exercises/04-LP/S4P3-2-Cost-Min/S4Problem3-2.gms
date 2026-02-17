* Define Sets
Sets
i Power Plants /'P1', 'P2', 'P3'/
j Cities /'C1', 'C2', 'C3', 'C4'/;

* Define Parameters 
Parameters
P(i,j) Prices of Generating and Sending Electricity 
/ 'P1'.'C1' 08, 'P1'.'C2' 06, 'P1'.'C3' 10, 'P1'.'C4' 09,
  'P2'.'C1' 09, 'P2'.'C2' 12, 'P2'.'C3' 13, 'P2'.'C4' 07,
  'P3'.'C1' 14, 'P3'.'C2' 09, 'P3'.'C3' 16, 'P3'.'C4' 05 /;

* Define Decision Variables
Variable
OF Objective Function;
Positive Variable
x(i,j) Amount of Electricity Sent from Power Plant i to City j;

* Define Equations
Equations Obj,SC1,SC2,SC3,DC1,DC2,DC3,DC4;

* Objective Function - Minimize the total cost of electricity generation and transportation
Obj.. OF =e= sum((i,j), P(i,j) * x(i,j));

* Supply Constraints - Each power plant has a supply limit
SC1.. sum(j, x('P1',j)) =l= 35;
SC2.. sum(j, x('P2',j)) =l= 50;
SC3.. sum(j, x('P3',j)) =l= 40;

* Demand Constraints - Each city has a minimum demand requirement
DC1.. sum(i, x(i,'C1')) =g= 45;
DC2.. sum(i, x(i,'C2')) =g= 20;
DC3.. sum(i, x(i,'C3')) =g= 30;
DC4.. sum(i, x(i,'C4')) =g= 30;

* Define and Solve the Model
Model S4Problem3_2 /all/;
Solve S4Problem3_2 using LP minimizing OF;