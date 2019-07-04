EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:ArduinoEncoderShield_anzal-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date "16 jan 2019"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ARDUINO_SHIELD SHIELD1
U 1 1 5C3EFA63
P 2750 2800
F 0 "SHIELD1" H 2400 3750 60  0000 C CNN
F 1 "ARDUINO_SHIELD" H 2800 1850 60  0000 C CNN
F 2 "" H 2750 2800 60  0000 C CNN
F 3 "" H 2750 2800 60  0000 C CNN
	1    2750 2800
	1    0    0    -1  
$EndComp
$Comp
L 4N25 IC1
U 1 1 5C3EFA70
P 5750 1500
F 0 "IC1" H 5536 1679 40  0000 C CNN
F 1 "4N25" H 5930 1315 40  0000 C CNN
F 2 "DIP6" H 5551 1320 29  0000 C CNN
F 3 "" H 5750 1500 60  0000 C CNN
	1    5750 1500
	1    0    0    -1  
$EndComp
$Comp
L ULN2003A U1
U 1 1 5C3EFA71
P 8800 1900
F 0 "U1" H 8800 2000 70  0000 C CNN
F 1 "ULN2003A" H 8800 1800 70  0000 C CNN
F 2 "" H 8800 1900 60  0000 C CNN
F 3 "" H 8800 1900 60  0000 C CNN
	1    8800 1900
	1    0    0    -1  
$EndComp
$Comp
L DIODE D1
U 1 1 5C3EFA72
P 9800 2300
F 0 "D1" H 9800 2400 40  0000 C CNN
F 1 "DIODE" H 9800 2200 40  0000 C CNN
F 2 "~" H 9800 2300 60  0000 C CNN
F 3 "~" H 9800 2300 60  0000 C CNN
	1    9800 2300
	-1   0    0    1   
$EndComp
$Comp
L AGND #PWR01
U 1 1 5C3EFA74
P 8450 2550
F 0 "#PWR01" H 8450 2550 40  0001 C CNN
F 1 "AGND" H 8450 2480 50  0000 C CNN
F 2 "" H 8450 2550 60  0000 C CNN
F 3 "" H 8450 2550 60  0000 C CNN
	1    8450 2550
	1    0    0    -1  
$EndComp
$Comp
L 4N25 IC2
U 1 1 5C3EFA75
P 5850 2750
F 0 "IC2" H 5636 2929 40  0000 C CNN
F 1 "4N25" H 6030 2565 40  0000 C CNN
F 2 "DIP6" H 5651 2570 29  0000 C CNN
F 3 "" H 5850 2750 60  0000 C CNN
	1    5850 2750
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 5C3EFA76
P 6250 3150
F 0 "R4" V 6330 3150 40  0000 C CNN
F 1 "15k" V 6257 3151 40  0000 C CNN
F 2 "~" V 6180 3150 30  0000 C CNN
F 3 "~" H 6250 3150 30  0000 C CNN
	1    6250 3150
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 5C3EFA82
P 5250 2650
F 0 "R3" V 5330 2650 40  0000 C CNN
F 1 "470E" V 5257 2651 40  0000 C CNN
F 2 "~" V 5180 2650 30  0000 C CNN
F 3 "~" H 5250 2650 30  0000 C CNN
	1    5250 2650
	0    -1   -1   0   
$EndComp
$Comp
L R R1
U 1 1 5C3EFA83
P 5150 1400
F 0 "R1" V 5050 1400 40  0000 C CNN
F 1 "470E" V 5157 1401 40  0000 C CNN
F 2 "~" V 5080 1400 30  0000 C CNN
F 3 "~" H 5150 1400 30  0000 C CNN
	1    5150 1400
	0    -1   -1   0   
$EndComp
$Comp
L R R8
U 1 1 5C3EFA84
P 7200 4950
F 0 "R8" V 7280 4950 40  0000 C CNN
F 1 "560E" V 7207 4951 40  0000 C CNN
F 2 "~" V 7130 4950 30  0000 C CNN
F 3 "~" H 7200 4950 30  0000 C CNN
	1    7200 4950
	0    -1   -1   0   
