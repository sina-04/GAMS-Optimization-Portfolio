* Objective function variable: Represents the perimeter of the box to be minimized
Variable
OF;

* Decision variables: Width and Length of the box
Positive Variables
W  * Width of the Box
L  * Length of the Box;

* Parameters: Radii of the three circles
Parameters
R1 Radius of Circle 1 /6/
R2 Radius of Circle 2 /12/
R3 Radius of Circle 3 /16/

* Decision variables: Coordinates of the centers of the circles
Positive Variables
x1, y1  *Coordinates of the center of Circle 1
x2, y2  *Coordinates of the center of Circle 2
x3, y3  *Coordinates of the center of Circle 3;

* Equations to define the objective function and constraints
Equations
* Objective function equation
Obj,
* Horizontal fitting constraints
Fit1a, Fit2a, Fit3a,
* Vertical fitting constraints
Fit1b, Fit2b, Fit3b,
* Non-overlapping constraints between circles
NoOverlap12, NoOverlap13, NoOverlap23;

* Objective function: Minimize the perimeter of the box
Obj.. OF =e= 2 * (W + L);

* Horizontal fitting constraints: Ensure each circle fits within the width of the box
Fit1a.. x1 + R1 =l= W;
Fit2a.. x2 + R2 =l= W;
Fit3a.. x3 + R3 =l= W;

* Vertical fitting constraints: Ensure each circle fits within the length of the box
Fit1b.. y1 + R1 =l= L;
Fit2b.. y2 + R2 =l= L;
Fit3b.. y3 + R3 =l= L;

* Non-overlapping constraints between the circles
NoOverlap12.. (x1 - x2)**2 + (y1 - y2)**2 =g= (R1 + R2)**2;
NoOverlap13.. (x1 - x3)**2 + (y1 - y3)**2 =g= (R1 + R3)**2;
NoOverlap23.. (x2 - x3)**2 + (y2 - y3)**2 =g= (R2 + R3)**2;

* Define the model and specify it to use NLP solver
Model S6Problem2 /all/;
Solve S6Problem2 using NLP minimizing OF;