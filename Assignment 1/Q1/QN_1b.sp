.include TSMC_180nm.txt

.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_N = {20*LAMBDA}
.global gnd vdd

VDS D gnd 1.8
VGS G gnd 'SUPPLY'

M1 D G gnd gnd CMOSN W={width_N} L={2*LAMBDA} +
AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N}
AD={5*width_N*LAMBDA}
PD={10*LAMBDA+2*width_N}

.dc VGS 0 1.8 0.1

.control 
set hcopypscolor = 1*White background
run 

let Ids = (-VDS#branch)
set curplottitle = "Ids vs Vgs"
let x = deriv(sqrt(Ids))
let y = vecmax(x)
plot x sqrt(Ids)
print y

hardcopy QN_1b.eps Ids 
.endc


