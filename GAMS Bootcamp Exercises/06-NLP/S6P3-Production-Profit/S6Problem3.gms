Set

i Customers /C1*C4/;

Parameters

Sh(i) Number of Shipments from Warehouse to Each Customer /C1 200
                                                           C2 150
                                                           C3 200
                                                           C4 300/

x(i) x-coordinate of each customer /C1 5
                                    C2 10
                                    C3 0
                                    C4 12/

y(i) y-coordinate of each customer /C1 10
                                    C2 5
                                    C3 12
                                    C4 0/;

Variable
OF Objective Function;

Positive Variables

D(i) Distance from Warehouse to Customers
A    x coordinate of the warehouse
B    y coordinate of the warehouse;

Equations Obj,Const1,Const2,Const3,Const4;

Obj .. OF =e= sum(i,Sh(i)*D(i));

Const1 .. D('C1') =e= sqrt(power(A-x('C1'),2)+power(B-y('C1'),2));

Const2 .. D('C2') =e= sqrt(power(A-x('C2'),2)+power(B-y('C2'),2));

Const3 .. D('C3') =e= sqrt(power(A-x('C3'),2)+power(B-y('C3'),2));

Const4 .. D('C4') =e= sqrt(power(A-x('C4'),2)+power(B-y('C4'),2));


model S6Problem3 /all/;

solve S6Problem3 using NLP minimizing OF;

display OF.l, A.l,B.l;