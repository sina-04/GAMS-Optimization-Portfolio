* Define Sets
Set
i /Shirts, Shorts, Pants/;

* Define a Table for Parameters
Table ProductData(i, *)
          Price   VC   FC   Labor   Cloth   BigM
Shirts     12     06   200    03     04     40
Shorts     08     04   150    02     03     53
Pants      15     08   100    06     04     40;

Variable
OF;
Positive Variable
x(i);
Binary Variable
y(i);

Equations Obj,Labor,Cloth,BigMCons(i);

Obj.. OF =e= sum(i, (ProductData(i, 'Price') * x(i)) - (ProductData(i, 'VC') * x(i)) - (ProductData(i, 'FC') * y(i)));

Labor.. sum(i, ProductData(i, 'Labor') * x(i)) =l= 150;
Cloth.. sum(i, ProductData(i, 'Cloth') * x(i)) =l= 160;
BigMCons(i).. x(i) =l= y(i) * ProductData(i, 'BigM');

Model S5Problem1_2 /all/;
solve S5Problem1_2 using MIP maximizing OF;