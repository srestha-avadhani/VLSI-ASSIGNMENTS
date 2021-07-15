.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_N = {20*LAMBDA}
.global gnd vdd

VGS G gnd 'SUPPLY'
VDS1 D1 gnd 1.8
VDS2 D2 gnd 1.8
VDS3 D3 gnd 1.8
VBS2 B2 gnd 0.9
VBS3 B3 gnd -0.9

M1 D1 G gnd gnd CMOSN W={width_N} L={2*LAMBDA} +
AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N}
AD={5*width_N*LAMBDA}
PD={10*LAMBDA+2*width_N}

M2 D2 G gnd B2 CMOSN W={width_N} L={2*LAMBDA} +
AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N}
AD={5*width_N*LAMBDA}
PD={10*LAMBDA+2*width_N}

M3 D3 G gnd B3 CMOSN W={width_N} L={2*LAMBDA} +
AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N}
AD={5*width_N*LAMBDA}
PD={10*LAMBDA+2*width_N}

.dc VGS 0 1.8 0.1

.control
set hcopypscolor = 1*White background
run

let Ids1 = (-VDS1#branch)
let Ids2 = (-VDS2#branch)
let Ids3 = (-VDS3#branch)

let x1 = deriv(sqrt(Ids1))
let y1 = vecmax(x1)

let x2 = deriv(sqrt(Ids2))
let y2 = vecmax(x2)

let x3 = deriv(sqrt(Ids3))
let y3 = vecmax(x3)

print y1 y2 y3
plot x1 x2 x3 sqrt(Ids1) sqrt(Ids2) sqrt(Ids3) 

hardcopy QN_3a.eps  Ids1 Ids2 Ids3

.endc

