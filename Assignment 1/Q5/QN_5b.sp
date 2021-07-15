.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_N1 = {20*LAMBDA}
.param width_N2 = {40*LAMBDA}
.param width_N3 = {200*LAMBDA}
.param width_N4 = {400*LAMBDA}
.global  gnd vdd

VDS1 D1 gnd pulse 0 1.8 0ns 1ns 1ns 10ns 20ns
VDS2 D2 gnd pulse 0 1.8 0ns 1ns 1ns 10ns 20ns
VDS3 D3 gnd pulse 0 1.8 0ns 1ns 1ns 10ns 20ns
VDS4 D4 gnd pulse 0 1.8 0ns 1ns 1ns 10ns 20ns

VGS G gnd gnd

M1 D1 G gnd gnd CMOSN W={width_N1} L={2*LAMBDA} +
AS={5*width_N1*LAMBDA} PS={10*LAMBDA+2*width_N1}
AD={5*width_N1*LAMBDA}
PD={10*LAMBDA+2*width_N1}

M2 D2 G gnd gnd CMOSN W={width_N2} L={2*LAMBDA} +
AS={5*width_N2*LAMBDA} PS={10*LAMBDA+2*width_N2}
AD={5*width_N2*LAMBDA}
PD={10*LAMBDA+2*width_N2}

M3 D3 G gnd gnd CMOSN W={width_N3} L={2*LAMBDA} +
AS={5*width_N3*LAMBDA} PS={10*LAMBDA+2*width_N3}
AD={5*width_N3*LAMBDA}
PD={10*LAMBDA+2*width_N3}

M4 D4 G gnd gnd CMOSN W={width_N4} L={2*LAMBDA} +
AS={5*width_N4*LAMBDA} PS={10*LAMBDA+2*width_N4}
AD={5*width_N4*LAMBDA}
PD={10*LAMBDA+2*width_N4}

.tran 0.1ns 1ns

.control

run
let Ids1 = (-VDS1#branch)
let x1 = mean(Ids1)
let Ids2 = (-VDS2#branch)
let x2 = mean(Ids2)
let Ids3 = (-VDS3#branch)
let x3 = mean(Ids3)
let Ids4 = (-VDS4#branch)
let x4 = mean(Ids4)
print x1 x2 x3 x4
plot Ids1 Ids2 Ids3 Ids4
hardcopy QN_5b.eps Ids1 Ids2 Ids3 Ids4
.endc

