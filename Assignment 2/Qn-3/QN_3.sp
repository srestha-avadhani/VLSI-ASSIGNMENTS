.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.global gnd vdd

Vdd vdd gnd 'SUPPLY'
vin a gnd 1.8

.subckt not y x vdd gnd 

.param width_P = 50*LAMBDA
.param width_N = 20*LAMBDA

M1 y x gnd gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N}
AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

M2 y x vdd vdd CMOSP W = {width_P} L = {2*LAMBDA}
+ AS = {5*width_P*LAMBDA} PS = {10*LAMBDA + 2*width_P}
AD = {5*width_P*LAMBDA} PD = {10*LAMBDA + 2*width_P}

.ends not

x1 b a vdd gnd not 

x2 c b vdd gnd not 

.dc vin 0 1.8 0.01

.control
set hcopypscolor = 1*White background

run 
let x = v(b)
let y = -deriv(x)
let z = 2.432 - v(a)
let z1 = 1.1 - v(a)
plot v(b) v(z) v(z1) 

set curplottitle = "Sresthavadhani-2019102032-Q3-a"

hardcopy Qn_3a.eps v(b) v(a) v(z) v(z1)

.endc
   
