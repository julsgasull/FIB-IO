set aeroports;
set companyies;
var x {i in aeroports, j in companyies} >= 0;
param P {i in aeroports, j in companyies} >= 0;
minimize cost_fuel: sum{j in companyies} sum{i in aeroports} P[i,j]*x[i,j];

subject to ri1: sum {i in aeroports} x[i,1] <= 257000;
subject to ri2: sum {i in aeroports} x[i,2] <= 550000;
subject to ri3: sum {i in aeroports} x[i,3] <= 660000;

subject to rj1: sum {j in companyies} x[1,j] >= 110000;
subject to rj2: sum {j in companyies} x[2,j] >= 220000;
subject to rj3: sum {j in companyies} x[3,j] >= 330000;
subject to rj4: sum {j in companyies} x[4,j] >= 440000;