$EndComp
Text GLabel 1850 5200 2    60   Input ~ 0
12 V
Text GLabel 1850 5300 2    60   Input ~ 0
AGND
Text GLabel 1850 5400 2    60   Input ~ 0
EX 5 V
Text GLabel 1850 5500 2    60   Input ~ 0
Solenoid1_1
Text GLabel 1850 5600 2    60   Input ~ 0
Solenoid1_2
Text GLabel 1850 5700 2    60   Input ~ 0
Solenoid2_1
Text GLabel 1850 5800 2    60   Input ~ 0
Solenoid2_2
Text GLabel 6100 1500 2    60   Input ~ 0
EX 5 V
Text GLabel 10250 2300 2    60   Input ~ 0
12 V
$Comp
L CONN_8 P10
U 1 1 5C3EFA87
P 4050 4800
F 0 "P10" V 4000 4800 60  0000 C CNN
F 1 "CONN_8" V 4100 4800 60  0000 C CNN
F 2 "" H 4050 4800 60  0000 C CNN
F 3 "" H 4050 4800 60  0000 C CNN
	1    4050 4800
	1    0    0    -1  
$EndComp
$Comp
L CONN_6 P6
U 1 1 5C3EFA88
P 950 1800
F 0 "P6" V 900 1800 60  0000 C CNN
F 1 "CONN_6" V 1000 1800 60  0000 C CNN
F 2 "" H 950 1800 60  0000 C CNN
F 3 "" H 950 1800 60  0000 C CNN
	1    950  1800
	-1   0    0    1   
$EndComp
$Comp
L CONN_2 P3
U 1 1 5C3EFA8A
P 2850 1500
F 0 "P3" V 2800 1500 40  0000 C CNN
F 1 "CONN_2" V 2900 1500 40  0000 C CNN
F 2 "" H 2850 1500 60  0000 C CNN
F 3 "" H 2850 1500 60  0000 C CNN
	1    2850 1500
	1    0    0    -1  
$EndComp
Text GLabel 9950 2550 2    60   Input ~ 0
Solenoid1_1
Text GLabel 9700 1600 2    60   Input ~ 0
Solenoid1_2
Text GLabel 9950 2700 2    60   Input ~ 0
Solenoid2_1
Text GLabel 9700 1500 2    60   Input ~ 0
Solenoid2_2
$Comp
L HDR-1X15-15-91-? CN1
U 1 1 5C3EFA8D
P 1650 5500
F 0 "CN1" H 1575 6300 50  0000 L BNN
F 1 "HDR-1X15-15-91-?" H 1575 4638 50  0000 L BNN
F 2 "con-hdrs40-15-91-15" H 1650 5650 50  0001 C CNN
F 3 "" H 1650 5500 60  0000 C CNN
	1    1650 5500
	-1   0    0    1   
$EndComp
$Comp
L R R9
U 1 1 5C3EFA8E
P 9100 4950
F 0 "R9" V 9180 4950 40  0000 C CNN
F 1 "560E" V 9107 4951 40  0000 C CNN
F 2 "~" V 9030 4950 30  0000 C CNN
F 3 "~" H 9100 4950 30  0000 C CNN
	1    9100 4950
	0    -1   -1   0   
$EndComp
$Comp
L 4N25 IC4
U 1 1 5C3EFA8F
P 7800 5050
F 0 "IC4" H 7586 5229 40  0000 C CNN
F 1 "4N25" H 7980 4865 40  0000 C CNN
F 2 "DIP6" H 7601 4870 29  0000 C CNN
F 3 "" H 7800 5050 60  0000 C CNN
	1    7800 5050
	1    0    0    -1  
$EndComp
$Comp
L 4N25 IC5
U 1 1 5C3EFA90
P 9700 5050
F 0 "IC5" H 9486 5229 40  0000 C CNN
F 1 "4N25" H 9880 4865 40  0000 C CNN
F 2 "DIP6" H 9501 4870 29  0000 C CNN
F 3 "" H 9700 5050 60  0000 C CNN
	1    9700 5050
	1    0    0    -1  
