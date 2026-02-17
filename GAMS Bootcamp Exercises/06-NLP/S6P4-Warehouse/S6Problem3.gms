* Set definition
Set
    i Customers /C1*C4/;

* Parameters definition
Parameters
    Sh(i) Number of Shipments from Warehouse to Each Customer /C1 200, C2 150, C3 200, C4 300/
    x(i)  x-coordinate of each customer /C1 5, C2 10, C3 0, C4 12/
    y(i)  y-coordinate of each customer /C1 10, C2 5, C3 12, C4 0/;

* Variables definition
Variable
    OF Objective Function;

Positive Variables
    D(i) Distance from Warehouse to Customers
    A    x-coordinate of the warehouse
    B    y-coordinate of the warehouse;

* Equations definition
Equations 
    Obj         Objective Function
    Distance(i) Distance Calculation for each Customer;

* Objective function - Minimize the weighted sum of distances
Obj .. 
    OF =e= sum(i, Sh(i) * D(i));

* Distance calculation equations
Distance(i) .. 
    D(i) =e= sqrt(sqr(A - x(i)) + sqr(B - y(i)));

* Model definition and solving
model S6Problem3 /all/;
solve S6Problem3 using NLP minimizing OF;