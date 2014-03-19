set r / 
r1
/; 

set j / 
Q 
j1
j2
j3
j4
j5
j6
j7
j8
j9
j10
S 
/; 

set t /t0*t50/; 

VN(h,j)=no; 
VN('Q','j1')=yes;
VN('j1','S')=yes;
VN('Q','j2')=yes;
VN('j2','S')=yes;
VN('Q','j3')=yes;
VN('j3','S')=yes;
VN('Q','j4')=yes;
VN('j4','S')=yes;
VN('Q','j5')=yes;
VN('j5','S')=yes;
VN('Q','j6')=yes;
VN('j6','S')=yes;
VN('Q','j7')=yes;
VN('j7','S')=yes;
VN('Q','j8')=yes;
VN('j8','S')=yes;
VN('Q','j9')=yes;
VN('j9','S')=yes;
VN('Q','j10')=yes;
VN('j10','S')=yes;

VN('j1','j2')=yes; 
VN('j2','j3')=yes; 
VN('j2','j4')=yes; 
VN('j3','j5')=yes; 
VN('j3','j6')=yes; 
VN('j4','j8')=yes; 
VN('j5','j9')=yes; 
VN('j6','j7')=yes; 
VN('j7','j8')=yes; 
VN('j8','j9')=yes; 
VN('j9','j10')=yes; 

parameter 
d(j) / 
Q   0
S   0
j1   1
j2   2
j3   3
j4   2
j5   3
j6   4
j7   6
j8   8
j9   3
j10   15
/
Kap(r) /
r1   9
/;

k(j,r)=0;
k('j1','r1')=8;
k('j2','r1')=8;
k('j3','r1')=5;
k('j4','r1')=4;
k('j5','r1')=4;
k('j6','r1')=8;
k('j7','r1')=7;
k('j8','r1')=6;
k('j9','r1')=5;
k('j10','r1')=8;
