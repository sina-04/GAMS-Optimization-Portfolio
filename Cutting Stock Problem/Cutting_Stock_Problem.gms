SET i / 1*19 /;

SET iCost(i) / 1,3,4,5,7,8,10,11,13,14,16,17,19 /;

PARAMETER cVal(iCost);

cVal('1')  = 10;
cVal('3')  =  5;
cVal('4')  = 10;
cVal('5')  = 10;
cVal('7')  =  5;
cVal('8')  = 10;
cVal('10') =  5;
cVal('11') = 10;
cVal('13') =  5;
cVal('14') = 10;
cVal('16') =  5;
cVal('17') = 10;
cVal('19') =  5;

PARAMETER c(i);

c(i) = 0;

LOOP(iCost,
    c(iCost) = cVal(iCost);
);

VARIABLES
   x(i)   * Our 19 decision variables
   Z      * Objective value (to be minimized);

POSITIVE VARIABLE x(i);

EQUATION obj;
obj.. Z =e= SUM(i, c(i)*x(i));

EQUATION 
   eq1, eq2, eq3, eq4, eq5;

eq1..
   3*x('1') + 2*x('2') + 2*x('3') + 2*x('4') + x('5') + x('6') + x('7') + x('8')
   + x('15') + x('16') =g= 65;

eq2..
   2*x('2') + x('3') + 2*x('5') + 2*x('6') + x('7') + 5*x('9') + 4*x('10')
   + 3*x('11') + 2*x('12') + x('13') + x('15') + 2*x('17') + x('18') =g= 80;

eq3..
   x('3') + 2*x('4') + 2*x('6') + 3*x('7') + x('8') + x('10') 
   + 2*x('11') + 4*x('12') + 5*x('13') + 6*x('14') + x('16')
   + 2*x('18') + 3*x('19') =g= 100;

eq4..
   x('1') + x('2') + x('3') + x('4') + x('5') + x('6') + x('7') + x('8')
   + x('9') + x('10') + x('11') + x('12') + x('13') + x('14') =l= 150;

eq5..
   x('15') + x('16') + x('17') + x('18') + x('19') =l= 100;

MODEL CSP / obj, eq1, eq2, eq3, eq4, eq5 /;
SOLVE CSP USING LP MINIMIZING Z;

DISPLAY x.l, Z.l;