$EndComp
Text GLabel 8200 5200 2    60   Input ~ 0
Tone1
Text GLabel 10150 5200 2    60   Input ~ 0
Tone2
$Comp
L R R7
U 1 1 5C3EFA94
P 5250 4950
F 0 "R7" V 5330 4950 40  0000 C CNN
F 1 "560E" V 5257 4951 40  0000 C CNN
F 2 "~" V 5180 4950 30  0000 C CNN
F 3 "~" H 5250 4950 30  0000 C CNN
	1    5250 4950
	0    -1   -1   0   
$EndComp
$Comp
L 4N25 IC3
U 1 1 5C3EFA95
P 5850 5050
F 0 "IC3" H 5636 5229 40  0000 C CNN
F 1 "4N25" H 6030 4865 40  0000 C CNN
F 2 "DIP6" H 5651 4870 29  0000 C CNN
F 3 "" H 5850 5050 60  0000 C CNN
	1    5850 5050
	1    0    0    -1  
$EndComp
Text GLabel 6300 5150 2    60   Input ~ 0
Tone3
Text GLabel 6200 5050 2    60   Input ~ 0
EX 5 V
$Comp
L R R10
U 1 1 5C3EFA96
P 6250 5450
F 0 "R10" V 6350 5600 40  0000 C CNN
F 1 "15k" V 6257 5451 40  0000 C CNN
F 2 "~" V 6180 5450 30  0000 C CNN
F 3 "~" H 6250 5450 30  0000 C CNN
	1    6250 5450
	-1   0    0    1   
$EndComp
Wire Wire Line
	10000 2300 10250 2300
Wire Wire Line
	9550 2550 9950 2550
Wire Wire Line
	9550 2700 9950 2700
Wire Wire Line
	9450 1600 9700 1600
Wire Wire Line
	9450 1500 9700 1500
Wire Wire Line
	9450 2300 9600 2300
Wire Wire Line
	9550 2300 9550 2700
Connection ~ 9550 2300
Connection ~ 9550 2550
Wire Wire Line
	8450 2550 8450 2400
$Comp
L R R5
U 1 1 5C3EFA99
P 2550 4100
F 0 "R5" V 2630 4100 40  0000 C CNN
F 1 "560E" V 2557 4101 40  0000 C CNN
F 2 "~" V 2480 4100 30  0000 C CNN
F 3 "~" H 2550 4100 30  0000 C CNN
	1    2550 4100
	0    -1   -1   0   
$EndComp
$Comp
L R R6
U 1 1 5C3EFA9A
P 2550 4300
F 0 "R6" V 2630 4300 40  0000 C CNN
F 1 "560E" V 2557 4301 40  0000 C CNN
F 2 "~" V 2480 4300 30  0000 C CNN
F 3 "~" H 2550 4300 30  0000 C CNN
	1    2550 4300
	0    -1   -1   0   
$EndComp
$Comp
L CONN_2 P9
U 1 1 5C3EFA9B
P 3200 4200
F 0 "P9" V 3150 4200 40  0000 C CNN
F 1 "CONN_2" V 3250 4200 40  0000 C CNN
F 2 "" H 3200 4200 60  0000 C CNN
F 3 "" H 3200 4200 60  0000 C CNN
	1    3200 4200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 4100 2850 4100
Wire Wire Line
	2800 4300 2850 4300
Text GLabel 2250 4100 0    60   Input ~ 0
D2
Wire Wire Line
	2250 4100 2300 4100
Text GLabel 2250 4300 0    60   Input ~ 0
D3
Wire Wire Line
	2300 4300 2250 4300
