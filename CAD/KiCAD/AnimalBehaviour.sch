EESchema Schematic File Version 4
LIBS:AnimalBehaviour-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector_Generic:Conn_01x08 P4
U 1 1 5C3EFA87
P 9900 2700
F 0 "P4" V 9850 2700 60  0000 C CNN
F 1 "CONN_8" V 9950 2700 60  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-08A_1x08_P2.54mm_Vertical" H 9900 2700 60  0001 C CNN
F 3 "" H 9900 2700 60  0000 C CNN
	1    9900 2700
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x06 P2
U 1 1 5C3EFA88
P 4550 2900
F 0 "P2" V 4500 2900 60  0000 C CNN
F 1 "CONN_6" V 4600 2900 60  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-06A_1x06_P2.54mm_Vertical" H 4550 2900 60  0001 C CNN
F 3 "" H 4550 2900 60  0000 C CNN
	1    4550 2900
	-1   0    0    1   
$EndComp
Text GLabel 2400 1950 2    60   Input ~ 0
D3
Text GLabel 2400 1850 2    60   Input ~ 0
D2
Text GLabel 9700 2900 0    60   Input ~ 0
D2
Text GLabel 9700 2800 0    60   Input ~ 0
D3
Text GLabel 9700 2700 0    60   Input ~ 0
D4
Text GLabel 9700 2600 0    60   Input ~ 0
D5
Text GLabel 9700 2500 0    60   Input ~ 0
D6
Text GLabel 9700 2400 0    60   Input ~ 0
D7
Text GLabel 8550 1450 2    60   Input ~ 0
D2
Text GLabel 8550 1550 2    60   Input ~ 0
D3
Text GLabel 8550 1650 2    60   Input ~ 0
D4
Text GLabel 8550 1750 2    60   Input ~ 0
D5
Text GLabel 8550 1850 2    60   Input ~ 0
D6
Text GLabel 8550 1950 2    60   Input ~ 0
D7
Text GLabel 9700 2200 0    60   Input ~ 0
D8
Text GLabel 9700 2100 0    60   Input ~ 0
D9
Text GLabel 9700 2000 0    60   Input ~ 0
D10
Text GLabel 9700 1900 0    60   Input ~ 0
D11
Text GLabel 9700 1800 0    60   Input ~ 0
D12
Text GLabel 9700 1700 0    60   Input ~ 0
D13
Text GLabel 9700 1600 0    60   Input ~ 0
DGND
Text GLabel 9700 1500 0    60   Input ~ 0
AREF
Text GLabel 8550 2050 2    60   Input ~ 0
D8
Text GLabel 8550 2150 2    60   Input ~ 0
D9
Text GLabel 8550 2250 2    60   Input ~ 0
D10
Text GLabel 8550 2350 2    60   Input ~ 0
D11
Text GLabel 8550 2450 2    60   Input ~ 0
D12
Text GLabel 8550 2550 2    60   Input ~ 0
D13
$Comp
L Connector_Generic:Conn_01x06 P1
U 1 1 5C3F096C
P 4550 2200
F 0 "P1" V 4500 2200 60  0000 C CNN
F 1 "CONN_6" V 4600 2200 60  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-06A_1x06_P2.54mm_Vertical" H 4550 2200 60  0001 C CNN
F 3 "" H 4550 2200 60  0000 C CNN
	1    4550 2200
	-1   0    0    1   
