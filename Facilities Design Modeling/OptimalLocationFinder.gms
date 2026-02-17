* Set definition
Set
    i Places /P1*P4/;

* Parameters definition
Parameters
    w(i) weight for each place /P1 0.165, P2 0.330, P3 0.330, P4 0.165/
    x_coord(i) x-coordinate of each place /P1 4, P2 8, P3 11, P4 13/
    y_coord(i) y-coordinate of each place /P1 2, P2 5, P3 8, P4 2/;

* Variables definition
Positive Variables
    p(i) absolute x-distance between new device and place i
    q(i) absolute y-distance between new device and place i;

Variables
    x    x-coordinate of the new device
    y    y-coordinate of the new device
    OF   Objective Function;

* Equations definition
Equations
    Obj        Objective Function
    x_abs1(i)  First inequality for absolute x-distance
    x_abs2(i)  Second inequality for absolute x-distance
    y_abs1(i)  First inequality for absolute y-distance
    y_abs2(i)  Second inequality for absolute y-distance;

* Objective Function - Minimize the weighted sum of distances
Obj .. OF =e= sum(i, w(i) * (p(i) + q(i)));

* Equations defining the absolute distances along x
x_abs1(i).. p(i) =g= x - x_coord(i);
x_abs2(i).. p(i) =g= x_coord(i) - x;

* Equations defining the absolute distances along y
y_abs1(i).. q(i) =g= y - y_coord(i);
y_abs2(i).. q(i) =g= y_coord(i) - y;

* Model definition and solving
Model OptimalLocationFinder /all/;
Solve OptimalLocationFinder using LP minimizing OF;

* Display results
Display x.l, y.l, OF.l;