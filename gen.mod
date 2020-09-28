set I;
/* set of courses */
set J;
/* set of rooms */
set T;
/* set of teachers */
set K;
/* set of time slots */
set R0;
/* room 0 */
set ER0;
/* exception courses for room 0 */
set R1;
/* room 1 */
set ER1;
/* exception courses for room 1 */
set R2;
/* room 2 */
set ER2;
/* exception courses for room 2 */
set R3;
/* room 3 */
set ER3;
/* exception courses for room 3 */
set R4;
/* room 4 */
set ER4;
/* exception courses for room 4 */
set R5;
/* room 5 */
set ER5;
/* exception courses for room 5 */
set R6;
/* room 6 */
set ER6;
/* exception courses for room 6 */
set R7;
/* room 7 */
set ER7;
/* exception courses for room 7 */
set R8;
/* room 8 */
set ER8;
/* exception courses for room 8 */
set R9;
/* room 9 */
set ER9;
/* exception courses for room 9 */
set T0;
/* teacher 0 */
set ET0;
/* exception courses for teacher 0 */
set T1;
/* teacher 1 */
set ET1;
/* exception courses for teacher 1 */
set T2;
/* teacher 2 */
set ET2;
/* exception courses for teacher 2 */
set T3;
/* teacher 3 */
set ET3;
/* exception courses for teacher 3 */
set T4;
/* teacher 4 */
set ET4;
/* exception courses for teacher 4 */
set T5;
/* teacher 5 */
set ET5;
/* exception courses for teacher 5 */
set T6;
/* teacher 6 */
set ET6;
/* exception courses for teacher 6 */
set T7;
/* teacher 7 */
set ET7;
/* exception courses for teacher 7 */
set T8;
/* teacher 8 */
set ET8;
/* exception courses for teacher 8 */
set T9;
/* teacher 9 */
set ET9;
/* exception courses for teacher 9 */
param cost{i in I, j in J, t in T, k in K}, >= 0;
/* cost of allocating room j to course i with teacher t in time slot k */

var x{i in I, j in J, t in T, k in K} binary;
/* x[i,j,t,k] = 1 means room j is assigned to course i with teacher t in time slot k
x[i,j,t,k] = 0 otherwise  */

s.t. first{i in I}: sum{j in J, t in T, k in K} x[i,j,t,k] = 1;

s.t. second{j in J, k in K}: sum{i in I, t in T} x[i,j,t,k] <= 1;

s.t. third{t in T, k in K}: sum{i in I, j in J} x[i,j,t,k] <= 1;

s.t. c0: sum{i in ER0, j in R0, t in T, k in K} x[i,j,t,k] = 0;

s.t. c1: sum{i in ER1, j in R1, t in T, k in K} x[i,j,t,k] = 0;

s.t. c2: sum{i in ER2, j in R2, t in T, k in K} x[i,j,t,k] = 0;

s.t. c3: sum{i in ER3, j in R3, t in T, k in K} x[i,j,t,k] = 0;

s.t. c4: sum{i in ER4, j in R4, t in T, k in K} x[i,j,t,k] = 0;

s.t. c5: sum{i in ER5, j in R5, t in T, k in K} x[i,j,t,k] = 0;

s.t. c6: sum{i in ER6, j in R6, t in T, k in K} x[i,j,t,k] = 0;

s.t. c7: sum{i in ER7, j in R7, t in T, k in K} x[i,j,t,k] = 0;

s.t. c8: sum{i in ER8, j in R8, t in T, k in K} x[i,j,t,k] = 0;

s.t. c9: sum{i in ER9, j in R9, t in T, k in K} x[i,j,t,k] = 0;

s.t. c0: sum{i in ET0, j in T0, t in T, k in K} x[i,j,t,k] = 0;

s.t. c1: sum{i in ET1, j in T1, t in T, k in K} x[i,j,t,k] = 0;

s.t. c2: sum{i in ET2, j in T2, t in T, k in K} x[i,j,t,k] = 0;

s.t. c3: sum{i in ET3, j in T3, t in T, k in K} x[i,j,t,k] = 0;

s.t. c4: sum{i in ET4, j in T4, t in T, k in K} x[i,j,t,k] = 0;

s.t. c5: sum{i in ET5, j in T5, t in T, k in K} x[i,j,t,k] = 0;

s.t. c6: sum{i in ET6, j in T6, t in T, k in K} x[i,j,t,k] = 0;

s.t. c7: sum{i in ET7, j in T7, t in T, k in K} x[i,j,t,k] = 0;

s.t. c8: sum{i in ET8, j in T8, t in T, k in K} x[i,j,t,k] = 0;

s.t. c9: sum{i in ET9, j in T9, t in T, k in K} x[i,j,t,k] = 0;

minimize obj: sum{i in I, j in J, t in T, k in K} cost[i,j,t,k] * x[i,j,t,k];
/* the objective is to find a cheapest assignment */

solve;

printf {i in I, j in J, t in T, k in K} 'result: %s %s %s %s %s
', i, j, k, t, x[i,j,t,k];

data;set I := 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19;

set T := 0 1 2 3 4 5 6 7 8 9;
set J := 0 1 2 3 4 5 6 7 8 9;
set K := 0 1 2 3 4 5 6 7 8 9;
