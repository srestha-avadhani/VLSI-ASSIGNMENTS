4 inverters in series
.include TSMC_180nm.txt
.param SUPPLY = 1.8
.param LAMBDA = 0.09u
.param width_N1 = {20*LAMBDA}
.param width_N2 = {4*width_N1}
.param width_N3 = {16*width_N1}
.param width_N4 = {64*width_N1}
.param width_N5 = {376*width_N1}
.param width_P1 = {2.5*width_N1}
.param width_P2 = {2.5*width_N2}
.param width_P3 = {2.5*width_N3}
.param width_P4 = {2.5*width_N4}
.param width_P5 = {2.5*width_N5}

.global vdd gnd

Vdd vdd gnd 'SUPPLY'
VDS vdd D1 0
VSS SS gnd 0
vin A 0 pwl 0 0V 0.5ns 1.8V 1.1ns 1.8V 1.5ns 0V 10ns 0V

M1 B A gnd gnd CMOSN W = {width_N1} L = {2*LAMBDA}
+ AS = {5*width_N1*LAMBDA} PS = {10*LAMBDA + 2*width_N1}
AD = {5*width_N1*LAMBDA} PD = {10*LAMBDA + 2*width_N1}

M2 B A vdd vdd CMOSP W = {width_P1} L = {2*LAMBDA}
+ AS = {5*width_P1*LAMBDA} PS = {10*LAMBDA + 2*width_P1}
AD = {6*width_P1*LAMBDA} PD = {10*LAMBDA + 2*width_P1}


M3 C B gnd gnd CMOSN W = {width_N2} L = {2*LAMBDA}
+ AS = {5*width_N2*LAMBDA} PS = {10*LAMBDA + 2*width_N2}
AD = {5*width_N2*LAMBDA} PD = {10*LAMBDA + 2*width_N2}

M4 C B vdd vdd CMOSP W = {width_P2} L = {2*LAMBDA}
+ AS = {5*width_P2*LAMBDA} PS = {10*LAMBDA + 2*width_P2}
AD = {6*width_P2*LAMBDA} PD = {10*LAMBDA + 2*width_P2}


M5 D C SS gnd CMOSN W = {width_N3} L = {2*LAMBDA}
+ AS = {5*width_N3*LAMBDA} PS = {10*LAMBDA + 2*width_N3}
AD = {5*width_N3*LAMBDA} PD = {10*LAMBDA + 2*width_N3}

M6 D C D1 vdd CMOSP W = {width_P3} L = {2*LAMBDA}
+ AS = {5*width_P3*LAMBDA} PS = {10*LAMBDA + 2*width_P3}
AD = {6*width_P3*LAMBDA} PD = {10*LAMBDA + 2*width_P3}



M7 E D gnd gnd CMOSN W = {width_N4} L = {2*LAMBDA}
+ AS = {5*width_N4*LAMBDA} PS = {10*LAMBDA + 2*width_N4}
AD = {5*width_N4*LAMBDA} PD = {10*LAMBDA + 2*width_N4}

M8 E D vdd vdd CMOSP W = {width_P4} L = {2*LAMBDA}
+ AS = {5*width_P4*LAMBDA} PS = {10*LAMBDA + 2*width_P4}
AD = {6*width_P4*LAMBDA} PD = {10*LAMBDA + 2*width_P4}



M9 F E gnd gnd CMOSN W = {width_N5} L = {2*LAMBDA}
+ AS = {5*width_N5*LAMBDA} PS = {10*LAMBDA + 2*width_N5}
AD = {5*width_N5*LAMBDA} PD = {10*LAMBDA + 2*width_N5}

M10 F E vdd vdd CMOSP W = {width_P5} L = {2*LAMBDA}
+ AS = {5*width_P5*LAMBDA} PS = {10*LAMBDA + 2*width_P5}
AD = {6*width_P5*LAMBDA} PD = {10*LAMBDA + 2*width_P5}


Cout F gnd 1p

.tran 10p 5n


.control 

set hcopypscolor = 1*White background

run 

let s1 =100* (VDS#branch)
let s2 =100* (VSS#branch)
set curplottitle = "sresthavadhani-2019102032-Qn4-d"
plot s1 s2 v(C) v(D)
hardcopy Qn_4d.eps s1 s2 v(C) v(D)

.endc


