.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_P = {20*LAMBDA}
.global gnd vdd

VSS S gnd 0
VGS G gnd 1.8


M1 D G S S  CMOSP   W={width_P}   L={2*LAMBDA}+
AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P}
AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

Cout D gnd 100f

.tran 0.1n 200n

.ic v(D) = 1.8

.control

set hcopypscolor = 1

run

plot v(D) 

hardcopy QN_6b.eps v(D)
.endc

