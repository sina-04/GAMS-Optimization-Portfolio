Variable
OF Objective Function;

Positive Variables
A cm vertical side
B cm horizontal side

X1,Y1,X2,Y2,X3,Y3 Coordinates of Circles;

Equations Obj,Const1,Const2,Const3,Const4,Const5,Const6,Const7,Const8,Const9,
Const10,Const11,Const12,Const13,Const14,Const15;

Obj .. OF =e= 2*(A+B);

Const1 .. X1 =g= 6;
Const2 .. Y1 =g= 6;
Const3 .. X2 =g= 12;
Const4 .. Y2 =g= 12;
Const5 .. X3 =g= 16;
Const6 .. Y3 =g= 16;
Const7 .. X1-B+6 =l= 0;
Const8 .. Y1-A+6 =l= 0;
Const9 .. X2-B+12 =l= 0;
Const10 .. Y2-A+12 =l= 0;
Const11 .. X3-B+16 =l= 0;
Const12 .. Y3-A+16 =l= 0;
Const13 .. power(X1-X2,2)+power(Y1-Y2,2) =g= 324;
Const14 .. power(X1-X3,2)+power(Y1-Y3,2) =g= 484;
Const15 .. power(X2-X3,2)+power(Y2-Y3,2) =g= 784;

model S6Problem2 /all/;
solve S6Problem2 using NLP minimizing OF;