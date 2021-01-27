set NODES;
set CLIENTS within NODES;
set ORIGIN within NODES;
set ARCS within NODES cross NODES;

/*--------------------*/
/*---Floyd-Warshall---*/
/*--------------------*/

param cost {NODES,NODES} default Infinity;
param xcoord {NODES};
param ycoord {NODES};

/*--------------------*/
/*----VRP with MTZ----*/
/*--------------------*/

param C > 0; # capacidad del camion
param K > 0; # numero de camiones
param demand {CLIENTS}; # demanda de los clientes

var x {CLIENTS,CLIENTS} binary;
var u {CLIENTS} >= 0;

minimize total_cost:
  sum {i in CLIENTS, j in CLIENTS} cost[i,j] * x[i,j];

# Degree constraints
subject to Degree_Out {i in CLIENTS: i!=3}:
  sum {j in CLIENTS: j!=i } x[i,j] = 1;
subject to Degree_In {j in CLIENTS: j!=3}:
  sum {i in CLIENTS: i!=j } x[i,j] = 1;

# Arrivals to depot
subject to Depot_arrivals {j in CLIENTS: j=3}:
  sum {i in CLIENTS: i!=3 } x[i,j]=K;

# Departures from depot
subject to Depot_departures {i in CLIENTS: i=3}:
  sum {j in CLIENTS: j!=3} x[i,j]=K;

# Approximate subtour elimination constraints
subject to subtour_elimination {(i,j) in (CLIENTS diff {3}) cross (CLIENTS diff {3})}:
  u[j] >= u[i] + demand[j] - C*(1 - x[i,j]);

# Lowerbound on u
subject to lowerbound {i in CLIENTS diff {3}}: u[i]>=demand[i];

# Upperbound on u
subject to upperbound {i in CLIENTS diff {3}}: u[i]<=C;
