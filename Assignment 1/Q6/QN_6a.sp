.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_N = {20*LAMBDA}
.global gnd vdd

VGS G gnd 2.5
VDS D gnd 0

M1 D  G  S  S  CMOSN   W={width_N}   L={2*LAMBDA}+
AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} 
AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

Cout S gnd 100f

.ic v(S) = 1.8

.tran 0.1n 2000ns

.control

set hcopypscolor = 1 *White background
run

plot v(S)

hardcopy QN_6a.eps v(S)
.endc

