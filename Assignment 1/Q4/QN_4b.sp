.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_N = {20*LAMBDA}
.global gnd vdd

VDS D gnd 1.8
VGS G gnd 'SUPPLY'


M1 D G A gnd CMOSN W={width_N} L={2*LAMBDA} +
AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N}
AD={5*width_N*LAMBDA}
PD={10*LAMBDA+2*width_N}

M2 A G gnd gnd CMOSN W={width_N} L={2*LAMBDA} +
AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N}
AD={5*width_N*LAMBDA}
PD={10*LAMBDA+2*width_N} 

.dc VDS 0 1.8 0.1

.control 
set hcopypscolor = 1 *White background

run

let Ids = (-VDS#branch)
set curplottitle = "Ids vs Vds"
plot Ids

hardcopy QN_4b.eps (-VDS#branch) 
.endc

