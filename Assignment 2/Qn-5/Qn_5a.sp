31 stage ring oscillator
.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.global vdd gnd

Vdd vdd gnd 'SUPPLY'

.subckt inv y x vdd gnd
.param width_N = 10*LAMBDA
.param width_P = 2.5*width_N

M1  y  x  gnd  gnd  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} 
  AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M2  y  x  vdd  vdd  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P}
  AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

.ends inv 

x1 b1 a1 vdd gnd inv
x2 b2 b1 vdd gnd inv
x3 b3 b2 vdd gnd inv
x4 b4 b3 vdd gnd inv
x5 b5 b4 vdd gnd inv
x6 b6 b5 vdd gnd inv
x7 b7 b6 vdd gnd inv
x8 b8 b7 vdd gnd inv
x9 b9 b8 vdd gnd inv
x10 b10 b9 vdd gnd inv
x11 b11 b10 vdd gnd inv
x12 b12 b11 vdd gnd inv
x13 b13 b12 vdd gnd inv
x14 b14 b13 vdd gnd inv
x15 b15 b14 vdd gnd inv
x16 b16 b15 vdd gnd inv
x17 b17 b16 vdd gnd inv
x18 b18 b17 vdd gnd inv
x19 b19 b18 vdd gnd inv
x20 b20 b19 vdd gnd inv
x21 b21 b20 vdd gnd inv
x22 b22 b21 vdd gnd inv
x23 b23 b22 vdd gnd inv
x24 b24 b23 vdd gnd inv
x25 b25 b24 vdd gnd inv
x26 b26 b25 vdd gnd inv
x27 b27 b26 vdd gnd inv
x28 b28 b27 vdd gnd inv
x29 b29 b28 vdd gnd inv
x30 b30 b29 vdd gnd inv
x31 a1 b30 vdd gnd inv 

.tran 0.01n 2n

.ic v(a1) = 0

.measure tran tperiod
+ TRIG v(a1) VAL='SUPPLY/2' RISE=1
+ TARG v(a1) VAL='SUPPLY/2' RISE=2

.measure tran tpdr
+ TRIG v(b26) VAL='SUPPLY/2' FALL=1
+ TARG v(b27) VAL='SUPPLY/2' RISE=1

.measure tran tpdf
+ TRIG v(b26) VAL='SUPPLY/2' RISE=1
+ TARG v(b27) VAL='SUPPLY/2' FALL=1

.measure tran tpd param='(tpdr+tpdf)/2' goal=0

.control

set hcopypscolor = 1*White background

run

set curplottitle = "Sresthavadhani-2019102032-Q5-a"
plot v(a1) v(b1) v(b2)

hardcopy Qn_5a.eps v(a1) v(b1) v(b2)
.endc






