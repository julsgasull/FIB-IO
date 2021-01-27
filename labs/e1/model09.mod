set AUDIENCIAS;
set MEDIOS;

param E {AUDIENCIAS} >= 0;
param A {AUDIENCIAS, MEDIOS} >= 0;
#param inv_aud_med {AUDIENCIAS, MEDIOS} >= 0;

var D {i in AUDIENCIAS, j in MEDIOS} >= 0;
var X { j in MEDIOS };

subject to exposicion_minima { i in AUDIENCIAS }:
    E[i] <= sum {j in MEDIOS} A[i,j]*D[i,j];

subject to inversion_medios { j in MEDIOS }:
    X[j] = sum {i in AUDIENCIAS} D[i,j];

minimize gasto_publi:
    sum {j in MEDIOS} X[j];