$EndComp
Text GLabel 4750 1900 2    60   Input ~ 0
RST
Text GLabel 4750 2000 2    60   Input ~ 0
3V3
Text GLabel 4750 2100 2    60   Input ~ 0
5V
Text GLabel 4750 2200 2    60   Input ~ 0
DGND
Text GLabel 4750 2300 2    60   Input ~ 0
DGND
Text GLabel 4750 2400 2    60   Input ~ 0
V_IN
Text GLabel 8550 3450 2    60   Input ~ 0
RST
Text GLabel 5950 3350 0    60   Input ~ 0
3V3
Text GLabel 5950 3450 0    60   Input ~ 0
5V
Text GLabel 5950 3050 0    60   Input ~ 0
DGND
Text GLabel 5950 3550 0    60   Input ~ 0
V_IN
Text GLabel 4750 2600 2    60   Input ~ 0
A0
Text GLabel 4750 2700 2    60   Input ~ 0
A1
Text GLabel 4750 2800 2    60   Input ~ 0
A2
Text GLabel 4750 2900 2    60   Input ~ 0
A3
Text GLabel 4750 3000 2    60   Input ~ 0
A4
Text GLabel 4750 3100 2    60   Input ~ 0
A5
Text GLabel 5950 2650 0    60   Input ~ 0
A0
Text GLabel 5950 2550 0    60   Input ~ 0
A1
Text GLabel 5950 2450 0    60   Input ~ 0
A2
Text GLabel 5950 2350 0    60   Input ~ 0
A3
Text GLabel 5950 2250 0    60   Input ~ 0
A4
Text GLabel 5950 2150 0    60   Input ~ 0
A5
Text Notes 6150 1150 0    60   ~ 0
Arduino  Uno\n
Text Notes 1800 1450 0    60   ~ 12
For Encoder\n
$Comp
L Connector:Conn_01x04_Male J3
U 1 1 5D1F16AB
P 1600 1950
F 0 "J3" H 1200 2150 50  0000 C CNN
F 1 "Conn_01x04_Male" H 1200 2000 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-04A_1x04_P2.54mm_Vertical" H 1600 1950 50  0001 C CNN
F 3 "~" H 1600 1950 50  0001 C CNN
	1    1600 1950
	1    0    0    -1  
$EndComp
Text GLabel 2400 2050 2    60   Input ~ 0
Vcc
Text GLabel 2400 2150 2    60   Input ~ 0
DGND
Wire Wire Line
	1800 2050 2400 2050
Wire Wire Line
	1800 2150 2250 2150
Text GLabel 1950 5100 2    60   Input ~ 0
D6
Text GLabel 1950 4900 2    60   Input ~ 0
D4
Text GLabel 1900 4650 2    60   Input ~ 0
Vcc
Text Notes 1850 4250 0    50   ~ 10
SSR Relay\n
Wire Wire Line
	2250 2200 2250 2150
Connection ~ 2250 2150
Wire Wire Line
	2250 2150 2400 2150
Text Notes 5650 6300 0    50   ~ 10
LED\n
Text Notes 1600 6300 0    50   ~ 10
Tone\n
$Comp
L Connector:Conn_01x02_Male J2
U 1 1 5D21EE74
P 1250 6700
F 0 "J2" H 1358 6881 50  0000 C CNN
F 1 "Conn_01x02_Male" H 1358 6790 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 1250 6700 50  0001 C CNN
F 3 "~" H 1250 6700 50  0001 C CNN
	1    1250 6700
	1    0    0    -1  
$EndComp
Text GLabel 1750 6800 2    60   Input ~ 0
DGND
Wire Wire Line
	1750 6800 1450 6800
Text GLabel 1750 6700 2    60   Input ~ 0
D8
Wire Wire Line
	1450 6700 1750 6700
$Comp
L Isolator:4N35 U1
U 1 1 5D2209DC
P 8850 4250
F 0 "U1" H 8850 4575 50  0000 C CNN
F 1 "4N35" H 8850 4484 50  0000 C CNN
F 2 "Package_DIP:DIP-6_W7.62mm_Socket" H 8650 4050 50  0001 L CIN
F 3 "https://www.vishay.com/docs/81181/4n35.pdf" H 8850 4250 50  0001 L CNN
	1    8850 4250
	1    0    0    -1  
