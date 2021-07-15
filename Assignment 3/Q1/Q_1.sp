2*1 MUX
.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width = {5*LAMBDA}
.global vdd gnd

Vdd vdd gnd 'SUPPLY'
Vin_a A gnd pulse 0 1.8 0ns 100ps 100ps 4.9ns 10ns
Vin_b B gnd pulse 0 1.8 0ns 100ps 100ps 9.9ns 20ns
Ven S gnd pwl (0 0v 49.9ns 0v 50ns 1.8v 100ns 1.8v)
Venbar S_bar gnd pwl ( 0 1.8v 49.9ns 1.8v 50ns 0v 100ns 0v)

.subckt mux y x en out vdd gnd

.param width_N = {width}
.param width_P = {2*width}

M1 y x gnd gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N} AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

M2 y x vdd vdd CMOSP W = {width_P} L = {2*LAMBDA}
+ AS = {5*width_P*LAMBDA} PS = {10*LAMBDA + 2*width_P} AD = {5*width_P*LAMBDA} PD = {10*LAMBDA + 2*width_P}

M3 y en out gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N} AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

.ends mux

.subckt not y x vdd gnd

.param width_N = {4*width}
.param width_P = {2*width}

M1 y x gnd gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N} AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

M2 y x vdd vdd CMOSP W = {width_P} L = {2*LAMBDA}
+ AS = {5*width_P*LAMBDA} PS = {10*LAMBDA + 2*width_P} AD = {5*width_P*LAMBDA} PD = {10*LAMBDA + 2*width_P}

.ends not

X1 X A S Z vdd gnd mux
X2 Y B S_bar Z vdd gnd mux
X3 C Z vdd gnd not

Cin1 A gnd 2.08f
Cin2 B gnd 2.08f
Cout1 Z gnd 4.16f
Cout C gnd 4.16f

.tran 0.1n 100n

.measure tran tpdr_A
+ TRIG v(A) val = 'SUPPLY/2' RISE =1
+ TARG v(C) val = 'SUPPLY/2' RISE =1

.measure tran tpdf_A
+ TRIG v(A) val = 'SUPPLY/2' FALL =1
+ TARG v(C) val = 'SUPPLY/2' FALL =1

.measure tran tpd_A param = '(tpdr_A + tpdf_A)/2' goal = 0;

.measure tran tpdr_B
+ TRIG v(B) val = 'SUPPLY/2' RISE =1
+ TARG v(C) val = 'SUPPLY/2' RISE =1

.measure tran tpdf_B
+ TRIG v(B) val = 'SUPPLY/2' FALL =1
+ TARG v(C) val = 'SUPPLY/2' FALL =1

.measure tran tpd_B param = '(tpdr_B + tpdf_B)/2' goal = 0;

.control

set hcopypscolor = 1
set color0 = white
set color1 = black
run

set curplottitle = "Sresthavadhani-2019102032-Qn1"

hardcopy Q1_A.eps v(A)
hardcopy Q1_B.eps v(B)
hardcopy Q1_S.eps v(S)
hardcopy Q1_S_bar.eps v(S_bar)
hardcopy Q1_C.eps v(C)

.endc
