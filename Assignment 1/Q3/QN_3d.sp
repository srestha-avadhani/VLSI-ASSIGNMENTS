.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_P = {20*LAMBDA}
.global gnd vdd

VGS G gnd 'SUPPLY'
VDS D gnd 1.8

M1  gnd   G   D  D  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} 
  AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

.dc VGS 0 1.8 0.1


.control

run 

let Ids = (VDS#branch)
let x = deriv(Ids)
let y = vecmax(x)
print y
plot x Ids
hardcopy QN_3d.eps (VDS#branch)
.endc
