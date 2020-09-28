set I;
/* set of courses */

set J;
/* set of rooms */

set T;
/* set of teachers */

set K;
/* set of time slots */


set R1;
/* room 1 */
set Ec1;
/* exception courses for room 1 */

set R2;
/* room 2 */
set Ec2;
/* exception courses for room 2 */

set TA;
/* teacher A */
set EtA;
/* exception courses for teacher A */

set TB;
/* teacher B */
set EtB;
/* exception courses for teacher B */

set TC;
/* teacher C */
set EtC;
/* exception courses for teacher C */

param cost{i in I, j in J, t in T, k in K}, >= 0;
/* cost of allocating room j to course i with teacher t in time slot k */

var x{i in I, j in J, t in T, k in K} binary;
/* x[i,j,t,k] = 1 means room j is assigned to course i with teacher t in time slot k
   x[i,j,t,k] = 0 otherwise  */

s.t. first{i in I}: sum{j in J, t in T, k in K} x[i,j,t,k] = 1;

s.t. second{j in J, k in K}: sum{i in I, t in T} x[i,j,t,k] <= 1;

s.t. third{t in T, k in K}: sum{i in I, j in J} x[i,j,t,k] <= 1;

s.t. four: sum{i in Ec1, j in R1, t in T, k in K} x[i,j,t,k] = 0;

s.t. five: sum{i in Ec2, j in R2, t in T, k in K} x[i,j,t,k] = 0;

s.t. six: sum{i in EtA, j in J, t in TA, k in K} x[i,j,t,k] = 0;

s.t. seven: sum{i in EtB, j in J, t in TB, k in K} x[i,j,t,k] = 0;

s.t. eight: sum{i in EtC, j in J, t in TC, k in K} x[i,j,t,k] = 0;

minimize obj: sum{i in I, j in J, t in T, k in K} cost[i,j,t,k] * x[i,j,t,k];
/* the objective is to find a cheapest assignment */

solve;

printf {i in I, j in J, t in T, k in K} 'result: %s %s %s %s %s\n', i, j, k, t, x[i,j,t,k];

data;

set I := a b c d e;

set T := A B C;

set J := 1 2;

set K := 1 2 3;

set R1 := 1;
set Ec1 := c e;

set R2 := 2;
set Ec2 := a b d;

set TA := A;
set EtA := d;

set TB := B;
set EtB := c e;

set TC := C;
set EtC := a b c e;

param cost :=
[*,*,A,1]: 1 2 :=
a 1 1
b 1 1
c 1 1
d 1 1
e 1 1
[*,*,B,1]: 1 2 :=
a 1 1
b 1 1
c 1 1
d 1 1
e 1 1
[*,*,C,1]: 1 2 :=
a 1 1
b 1 1
c 1 1
d 1 1
e 1 1
[*,*,A,2]: 1 2 :=
a 2 2
b 2 2
c 2 2
d 2 2
e 2 2
[*,*,B,2]: 1 2 :=
a 2 2
b 2 2
c 2 2
d 2 2
e 2 2
[*,*,C,2]: 1 2 :=
a 2 2
b 2 2
c 2 2
d 2 2
e 2 2
[*,*,A,3]: 1 2 :=
a 3 3
b 3 3
c 3 3
d 3 3
e 3 3
[*,*,B,3]: 1 2 :=
a 3 3
b 3 3
c 3 3
d 3 3
e 3 3
[*,*,C,3]: 1 2 :=
a 3 3
b 3 3
c 3 3
d 3 3
e 3 3;


end;