$EndComp
$Comp
L AnimalBehaviour-rescue:R-ArduinoEncoderShield_anzal-rescue-AnimalBehaviour-rescue R3
U 1 1 5D221F97
P 8300 4150
F 0 "R3" V 8115 4150 40  0000 C CNN
F 1 "470E" V 8191 4150 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P25.40mm_Horizontal" V 8230 4150 30  0001 C CNN
F 3 "" H 8300 4150 30  0000 C CNN
	1    8300 4150
	0    1    1    0   
$EndComp
Text GLabel 8050 4150 0    60   Input ~ 0
D11
Text GLabel 8550 4350 0    60   Input ~ 0
DGND
$Comp
L AnimalBehaviour-rescue:R-ArduinoEncoderShield_anzal-rescue-AnimalBehaviour-rescue R4
U 1 1 5D222B56
P 9200 4650
F 0 "R4" H 9271 4688 40  0000 L CNN
F 1 "10K" H 9271 4612 40  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P25.40mm_Horizontal" V 9130 4650 30  0001 C CNN
F 3 "" H 9200 4650 30  0000 C CNN
	1    9200 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 4350 9200 4350
Wire Wire Line
	9200 4350 9200 4400
Text GLabel 9200 5000 0    60   Input ~ 0
AGND
Wire Wire Line
	9200 5000 9200 4950
Wire Wire Line
	9200 4250 9150 4250
Connection ~ 9200 4350
$Comp
L Transistor_FET:IRF540N Q1
U 1 1 5D2269C5
P 9850 4350
F 0 "Q1" H 10056 4396 50  0000 L CNN
F 1 "IRF540N" H 10056 4305 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Horizontal_TabDown" H 10100 4275 50  0001 L CIN
F 3 "http://www.irf.com/product-info/datasheets/data/irf540n.pdf" H 9850 4350 50  0001 L CNN
	1    9850 4350
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 4350 9650 4350
Wire Wire Line
	9950 4550 9950 4950
Wire Wire Line
	9950 4950 9200 4950
Connection ~ 9200 4950
Wire Wire Line
	9200 4950 9200 4900
$Comp
L Connector:Conn_01x02_Male J12
U 1 1 5D2282D7
P 10150 3950
F 0 "J12" H 10122 3924 50  0000 R CNN
F 1 "Conn_01x02_Male" H 10122 3833 50  0000 R CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 10150 3950 50  0001 C CNN
F 3 "~" H 10150 3950 50  0001 C CNN
	1    10150 3950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9950 3650 9950 3750
Wire Wire Line
	9950 4050 9950 4150
$Comp
L AnimalBehaviour-rescue:DIODE-ArduinoEncoderShield_anzal-rescue-AnimalBehaviour-rescue D1
U 1 1 5D22A71C
P 9700 3950
F 0 "D1" V 9738 3872 40  0000 R CNN
F 1 "DIODE" V 9662 3872 40  0000 R CNN
F 2 "Diode_THT:D_DO-15_P12.70mm_Horizontal" H 9700 3950 60  0001 C CNN
F 3 "" H 9700 3950 60  0000 C CNN
	1    9700 3950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9700 4150 9950 4150
Connection ~ 9950 4150
Wire Wire Line
	9700 3750 9950 3750
Connection ~ 9950 3750
Wire Wire Line
	9950 3750 9950 3950
Text Notes 9000 3550 0    50   ~ 10
Solenoid driver\n
Text GLabel 5150 4600 0    60   Input ~ 0
D7
Text GLabel 5150 4700 0    60   Input ~ 0
DGND
Text Notes 5350 4300 0    50   ~ 10
Stimulator\n\n
$Comp
L Connector:Conn_01x06_Male J1
U 1 1 5D22F64E
P 1150 4850
F 0 "J1" H 1258 5231 50  0000 C CNN
F 1 "Conn_01x06_Male" H 1258 5140 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-06A_1x06_P2.54mm_Vertical" H 1150 4850 50  0001 C CNN
F 3 "~" H 1150 4850 50  0001 C CNN
	1    1150 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 4650 1900 4650
