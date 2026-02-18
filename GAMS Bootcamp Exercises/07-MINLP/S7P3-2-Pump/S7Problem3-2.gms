Sets
i Rows (Pump Types) /P1*P3/
j Columns (Fixed and Variable Costs + Coefficients) /Co,Cp,Alpha,Beta,Gamma,a,b,c,Pmax/;

Parameter C(i,j)
$call GDXXRW S7P3_Data.xlsx trace=3 par=C rng=Sheet1!A1:J4 rdim=1 cdim=1
$gdxIn S7P3_Data.gdx
$load C
$gdxIn
display C;

Scalars
Wmax  maximum speed of the pump /2950/
Vtot  total flowrate /350/
Ptot  total pressure rise /400/
Npmax maximum number of parallel lines at level i /3/
Nsmax maximum number of pumps in series at level i /3/;

Variable
OF Objective Function;

Binary Variable
z(i) denote the existence of level i;

Integer Variables
Np(i) number of parallel lines at level i
Ns(i) number of pumps in series at level i;

Positive Variables
x(i) fraction of total flow going to level i
w(i) rotation speed of all pumps at level i
v(i) flowrate on each line at level i
P(i) power requirements at level i
Delta_p(i) pressure rise at level i;

Equations 
Obj, G1, G2, G3, G4, G5, G6, G7, G8, G9, G10, G11, G12;

Obj.. OF =e= sum(i, (C(i,'Co') + C(i,'Cp') * P(i)) * Np(i) * Ns(i) * z(i));

G1.. sum(i, x(i)) =e= 1;
G2.. P(i) - (C(i,'Alpha') * power(w(i)/Wmax, 3)) - (C(i,'Beta') * power(w(i)/Wmax, 2) * v(i)) - (C(i,'Gamma') * (w(i)/Wmax) * sqr(v(i))) =e= 0;
G3.. Delta_p(i) - (C(i,'Alpha') * power(w(i)/Wmax, 2)) - (C(i,'b') * (w(i)/Wmax) * v(i)) - (C(i,'c') * sqr(v(i))) =e= 0;
G4.. v(i) * Np(i) - x(i) * Vtot =e= 0;
G5.. Delta_p(i) * Ns(i) - Delta_p(i) * z(i) * Np(i) =e= 0;
G6.. P(i) =l= z(i) * C(i,'Pmax');
G7.. Delta_p(i) =l= z(i) * Ptot;
G8.. v(i) =l= z(i) * Vtot;
G9.. w(i) =l= z(i) * Wmax;
G10.. Np(i) =l= z(i) * Npmax(i);
G11.. Ns(i) =l= z(i) * Nsmax(i);
G12.. x(i) =l= z(i);

Model S7Problem3_2 /all/;
solve S7Problem3_2 using MINLP minimizing OF;