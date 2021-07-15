.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_P = {20*LAMBDA}
.global gnd vdd

VGS G gnd -1.8
VDS1 D1 gnd -1.8
VDS2 D2 gnd -1.8
VDS3 D3 gnd -1.8

VBS2 B2 gnd 0.9
VBS3 B3 gnd -0.9

M1 gnd G D1 gnd CMOSP W={width_P} L={2*LAMBDA}+
AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_p}
AD={5*width_P*LAMBDA}
PD={10*LAMBDA+2*width_P}

M2 gnd G D2 B2 CMOSP W={width_P} L={2*LAMBDA}+
AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_p}
AD={5*width_P*LAMBDA}
PD={10*LAMBDA+2*width_P}

M3 gnd G D3 B3 CMOSP W={width_P} L={2*LAMBDA}+
AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_p}
AD={5*width_P*LAMBDA}
PD={10*LAMBDA+2*width_P}



.dc VGS 0 -1.8 -0.1

.control
set hcopypscolor = 1*White background
run

let Ids1 = (VDS1#branch)
let Ids2 = (VDS2#branch)
let Ids3 = (VDS3#branch)

let x1 = deriv(sqrt(Ids1))
let y1 = vecmax(abs(x1))

let x2 = deriv(sqrt(Ids2))
let y2 = vecmax(abs(x2))

let x3 = deriv(sqrt(Ids3))
let y3 = vecmax(abs(x3))

print y1 y2 y3 
plot  Ids1 Ids2 Ids3

hardcopy QN_3b.eps  Ids1 Ids2 Ids3 

.endc

~                      
