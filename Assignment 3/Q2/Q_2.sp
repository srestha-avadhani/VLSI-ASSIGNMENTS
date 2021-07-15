Q2-Shanon Expansion

.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_N = {5*LAMBDA}
.global vdd gnd

Vdd vdd gnd 'SUPPLY'
Vin_a A gnd pulse 0 1.8 0ns 100ps 100ps 5ns 10ns
Vin_b B gnd pulse 0 1.8 0ns 100ps 100ps 10ns 20ns
Vin_c C gnd pulse 0 1.8 0ns 100ps 100ps 15ns 30ns
Vin_d D gnd pulse 0 1.8 0ns 100ps 100ps 20ns 40ns
Vin_abar A_bar gnd pulse 1.8 0 0ns 100ps 100ps 5ns 10ns
Vin_bbar B_bar gnd pulse 1.8 0 0ns 100ps 100ps 10ns 20ns
Vin_cbar C_bar gnd pulse 1.8 0 0ns 100ps 100ps 15ns 30ns
Vin_dbar D_bar gnd pulse 1.8 0 0ns 100ps 100ps 20ns 40ns


.subckt mux A B X X_bar Y  vdd gnd

M1 A X Y gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N} AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

M2 B X_bar Y gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N} AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

.ends mux

x1 vdd gnd D D_bar Y1 vdd gnd mux
x2 vdd gnd D D_bar Y2 vdd gnd mux
x3 vdd gnd D D_bar Y3 vdd gnd mux
x4 Y1 gnd C C_bar Y4 vdd gnd mux
x5 vdd Y2 C C_bar Y5 vdd gnd mux
x6 vdd Y3 C C_bar Y6 vdd gnd mux
x7 vdd vdd C C_bar Y7 vdd gnd mux
x8 Y5 Y4 B B_bar Y8 vdd gnd mux
x9 Y7 Y6 B B_bar Y9 vdd gnd mux
x10 Y9 Y8 A A_bar Y10 vdd gnd mux

Cout Y10 gnd 8.32f

.tran 0.1n 200n

.measure tran tplh 
+TRIG v(Y10) val = '0' RISE = 1
+TARG v(Y10) val ='1' RISE = 1

.measure tran tphl
+TRIG v(Y10) val = '1' FALL = 1
+TARG v(Y10) val = '0' FALL = 1

.control 

set hcopypscolor = 1
set color0 = white
set color1 = black

run
set curplottitle = "Sresthavadhani-2019102032-Q2"
hardcopy Q2_A.eps v(A)
hardcopy Q2_B.eps v(B)
hardcopy Q2_C.eps v(C)
hardcopy Q2_D.eps v(D)
hardcopy Q2_Y.eps v(Y10)


.endc
