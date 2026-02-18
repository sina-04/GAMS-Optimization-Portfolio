
Sets
i Level indicator /1*3/
h Columns /Co,Cp,alpha,beta,gamma,a,b,c,Pmax/;

Parameter D(i,h)

$call GDXXRW S7P3_Data.xlsx par=D rng=Sheet1!A1:J4 rdim=1 cdim=1

$GDXIN S7P3_Data.gdx
$LOAD D
$GDXIN

display D;

Scalars

Vt    Total flowrate (m3)                   /350/
DPt   Total pressure rise(kPa)              /400/
Wmax  Maximum rotation speed (rpm)          /2950/
Npmax Maximum number of lines in each level /3/
Nsmax Maximum number of pumps in each line  /3/;

Variable
OF Objective Function;

Binary Variable
z(i) Denotes the existance of level i;

Integer Variables
Np(i) Number of parallel lines at level i
Ns(i) Number of pumps in series at level i;

Positive Variables
x(i)  Fraction of total flow going to level i
v(i)  Flowrate of each line at level i
w(i)  Rotation speed of all pumps at level i
P(i)  Power requirement at level i
DP(i) Pressure rise at level i;

* Define the bounds that mentioned in the constraints

Np.up(i) = Npmax;
Ns.up(i) = Nsmax;
w.up(i)  = Wmax;
v.up(i)  = Vt;
DP.up(i) = DPt;
P.up(i)  = D(i,'Pmax');
x.up(i)  = 1;


Equations Obj,Const1,Const2,Const3,Const4,Const5,Const6,Const7,Const8,Const9,
          Const10,Const11,Const12;

Obj .. OF =e= sum(i, (D(i,'Co') + D(i,'Cp')*P(i))*Np(i)*Ns(i)*z(i));

Const1 .. sum(i,x(i)) =e= 1;

Const2(i) ..  P(i)-D(i,'alpha')*power(w(i)/Wmax,3) - D(i,'beta')*power(w(i)/Wmax,2)*v(i)-D(i,'gamma')*(w(i)/Wmax)*power(v(i),2) =e= 0;

Const3(i) ..  DP(i)-D(i,'a')*power(w(i)/Wmax,2) - D(i,'b')*(w(i)/Wmax)*v(i) - D(i,'c')*power(v(i),2) =e= 0;

Const4(i) ..  v(i)*Np(i) - x(i)*Vt =e= 0;

Const5(i) ..  DPt*z(i) - DP(i)*Ns(i) =e= 0;

* To reduce the size of the problem, we can set the variable associated with a specific level zero when that level does not exist

Const6(i) .. P(i) =l= z(i)*D(i,'Pmax');

Const7(i) .. DP(i) =l= z(i)*DPt;

Const8(i) .. v(i) =l= z(i)*Vt;

Const9(i) .. w(i) =l= z(i)*Wmax;

Const10(i) .. Np(i) =l= z(i)*Npmax;

Const11(i) .. Ns(i) =l= z(i)*Nsmax;

Const12(i) .. x(i) =l= z(i);

model PumpConfig /all/;
solve PumpConfig using MINLP minimizing OF;

* Create a report of your results
Parameter rep Report from result;

rep(i,'z') = z.l(i);
rep(i,'Np') = Np.l(i);
rep(i,'Ns') = Ns.l(i);
rep(i,'v') = v.l(i);
rep(i,'w') = w.l(i);
rep(i,'DP') = DP.l(i);

display rep;

execute_unload "S7P3_Data.gdx" rep
execute 'gdxxrw.exe S7P3_Data.gdx par=rep rng=Results!A1'