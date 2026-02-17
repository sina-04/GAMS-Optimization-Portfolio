* Objective Function Variable
Variable
* Objective Function
OF;

* Positive Variables
Positive Variables
* Coordinates of Warehouse
xw, yw,
* Distances to Customers    
D1, D2, D3, D4;

* Scalar to define the coordinates of customers
Scalar
x1 /5/, y1 /10/,
x2 /10/, y2 /5/,
x3 /0/, y3 /12/,
x4 /12/, y4 /0/;

* Equations for objective and constraints
Equations
    Obj, CalcD1, CalcD2, CalcD3, CalcD4;

* Define the distances from the warehouse to each customer
CalcD1 .. D1 =e= (sqrt(power(x1 - xw,2) + power(y1 - yw,2)))*200;
CalcD2 .. D2 =e= (sqrt(power(x2 - xw,2) + power(y2 - yw,2)))*150;
CalcD3 .. D3 =e= (sqrt(power(x3 - xw,2) + power(y3 - yw,2)))*200;
CalcD4 .. D4 =e= (sqrt(power(x4 - xw,2) + power(y4 - yw,2)))*300;

* Objective Function - Minimize the sum of squared distances
Obj .. OF =e= D1 + D2 + D3 + D4;

* Model Definition
Model S6Problem3_2 /all/;
* Solve the model using Non-Linear Programming (NLP) to minimize the objective function
Solve S6Problem3_2 using NLP minimizing OF;