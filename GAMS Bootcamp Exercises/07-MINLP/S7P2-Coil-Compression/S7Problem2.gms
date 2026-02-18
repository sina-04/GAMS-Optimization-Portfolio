Sets
i Wire Types /t1*t15/
h Column /D/;

Parameters W(i,h);

$call GDXXRW S7P2_Data.xlsx trace=3 par=W rng=Sheet1!A1:B16 rdim=1 cdim=1

$GDXIN S7P2_Data.gdx
$LOAD W
$GDXIN

display W;

Scalars

Pload    Preload(lb) /300/
Pmax     Maximum Working Load(lb) /1000/
defm     Maximum Deflection (in)  /6/
defml    Deflection from Preload to Maximum Load (in) /1.25/
Lmax     Maximum free length of coil spring (in) /14/
Dcm      Maximum Coil Spring Diameter (in) /3/
dWm      Minimum Wire Diameter (in) /0.2/
S        Maximum allowable shear stress (from literature) /234.44e3/
G        shear modulus of steel ASTM A228 (psi) /11.6e6/;

Variables
OF   Objective Function
Dc   Coil Spring Diameter
dW   Wire Diameter
def  Deflection
C    Inter1
K    Inter2;

Integer Variable
N    Number of Spring Coils;

Binary Variable
x    Wire Selection;

C.lo = 3;
N.lo = 1;
def.up = defm;
def.lo = defml/(Pmax-Pload);
Dc.lo = 2*dWm;
Dc.up = Dcm;
K.up = (Pmax-Pload)/defml;
dW.lo = dWm;

Equations Obj Minimize the Volume
          Const1,Const2,Const3,Const4,Const5,Const6,Const7;

Obj .. OF =e= Pi*Dc*power(dW,2)*(N+2)/4;

Const1 .. C =e= Dc/dW;

Const2 .. K =e= ((4*C-1)/(4*C-4))+0.615/C;

Const3 .. S-(8*K*Pmax*Dc/(Pi*power(dW,3))) =g= 0;

Const4 .. def  =e= 8*power(Dc,3)*N/(G*(power(dW,4)));

Const5 .. Pmax*def+1.05*(N+2)*dW =l= Lmax;

Const6 .. dW =e= sum(i,W(i,'D')*x(i));

Const7 .. sum(i,x(i)) =e= 1;

model CoilComp /all/;
solve CoilComp using MINLP minimizing OF;