Text GLabel 3700 5150 0    60   Input ~ 0
D0
Text GLabel 3700 5050 0    60   Input ~ 0
D1
Text GLabel 3700 4950 0    60   Input ~ 0
D2
Text GLabel 3700 4850 0    60   Input ~ 0
D3
Text GLabel 3700 4750 0    60   Input ~ 0
D4
Text GLabel 3700 4650 0    60   Input ~ 0
D5
Text GLabel 3700 4550 0    60   Input ~ 0
D6
Text GLabel 3700 4450 0    60   Input ~ 0
D7
Text GLabel 3700 3600 2    60   Input ~ 0
D0
Text GLabel 3700 3500 2    60   Input ~ 0
D1
Text GLabel 3700 3400 2    60   Input ~ 0
D2
Text GLabel 3700 3300 2    60   Input ~ 0
D3
Text GLabel 3700 3200 2    60   Input ~ 0
D4
Text GLabel 3700 3100 2    60   Input ~ 0
D5
Text GLabel 3700 3000 2    60   Input ~ 0
D6
Text GLabel 3700 2900 2    60   Input ~ 0
D7
Text GLabel 6950 4950 0    60   Input ~ 0
D9
Text GLabel 8850 4950 0    60   Input ~ 0
D8
Text GLabel 3700 6150 0    60   Input ~ 0
D8
Text GLabel 3700 6050 0    60   Input ~ 0
D9
Text GLabel 3700 5950 0    60   Input ~ 0
D10
Text GLabel 3700 5850 0    60   Input ~ 0
D11
Text GLabel 3700 5750 0    60   Input ~ 0
D12
Text GLabel 3700 5650 0    60   Input ~ 0
D13
Text GLabel 3700 5550 0    60   Input ~ 0
DGND
Text GLabel 3700 5450 0    60   Input ~ 0
AREF
Text GLabel 5000 4950 0    60   Input ~ 0
D13
Text GLabel 5000 2650 0    60   Input ~ 0
D12
Text GLabel 4900 1400 0    60   Input ~ 0
D11
$Comp
L CONN_8 P11
U 1 1 5C3EFD0C
P 4050 5800
F 0 "P11" V 4000 5800 60  0000 C CNN
F 1 "CONN_8" V 4100 5800 60  0000 C CNN
F 2 "" H 4050 5800 60  0000 C CNN
F 3 "" H 4050 5800 60  0000 C CNN
	1    4050 5800
	1    0    0    -1  
$EndComp
Text GLabel 3700 2700 2    60   Input ~ 0
D8
Text GLabel 3700 2600 2    60   Input ~ 0
D9
Text GLabel 3700 2500 2    60   Input ~ 0
D10
Text GLabel 3700 2400 2    60   Input ~ 0
D11
Text GLabel 3700 2300 2    60   Input ~ 0
D12
Text GLabel 3700 2200 2    60   Input ~ 0
D13
Text GLabel 3700 2100 2    60   Input ~ 0
DGND
Text GLabel 3700 2000 2    60   Input ~ 0
AREF
Text GLabel 5500 2850 0    60   Input ~ 0
DGND
Text GLabel 5400 1600 0    60   Input ~ 0
DGND
$Comp
L CONN_2 P5
U 1 1 5C3F0699
P 3850 1500
F 0 "P5" V 3800 1500 40  0000 C CNN
F 1 "CONN_2" V 3900 1500 40  0000 C CNN
F 2 "" H 3850 1500 60  0000 C CNN
F 3 "" H 3850 1500 60  0000 C CNN
	1    3850 1500
	1    0    0    -1  
$EndComp
$Comp
L CONN_2 P4
U 1 1 5C3F069F
P 3150 1500
F 0 "P4" V 3100 1500 40  0000 C CNN
F 1 "CONN_2" V 3200 1500 40  0000 C CNN
F 2 "" H 3150 1500 60  0000 C CNN
F 3 "" H 3150 1500 60  0000 C CNN
	1    3150 1500
	-1   0    0    -1  
$EndComp
Text GLabel 5500 5150 0    60   Input ~ 0
DGND
Wire Wire Line
	6250 5150 6250 5200
Connection ~ 6250 5150
$Comp
L CONN_6 P1
U 1 1 5C3F096C
P 950 1100
F 0 "P1" V 900 1100 60  0000 C CNN
F 1 "CONN_6" V 1000 1100 60  0000 C CNN
F 2 "" H 950 1100 60  0000 C CNN
F 3 "" H 950 1100 60  0000 C CNN
	1    950  1100
	-1   0    0    1   
