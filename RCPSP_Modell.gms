set
  j Arbeitsgang
  t Periode
  r Ressource;

alias(t,q);
alias(h,j);

set
  VN(h,j) Vorgänger-Nachfolger-Relation zwischen h und j;

parameter
  d(j)    Dauer des Arbeitsgangs j
  FEZ(j)  fruehestmoeglicher Endtermin des Arbeitsgangs j
  k(j,r)  Kapazitaetsbedarf des Arbeitsgangs j bezueglich der Ressource r je Periode
  Kap(r)  Periodenkapazitaet der Ressource r
  SEZ(j)  spaetestzulaessiger Endtermin des Arbeitsgangs j
  SSZ(j);

binary variables

  x(j,t)  nimmt den Wert 1 an wenn der Arbeitsgang j in Periode t beendet wird und 0 sonst;

free variables
  z       Zielfunktionswert;

$include inputfile.inc

*        BERECHNUNGEN    *
*FEZ(j)=0;
*SEZ(j)=0;
*FEZ('Q')=0;

*loop(j$(ord(j)>=2),
*    FEZ(j)=smax(h$(VN(h,j)),FEZ(h))+d(j);
*);


*SEZ('S')=50;

*alias (h,ri);
*set revi(h,ri);
*revi(h,h+[card(h)-2*ord(h)+1]) = yes;

*loop (revi(h,ri)$(ord(h)>1),
* SEZ(ri)=smin(j$(VN(ri,j)),(SEZ(j)-d(j)));
* SSZ(ri)=SEZ(ri)-d(ri);
*);


Equations
    Zielfunktion
    JederVorgangEinmal(j)
    Projektstruktur(h,j)
    Kapazitaetsrestriktion(r,t);

Zielfunktion..
    z=e=sum(j$(ord(j)=card(J)),sum(t$(FEZ(j)<=ord(t)-1 and ord(t)-1 <= SEZ(j)), (ord(t)-1)*x(j,t)));

JederVorgangEinmal(j)..
    sum(t$(FEZ(j)<=ord(t)-1 and ord(t)-1 <= SEZ(j)), x(j,t)) =e= 1;

Projektstruktur(h,j)$VN(h,j)..
    sum(t$(FEZ(h)<=ord(t)-1 and ord(t)-1 <= SEZ(h)), (ord(t)-1)*x(h,t))  =l=
    sum(t$(FEZ(j)<=ord(t)-1 and ord(t)-1 <= SEZ(j)), (ord(t)-1-d(j))*x(j,t));

Kapazitaetsrestriktion(r,t)..
    sum(j,k(j,r)*sum(q$(ord(q)-1>=ord(t)-1 and ord(q)-1<=ord(t)-1+d(j)-1),x(j,q)))=l=Kap(r);

model RCPSP /
    Zielfunktion
    JederVorgangEinmal
    Projektstruktur
    Kapazitaetsrestriktion
    /;

*Liefertermin muss verschoben werden, sonst keine zulaessige Loesung
SEZ(j)=SEZ(j)+1;

solve RCPSP minimizing z using mip;

display x.l, FEZ, SEZ;

loop(t,
 x.l('Q',t)=0;
 x.l('S',t)=0;
);

file Outputfile / 'Outputfile.txt'/;
put Outputfile;

put 'Zielfunktionswert:  ',z.l /

loop(j,
     loop(t,
         if(x.l(j,t)=1,
             put j.tl:0, ' ; ' ord(t):0 /
         );
     );
);

putclose outputfile;