Wire Wire Line
	1350 4750 1900 4750
Text GLabel 9450 6100 0    60   Input ~ 0
AGND
Wire Wire Line
	9450 6100 9550 6100
Text GLabel 9450 5900 0    60   Input ~ 0
EX_12V
Wire Wire Line
	9450 5900 9550 5900
Text GLabel 9950 3650 2    60   Input ~ 0
EX_12V
$Comp
L Connector:Conn_01x03_Male J11
U 1 1 5D2389C2
P 9750 6000
F 0 "J11" H 9722 6024 50  0000 R CNN
F 1 "Conn_01x03_Male" H 9722 5933 50  0000 R CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-03A_1x03_P2.54mm_Vertical" H 9750 6000 50  0001 C CNN
F 3 "~" H 9750 6000 50  0001 C CNN
	1    9750 6000
	-1   0    0    -1  
$EndComp
Text GLabel 9450 6000 0    60   Input ~ 0
EX_5V
Wire Wire Line
	9450 6000 9550 6000
Text GLabel 9200 3750 0    60   Input ~ 0
EX_5V
Wire Wire Line
	9200 3750 9200 4250
Text Notes 9250 5650 0    50   ~ 10
External supply\n
$Comp
L Connector:Conn_01x02_Male J5
U 1 1 5D25B035
P 2650 6700
F 0 "J5" H 2758 6881 50  0000 C CNN
F 1 "Conn_01x02_Male" H 2758 6790 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 2650 6700 50  0001 C CNN
F 3 "~" H 2650 6700 50  0001 C CNN
	1    2650 6700
	1    0    0    -1  
$EndComp
Text GLabel 3150 6800 2    60   Input ~ 0
DGND
Wire Wire Line
	3150 6800 2850 6800
Text GLabel 3150 6700 2    60   Input ~ 0
D12
Wire Wire Line
	2850 6700 3150 6700
Text Notes 2900 6300 0    50   ~ 10
Imaging Trig\n
$Comp
L Connector:Conn_01x02_Male J8
U 1 1 5D25BBED
P 3950 6700
F 0 "J8" H 4058 6881 50  0000 C CNN
F 1 "Conn_01x02_Male" H 4058 6790 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 3950 6700 50  0001 C CNN
F 3 "~" H 3950 6700 50  0001 C CNN
	1    3950 6700
	1    0    0    -1  
$EndComp
Text GLabel 4450 6800 2    60   Input ~ 0
DGND
Wire Wire Line
	4450 6800 4150 6800
Text GLabel 4450 6700 2    60   Input ~ 0
D10
Wire Wire Line
	4150 6700 4450 6700
Text Notes 4200 6400 0    50   ~ 10
CAM\n\n
$Comp
L Device:R_POT RV1
U 1 1 5D261470
P 6900 4750
F 0 "RV1" H 6831 4796 50  0000 R CNN
F 1 "1 MegOhm" H 6831 4705 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_ACP_CA14V-15_Vertical_Hole" H 6900 4750 50  0001 C CNN
F 3 "~" H 6900 4750 50  0001 C CNN
	1    6900 4750
	1    0    0    -1  
$EndComp
$Comp
L AnimalBehaviour-rescue:R-ArduinoEncoderShield_anzal-rescue-AnimalBehaviour-rescue R2
U 1 1 5D261F4B
P 6900 5250
F 0 "R2" H 6971 5288 40  0000 L CNN
F 1 "1K" H 6971 5212 40  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P25.40mm_Horizontal" V 6830 5250 30  0001 C CNN
F 3 "" H 6900 5250 30  0000 C CNN
	1    6900 5250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5D263290