$EndComp
$Comp
L CONN_2 P2
U 1 1 5C3F0972
P 2100 1500
F 0 "P2" V 2050 1500 40  0000 C CNN
F 1 "CONN_2" V 2150 1500 40  0000 C CNN
F 2 "" H 2100 1500 60  0000 C CNN
F 3 "" H 2100 1500 60  0000 C CNN
	1    2100 1500
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2450 1400 2500 1400
Wire Wire Line
	2500 1600 2450 1600
Text GLabel 1300 850  2    60   Input ~ 0
RST
Text GLabel 1300 950  2    60   Input ~ 0
3V3
Text GLabel 1300 1050 2    60   Input ~ 0
5V
Text GLabel 1300 1150 2    60   Input ~ 0
DGND
Text GLabel 1300 1250 2    60   Input ~ 0
DGND
Text GLabel 1300 1350 2    60   Input ~ 0
V_IN
Text GLabel 1800 2400 0    60   Input ~ 0
RST
Text GLabel 1800 2500 0    60   Input ~ 0
3V3
Text GLabel 1800 2600 0    60   Input ~ 0
5V
Text GLabel 1800 2700 0    60   Input ~ 0
DGND
Text GLabel 1800 2800 0    60   Input ~ 0
DGND
Text GLabel 1800 2900 0    60   Input ~ 0
V_IN
Text GLabel 1300 1550 2    60   Input ~ 0
A0
Text GLabel 1300 1650 2    60   Input ~ 0
A1
Text GLabel 1300 1750 2    60   Input ~ 0
A2
Text GLabel 1300 1850 2    60   Input ~ 0
A3
Text GLabel 1300 1950 2    60   Input ~ 0
A4
Text GLabel 1300 2050 2    60   Input ~ 0
A5
Text GLabel 1800 3100 0    60   Input ~ 0
A0
Text GLabel 1800 3200 0    60   Input ~ 0
A1
Text GLabel 1800 3300 0    60   Input ~ 0
A2
Text GLabel 1800 3400 0    60   Input ~ 0
A3
Text GLabel 1800 3500 0    60   Input ~ 0
A4
Text GLabel 1800 3600 0    60   Input ~ 0
A5
Text GLabel 8150 5050 2    60   Input ~ 0
EX 5 V
Text GLabel 10050 5050 2    60   Input ~ 0
EX 5 V
$Comp
L R R11
U 1 1 5C3F0A84
P 8150 5500
F 0 "R11" V 8230 5500 40  0000 C CNN
F 1 "15k" V 8157 5501 40  0000 C CNN
F 2 "~" V 8080 5500 30  0000 C CNN
F 3 "~" H 8150 5500 30  0000 C CNN
	1    8150 5500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 5250 8150 5150
$Comp
L AGND #PWR02
U 1 1 5C3F0AE2
P 8150 5850
F 0 "#PWR02" H 8150 5850 40  0001 C CNN
F 1 "AGND" H 8150 5780 50  0000 C CNN
F 2 "" H 8150 5850 60  0000 C CNN
F 3 "" H 8150 5850 60  0000 C CNN
	1    8150 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 5850 8150 5750
Wire Wire Line
	8200 5200 8150 5200
Connection ~ 8150 5200
Text GLabel 7450 5150 0    60   Input ~ 0
DGND
$Comp
L R R12
U 1 1 5C3F0BA2
P 10050 5500
F 0 "R12" V 10130 5500 40  0000 C CNN
F 1 "15k" V 10057 5501 40  0000 C CNN
F 2 "~" V 9980 5500 30  0000 C CNN
F 3 "~" H 10050 5500 30  0000 C CNN
	1    10050 5500
	1    0    0    -1  
$EndComp
$Comp
L AGND #PWR03
U 1 1 5C3F0BA8
P 10050 5850
F 0 "#PWR03" H 10050 5850 40  0001 C CNN
F 1 "AGND" H 10050 5780 50  0000 C CNN
F 2 "" H 10050 5850 60  0000 C CNN
F 3 "" H 10050 5850 60  0000 C CNN
	1    10050 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	10050 5850 10050 5750
