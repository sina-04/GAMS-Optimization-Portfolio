* Define Sets
Set
i /Shirts, Shorts, Pants/;

* Define Parameters
Parameters
Price(i)    Price per item /Shirts 12, Shorts 08, Pants 15/
VC(i)       Variable Cost per item /Shirts 06, Shorts 04, Pants 08/
FC(i)       Fixed Cost per item /Shirts 200, Shorts 150, Pants 100/
Labor(i)    Labor hours required per item /Shirts 03, Shorts 02, Pants 06/
Cloth(i)    Cloth required per item /Shirts 04, Shorts 03, Pants 04/
BigM(i)     Big M value for constraints /Shirts 40, Shorts 53, Pants 40/;

* Define Decision Variables
Positive Variable
x(i) Quantity of items produced;
Binary Variable
y(i) Binary decision variable indicating if an item is produced;

* Define Objective Function and Constraints
Variable OF Objective Function;

Equations
Obj         Objective Function,
LaborCons   Labor constraint,
ClothCons   Cloth constraint,
BigMCons(i) Big M constraint;

* Objective Function - Maximize profit by considering revenue, variable costs, and fixed costs
Obj.. OF =e= sum(i, (Price(i) * x(i)) - (VC(i) * x(i)) - (FC(i) * y(i)));

* Labor Constraint - Total labor usage must not exceed available labor hours
LaborCons.. sum(i, Labor(i) * x(i)) =l= 150;

* Cloth Constraint - Total cloth usage must not exceed available cloth
ClothCons.. sum(i, Cloth(i) * x(i)) =l= 160;

* Big M Constraint - Ensure production quantities are only positive if production is chosen
BigMCons(i).. x(i) =l= y(i) * BigM(i);

Model S5Problem1 /all/;
Solve S5Problem1 using MIP maximizing OF;