.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.18u
.param width_N = {50*LAMBDA}
.param width_P = {2.5*width_N}
.global gnd vdd

VDS vdd gnd 'SUPPLY'
vin a gnd pulse 0 1.8 0ns 100ps 100ps 9.9ns 20ns

M1 b a gnd gnd CMOSN W={width_N} L={LAMBDA} +
AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N}
AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M2 b a vdd vdd CMOSP W={width_P} L={LAMBDA} +
AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P}
AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M3 c b gnd gnd CMOSN W={width_N} L={LAMBDA} +
AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N}
AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M4 c b vdd vdd CMOSP W={width_P} L={LAMBDA} +
AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P}
AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

Cout c gnd 500f

.tran 0.1n 200n

.measure tran trise
+ TRIG v(c) VAL = 'SUPPLY/2' RISE =1
+ TARG v(a) VAL = 'SUPPLY/2' FALL =1

.measure tran tfall
+ TRIG v(a) VAL = 'SUPPLY/2' RISE =1
+ TARG v(c) VAL = 'SUPPLY/2' FALL=1

.measure tran tpd param = '(trise + tfall)/2' goal = 0


.control
set hcopypscolor = 1 *White background

run
plot  v(c) v(a)

hardcopy QN_7c.eps v(a)  v(c)
.endc