P 7250 5300
F 0 "C1" H 7365 5346 50  0000 L CNN
F 1 "47nF" H 7365 5255 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 7288 5150 50  0001 C CNN
F 3 "~" H 7250 5300 50  0001 C CNN
	1    7250 5300
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J9
U 1 1 5D263EAD
P 5500 4600
F 0 "J9" H 5600 4575 50  0000 L CNN
F 1 "Conn_Coaxial" H 5600 4484 50  0000 L CNN
F 2 "Connector_Coaxial:BNC_TEConnectivity_1478204_Vertical" H 5500 4600 50  0001 C CNN
F 3 " ~" H 5500 4600 50  0001 C CNN
	1    5500 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 4600 5300 4600
Wire Wire Line
	5150 4700 5350 4700
Wire Wire Line
	5350 4700 5350 4800
Wire Wire Line
	5350 4800 5500 4800
$Comp
L Connector:Conn_01x08_Male J4
U 1 1 5D26665C
P 2650 4850
F 0 "J4" H 2758 5331 50  0000 C CNN
F 1 "Conn_01x08_Male" H 2758 5240 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-08A_1x08_P2.54mm_Vertical" H 2650 4850 50  0001 C CNN
F 3 "~" H 2650 4850 50  0001 C CNN
	1    2650 4850
	1    0    0    -1  
$EndComp
Text GLabel 2850 4550 2    60   Input ~ 0
D5
Text GLabel 2850 4750 2    60   Input ~ 0
A0
Wire Wire Line
	6900 5500 7250 5500
Wire Wire Line
	7250 5500 7250 5450
Wire Wire Line
	6900 4600 6900 4550
Wire Wire Line
	6900 4550 7250 4550
Wire Wire Line
	7250 4550 7250 5150
Text GLabel 6550 4550 0    60   Input ~ 0
A0
Wire Wire Line
	6550 4550 6900 4550
Connection ~ 6900 4550
Text GLabel 2850 4950 2    60   Input ~ 0
OUT+
Text GLabel 2850 5150 2    60   Input ~ 0
OUT-
$Comp
L Connector:Jack-DC J7
U 1 1 5D26C0F3
P 3850 4650
F 0 "J7" H 3907 4975 50  0000 C CNN
F 1 "Jack-DC" H 3907 4884 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_CUI_PJ-063AH_Horizontal" H 3900 4610 50  0001 C CNN
F 3 "~" H 3900 4610 50  0001 C CNN
	1    3850 4650
	1    0    0    -1  
$EndComp
Text GLabel 4150 4550 2    60   Input ~ 0
OUT+
Text GLabel 4150 4750 2    60   Input ~ 0
OUT-
$Comp
L Connector:Conn_01x02_Male J6
U 1 1 5D26CA03
P 3700 5050
F 0 "J6" H 3808 5231 50  0000 C CNN
F 1 "Conn_01x02_Male" H 3808 5140 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 3700 5050 50  0001 C CNN
F 3 "~" H 3700 5050 50  0001 C CNN
	1    3700 5050
	1    0    0    -1  
$EndComp
Text GLabel 3900 5050 2    60   Input ~ 0
PAD+
Text GLabel 3900 5150 2    60   Input ~ 0
PAD-
Text GLabel 6750 5500 0    60   Input ~ 0
DGND
Wire Wire Line
	6750 5500 6900 5500
Connection ~ 6900 5500
Wire Wire Line
	6900 5000 7050 5000
Wire Wire Line
	7050 5000 7050 4750
Text GLabel 2850 4650 2    60   Input ~ 0
PAD+
Text GLabel 2850 4850 2    60   Input ~ 0
PAD-
Text GLabel 2850 5050 2    60   Input ~ 0
PAD+
Text GLabel 2850 5250 2    60   Input ~ 0
PAD-
Wire Wire Line
	1350 4850 1350 4900
Wire Wire Line
	1350 4900 1950 4900
Connection ~ 1350 4900
Wire Wire Line
	1350 4900 1350 4950
Wire Wire Line
	1350 5100 1350 5050
Wire Wire Line
	1350 5100 1950 5100
