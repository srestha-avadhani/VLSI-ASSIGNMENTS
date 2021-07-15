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
x2 gnd gnd D D_bar Y2 vdd gnd mux
x3 vdd vdd D D_bar Y3 vdd gnd mux
x4 vdd gnd D D_bar Y4 vdd gnd mux
x5 vdd vdd D D_bar Y5 vdd gnd mux
x6 vdd gnd D D_bar Y6 vdd gnd mux
x7 vdd vdd D D_bar Y7 vdd gnd mux
x8 vdd vdd D D_bar Y8 vdd gnd mux
x9 Y1 Y2 C C_bar Y9 vdd gnd mux
x10 Y3 Y4 C C_bar Y10 vdd gnd mux
x11 Y5 Y6 C C_bar Y11 vdd gnd mux
x12 Y7 Y8 C C_bar Y12 vdd gnd mux
x13 Y10 Y9 B B_bar Y13 vdd gnd mux
x14 Y12 Y11 B B_bar Y14 vdd gnd mux
x15 Y14 Y13 A A_bar Y15 vdd gnd mux


Cout Y15 gnd 8.32f

.tran 0.1n 200n

.measure tran tplh 
+TRIG v(Y15) val = '0' RISE = 1
+TARG v(Y15) val ='1' RISE = 1

.measure tran tphl
+TRIG v(Y15) val = '1' FALL = 1
+TARG v(Y15) val = '0' FALL = 1

.control 

set hcopypscolor = 1
set color0 = white
set color1 = black

run

plot v(y15)

.endc
