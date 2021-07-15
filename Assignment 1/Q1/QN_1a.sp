.include TSMC_180nm.txt

.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_N = {20*LAMBDA}
.global gnd vdd

VGS G gnd 'SUPPLY'
VDS D gnd 0.05V

M1 D G gnd gnd CMOSN W={width_N} L={2*LAMBDA} +
AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N}
AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

.dc VGS 0 1.8 0.1

.control
set hcopypscolor = 1*White background
run
 
let Ids = (-VDS#branch)
set curplottitle = "ids vs Vgs"
let x = deriv(Ids)
let y = vecmax(x) 
plot Ids x
print y
hardcopy QN_1a.eps (-VDS#branch) 
.endc
 