Wire Wire Line
	10050 5250 10050 5150
Wire Wire Line
	10050 5200 10150 5200
Connection ~ 10050 5200
Text GLabel 1850 4800 2    60   Input ~ 0
Tone1
Text GLabel 1850 4900 2    60   Input ~ 0
AGND
Text GLabel 1850 5000 2    60   Input ~ 0
Tone2
Text GLabel 1850 5100 2    60   Input ~ 0
AGND
Wire Wire Line
	6200 5150 6300 5150
$Comp
L AGND #PWR04
U 1 1 5C3F0CE1
P 6250 5750
F 0 "#PWR04" H 6250 5750 40  0001 C CNN
F 1 "AGND" H 6250 5680 50  0000 C CNN
F 2 "" H 6250 5750 60  0000 C CNN
F 3 "" H 6250 5750 60  0000 C CNN
	1    6250 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 5750 6250 5700
Text GLabel 1850 6100 2    60   Input ~ 0
Tone3
Text GLabel 1850 6200 2    60   Input ~ 0
AGND
$Comp
L CONN_2 P12
U 1 1 5C3F0D30
P 2300 6700
F 0 "P12" V 2250 6700 40  0000 C CNN
F 1 "CONN_2" V 2350 6700 40  0000 C CNN
F 2 "" H 2300 6700 60  0000 C CNN
F 3 "" H 2300 6700 60  0000 C CNN
	1    2300 6700
	1    0    0    -1  
$EndComp
Text GLabel 1950 6600 0    60   Input ~ 0
Spare1
Text GLabel 1950 6800 0    60   Input ~ 0
Spare2
Text GLabel 1850 5900 2    60   Input ~ 0
Spare1
Text GLabel 1850 6000 2    60   Input ~ 0
Spare2
$Comp
L R R2
U 1 1 5C3EFA73
P 6200 1900
F 0 "R2" V 6280 1900 40  0000 C CNN
F 1 "15k" V 6207 1901 40  0000 C CNN
F 2 "~" V 6130 1900 30  0000 C CNN
F 3 "~" H 6200 1900 30  0000 C CNN
	1    6200 1900
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 1600 6250 1600
Wire Wire Line
	6200 1600 6200 1650
Text GLabel 6250 1600 2    60   Input ~ 0
ULN_IN1
Connection ~ 6200 1600
Text GLabel 8150 1500 0    60   Input ~ 0
ULN_IN1
Text GLabel 6200 2750 2    60   Input ~ 0
EX 5 V
Text GLabel 6300 2850 2    60   Input ~ 0
ULN_IN2
Wire Wire Line
	6300 2850 6200 2850
Wire Wire Line
	6250 2850 6250 2900
Connection ~ 6250 2850
$Comp
L AGND #PWR05
U 1 1 5C3F0E1A
P 6200 2150
F 0 "#PWR05" H 6200 2150 40  0001 C CNN
F 1 "AGND" H 6200 2080 50  0000 C CNN
F 2 "" H 6200 2150 60  0000 C CNN
F 3 "" H 6200 2150 60  0000 C CNN
	1    6200 2150
	1    0    0    -1  
$EndComp
$Comp
L AGND #PWR06
U 1 1 5C3F0E20
P 6250 3400
F 0 "#PWR06" H 6250 3400 40  0001 C CNN
F 1 "AGND" H 6250 3330 50  0000 C CNN
F 2 "" H 6250 3400 60  0000 C CNN
F 3 "" H 6250 3400 60  0000 C CNN
	1    6250 3400
	1    0    0    -1  
$EndComp
Text GLabel 8150 1600 0    60   Input ~ 0
ULN_IN2
Text Notes 7350 4600 0    60   ~ 0
ToneDrivers\n
Text Notes 7200 1150 0    60   ~ 0
SolenoidDrivers\n
Text GLabel 9350 5150 0    60   Input ~ 0
DGND
$EndSCHEMATC
