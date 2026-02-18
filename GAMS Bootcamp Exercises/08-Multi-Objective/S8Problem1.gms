Sets
i /1,2/;

Variables
F1 1st Objective
F2 2nd Objective
F3 3rd Objective

Positive Variables

x(i)
dp1,dm1
dp2,dm2
dp3,dm3;

Equations goal1,goal2,goal3,Const1,Const2,Const3,Const4,Const5;

goal1 .. F1 =e= dp1;
goal2 .. F2 =e= dp2;
goal3 .. F3 =e= dm3;

Const1 .. 4*x('1')+2*x('2')+dp1-dm1 =e= 120;

Const2 .. 1.5*x('1')+8*x('2')+dp2-dm2 =e= 50;

Const3 .. 0.5*x('1')+5*x('2')+dp3-dm3 =e= 80;

Const4 .. 2*x('1')+5*x('2') =l= 80;

Const5 .. 8*x('1')+3*x('2') =g= 35;


model Stage1 /goal1,Const1,Const4,Const5/;
solve Stage1 using LP minimizing F1;

Equation FGoal;
FGoal .. dp1 =l= F1.l;

model Stage2 /goal2,Const1,Const4,Const5,Const2,FGoal/;
solve Stage2 using LP minimizing F2;

Equation SGoal;
SGoal .. dp2 =l= F2.l;

model Stage3 /goal3,Const1,Const4,Const5,Const2,FGoal,Const3,SGoal/;
solve Stage3 using LP minimizing F3;

Display
F1.l
F2.l
F3.l
x.l;