Wire Wire Line
	1350 5150 1350 5100
Connection ~ 1350 5100
Text GLabel 2000 3600 2    60   Input ~ 0
Vcc
Text GLabel 1750 3600 0    60   Input ~ 0
5V
Wire Wire Line
	1750 3600 2000 3600
Text GLabel 5250 6700 0    60   Input ~ 0
D9
Text Notes 4600 800  0    60   ~ 0
Extra pin for new arduino version\n
$Comp
L AnimalBehaviour-rescue:R-ArduinoEncoderShield_anzal-rescue-AnimalBehaviour-rescue R1
U 1 1 5D21C427
P 5500 6700
F 0 "R1" V 5315 6700 40  0000 C CNN
F 1 "470E" V 5391 6700 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P25.40mm_Horizontal" V 5430 6700 30  0001 C CNN
F 3 "" H 5500 6700 30  0000 C CNN
	1    5500 6700
	0    1    1    0   
$EndComp
Text GLabel 5400 6800 0    60   Input ~ 0
DGND
$Comp
L Connector:Conn_01x02_Male J10
U 1 1 5D2AE3AD
P 6050 6700
F 0 "J10" H 6022 6674 50  0000 R CNN
F 1 "Conn_01x02_Male" H 6022 6583 50  0000 R CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 6050 6700 50  0001 C CNN
F 3 "~" H 6050 6700 50  0001 C CNN
	1    6050 6700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5400 6800 5850 6800
Wire Wire Line
	5850 6700 5750 6700
Wire Wire Line
	1800 1850 2400 1850
Wire Wire Line
	1800 1950 2400 1950
NoConn ~ 6900 4900
$Comp
L power:GNDD #PWR02
U 1 1 5D2143A2
P 2250 2200
F 0 "#PWR02" H 2250 1950 50  0001 C CNN
F 1 "GNDD" H 2254 2045 50  0000 C CNN
F 2 "" H 2250 2200 50  0001 C CNN
F 3 "" H 2250 2200 50  0001 C CNN
	1    2250 2200
	1    0    0    -1  
$EndComp
$Comp
L power:GNDD #PWR01
U 1 1 5D2152C0
P 1900 4750
F 0 "#PWR01" H 1900 4500 50  0001 C CNN
F 1 "GNDD" V 1904 4640 50  0000 R CNN
F 2 "" H 1900 4750 50  0001 C CNN
F 3 "" H 1900 4750 50  0001 C CNN
	1    1900 4750
	0    -1   -1   0   
$EndComp
NoConn ~ 5950 3150
Text GLabel 5950 2750 0    60   Input ~ 0
AREF
$Comp
L Connector_Generic:Conn_01x08 P3
U 1 1 5C3EFD0C
P 9900 1800
F 0 "P3" V 9850 1800 60  0000 C CNN
F 1 "CONN_8" V 9950 1800 60  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-08A_1x08_P2.54mm_Vertical" H 9900 1800 60  0001 C CNN
F 3 "" H 9900 1800 60  0000 C CNN
	1    9900 1800
	1    0    0    -1  
$EndComp
NoConn ~ 9150 4150
$Comp
L arduino:Arduino_Uno_Shield XA1
U 1 1 5D1FCEB8
P 7250 2500
F 0 "XA1" H 7250 3887 60  0000 C CNN
F 1 "Arduino_Uno_Shield" H 7250 3781 60  0000 C CNN
F 2 "Arduino:Arduino_Uno_Shield" H 9050 6250 60  0001 C CNN
F 3 "https://store.arduino.cc/arduino-uno-rev3" H 9050 6250 60  0001 C CNN
	1    7250 2500
	1    0    0    -1  
$EndComp
NoConn ~ 9700 3100
NoConn ~ 9700 3000
NoConn ~ 5950 1450
NoConn ~ 5950 1550
NoConn ~ 5950 1750
NoConn ~ 5950 1850
$EndSCHEMATC
