4 inverters in series
.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width = {20*LAMBDA}
.global vdd gnd

Vdd vdd gnd 'SUPPLY'
vin A 0 pwl 0 0V 0.5ns 1.8V 1.1ns 1.8V 1.5ns 0V 10ns 0V

.subckt not1 y x vdd gnd 

.param width_N = {width}
.param width_P = {2.5*width_N}

M1 y x gnd gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N}
AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

M2 y x vdd vdd CMOSP W = {width_P} L = {2*LAMBDA}
+ AS = {5*width_P*LAMBDA} PS = {10*LAMBDA + 2*width_P}
AD = {5*width_P*LAMBDA} PD = {10*LAMBDA + 2*width_P}

.ends not1

.subckt not2 y x vdd gnd

.param width_N = {4*width}
.param width_P = {2.5*width_N}

M1 y x gnd gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N}
AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

M2 y x vdd vdd CMOSP W = {width_P} L = {2*LAMBDA}
+ AS = {5*width_P*LAMBDA} PS = {10*LAMBDA + 2*width_P}
AD = {5*width_P*LAMBDA} PD = {10*LAMBDA + 2*width_P}

.ends not2

.subckt not3 y x vdd gnd

.param width_N = 16*width
.param width_P = 2.5*width_N

M1 y x gnd gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N}
AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

M2 y x vdd vdd CMOSP W = {width_P} L = {2*LAMBDA}
+ AS = {5*width_P*LAMBDA} PS = {10*LAMBDA + 2*width_P}
AD = {5*width_P*LAMBDA} PD = {10*LAMBDA + 2*width_P}

.ends not3

.subckt not4 y x vdd gnd

.param width_N = 64*width
.param width_P = 2.5*width_N

M1 y x gnd gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N}
AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

M2 y x vdd vdd CMOSP W = {width_P} L = {2*LAMBDA}
+ AS = {5*width_P*LAMBDA} PS = {10*LAMBDA + 2*width_P}
AD = {5*width_P*LAMBDA} PD = {10*LAMBDA + 2*width_P}

.ends not4

.subckt not5 y x vdd gnd

.param width_N =376*width
.param width_P = 2.5*width_N

M1 y x gnd gnd CMOSN W = {width_N} L = {2*LAMBDA}
+ AS = {5*width_N*LAMBDA} PS = {10*LAMBDA + 2*width_N}
AD = {5*width_N*LAMBDA} PD = {10*LAMBDA + 2*width_N}

M2 y x vdd vdd CMOSP W = {width_P} L = {2*LAMBDA}
+ AS = {5*width_P*LAMBDA} PS = {10*LAMBDA + 2*width_P}
AD = {5*width_P*LAMBDA} PD = {10*LAMBDA + 2*width_P}

.ends not5

x1 B A vdd gnd not1
x2 C B vdd gnd not2
x3 D C vdd gnd not3
x4 E D vdd gnd not4
x5 F E vdd gnd not5

Cout F gnd 1p

.tran 10p 5n
.measure tran tpdr3
+ TRIG v(C) VAL='SUPPLY/2' FALL=1 
+ TARG v(D) VAL='SUPPLY/2' RISE=1

.measure tran tpdf3
+ TRIG v(C) VAL='SUPPLY/2' RISE=1
+ TARG v(D) VAL='SUPPLY/2' FALL=1

.measure tran tpdr4
+ TRIG v(D) VAL='SUPPLY/2' FALL=1 
+ TARG v(E) VAL='SUPPLY/2' RISE=1

.measure tran tpdf4
+ TRIG v(D) VAL='SUPPLY/2' RISE=1
+ TARG v(E) VAL='SUPPLY/2' FALL=1

.measure tran tpd3 param='(tpdr3+tpdf3)/2' goal=0
.measure tran tpd4 param='(tpdr4+tpdf4)/2' goal=0

.control

run 

.endc


