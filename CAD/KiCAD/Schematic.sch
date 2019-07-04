EESchema Schematic File Version 4
LIBS:Schematic-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "MouseBehaviour"
Date "2019-07-04"
Rev "2.0.0"
Comp "BhallaLab, NCBS Bangalore"
Comment1 "Dorababu and Dilawar Singh"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Isolator:4N35 IC2
U 1 1 5C3EFA70
P 7175 800
F 0 "IC2" H 6961 979 40  0000 C CNN
F 1 "4N35" H 7355 615 40  0000 C CNN
F 2 "Package_DIP:DIP-6_W7.62mm_Socket" H 6976 620 29  0001 C CNN
F 3 "" H 7175 800 60  0001 C CNN
	1    7175 800 
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:ULN2003A-DoraBabu U1
U 1 1 5C3EFA71
P 9300 1225
F 0 "U1" H 9300 1325 70  0000 C CNN
F 1 "ULN2003A" H 9300 1125 70  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm_Socket" H 9300 1225 60  0001 C CNN
F 3 "" H 9300 1225 60  0001 C CNN
	1    9300 1225
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:DIODE-DoraBabu D1
U 1 1 5C3EFA72
P 10300 1625
F 0 "D1" H 10300 1725 40  0000 C CNN
F 1 "DIODE" H 10300 1525 40  0000 C CNN
F 2 "Diode_THT:D_5KPW_P12.70mm_Horizontal" H 10300 1625 60  0001 C CNN
F 3 "~" H 10300 1625 60  0000 C CNN
	1    10300 1625
	-1   0    0    1   
$EndComp
$Comp
L Isolator:4N35 IC3
U 1 1 5C3EFA75
P 7175 1800
F 0 "IC3" H 6961 1979 40  0000 C CNN
F 1 "4N35" H 7355 1615 40  0000 C CNN
F 2 "Package_DIP:DIP-6_W7.62mm_Socket" H 6976 1620 29  0001 C CNN
F 3 "" H 7175 1800 60  0001 C CNN
	1    7175 1800
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:R-DoraBabu R8
U 1 1 5C3EFA76
P 7575 2200
F 0 "R8" V 7655 2200 40  0000 C CNN
F 1 "15k" V 7582 2201 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 7505 2200 30  0001 C CNN
F 3 "~" H 7575 2200 30  0001 C CNN
	1    7575 2200
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:R-DoraBabu R6
U 1 1 5C3EFA82
P 6575 1700
F 0 "R6" V 6655 1700 40  0000 C CNN
F 1 "470E" V 6582 1701 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 6505 1700 30  0001 C CNN
F 3 "~" H 6575 1700 30  0000 C CNN
	1    6575 1700
	0    -1   -1   0   
$EndComp
$Comp
L Schematic-rescue:R-DoraBabu R5
U 1 1 5C3EFA83
P 6575 700
F 0 "R5" V 6475 700 40  0000 C CNN
F 1 "470E" V 6582 701 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 6505 700 30  0001 C CNN
F 3 "~" H 6575 700 30  0000 C CNN
	1    6575 700 
	0    -1   -1   0   
$EndComp
$Comp
L Schematic-rescue:R-DoraBabu R10
U 1 1 5C3EFA84
P 7925 5425
F 0 "R10" V 8005 5425 40  0000 C CNN
F 1 "560E" V 7932 5426 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 7855 5425 30  0001 C CNN
F 3 "~" H 7925 5425 30  0001 C CNN
	1    7925 5425
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
Text GLabel 7525 800  2    60   Input ~ 0
EX 5 V
Text GLabel 10750 1625 2    60   Input ~ 0
12 V
$Comp
L Schematic-rescue:CONN_8-DoraBabu P8
U 1 1 5C3EFA87
P 3475 5100
F 0 "P8" V 3425 5100 60  0000 C CNN
F 1 "CONN_8" V 3525 5100 60  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x08_P2.54mm_Horizontal" H 3475 5100 60  0001 C CNN
F 3 "" H 3475 5100 60  0000 C CNN
	1    3475 5100
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:CONN_6-DoraBabu P2
U 1 1 5C3EFA88
P 950 1800
F 0 "P2" V 900 1800 60  0000 C CNN
F 1 "CONN_6" V 1000 1800 60  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x07_P2.54mm_Horizontal" H 950 1800 60  0001 C CNN
F 3 "" H 950 1800 60  0000 C CNN
	1    950  1800
	-1   0    0    1   
$EndComp
Text GLabel 10450 1875 2    60   Input ~ 0
Solenoid1_1
Text GLabel 10200 925  2    60   Input ~ 0
Solenoid1_2
Text GLabel 10450 2025 2    60   Input ~ 0
Solenoid2_1
Text GLabel 10200 825  2    60   Input ~ 0
Solenoid2_2
$Comp
L Schematic-rescue:HDR-1X15-15-91-?-DoraBabu CN1
U 1 1 5C3EFA8D
P 1650 5500
F 0 "CN1" H 1575 6300 50  0000 L BNN
F 1 "OutputPad" H 1575 4638 50  0000 L BNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x15_P2.54mm_Horizontal" H 1650 5650 50  0001 C CNN
F 3 "" H 1650 5500 60  0001 C CNN
	1    1650 5500
	-1   0    0    1   
$EndComp
$Comp
L Schematic-rescue:R-DoraBabu R12
U 1 1 5C3EFA8E
P 9825 5425
F 0 "R12" V 9905 5425 40  0000 C CNN
F 1 "560E" V 9832 5426 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 9755 5425 30  0001 C CNN
F 3 "~" H 9825 5425 30  0001 C CNN
	1    9825 5425
	0    -1   -1   0   
$EndComp
$Comp
L Isolator:4N35 IC4
U 1 1 5C3EFA8F
P 8525 5525
F 0 "IC4" H 8525 5885 40  0000 C CNN
F 1 "4N35" H 8525 5809 40  0000 C CNN
F 2 "Package_DIP:DIP-6_W7.62mm_Socket" H 8525 5742 29  0001 C CNN
F 3 "" H 8525 5525 60  0001 C CNN
	1    8525 5525
	1    0    0    -1  
$EndComp
$Comp
L Isolator:4N35 IC5
U 1 1 5C3EFA90
P 10425 5525
F 0 "IC5" H 10211 5704 40  0000 C CNN
F 1 "4N35" H 10605 5340 40  0000 C CNN
F 2 "Package_DIP:DIP-6_W7.62mm_Socket" H 10226 5345 29  0001 C CNN
F 3 "" H 10425 5525 60  0001 C CNN
	1    10425 5525
	1    0    0    -1  
$EndComp
Text GLabel 8925 5675 2    60   Input ~ 0
Tone1
Text GLabel 10875 5675 2    60   Input ~ 0
Tone2
Text GLabel 7025 5625 2    60   Input ~ 0
Tone3
Text GLabel 6925 5525 2    60   Input ~ 0
EX 5 V
Wire Wire Line
	10500 1625 10750 1625
Wire Wire Line
	10050 1875 10450 1875
Wire Wire Line
	10050 2025 10450 2025
Wire Wire Line
	9950 925  10200 925 
Wire Wire Line
	9950 825  10200 825 
Wire Wire Line
	9950 1625 10050 1625
Wire Wire Line
	10050 1625 10050 1875
Connection ~ 10050 1625
Connection ~ 10050 1875
$Comp
L Schematic-rescue:CONN_2-DoraBabu P7
U 1 1 5C3EFA9B
P 3200 4200
F 0 "P7" V 3150 4200 40  0000 C CNN
F 1 "CONN_2" V 3250 4200 40  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x01_P2.54mm_Vertical" H 3200 4200 60  0001 C CNN
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
Text GLabel 3125 5450 0    60   Input ~ 0
D0
Text GLabel 3125 5350 0    60   Input ~ 0
D1
Text GLabel 3125 5250 0    60   Input ~ 0
D2
Text GLabel 3125 5150 0    60   Input ~ 0
D3
Text GLabel 3125 5050 0    60   Input ~ 0
D4
Text GLabel 3125 4950 0    60   Input ~ 0
D5
Text GLabel 3125 4850 0    60   Input ~ 0
D6
Text GLabel 3125 4750 0    60   Input ~ 0
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
Text GLabel 7675 5425 0    60   Input ~ 0
D9
Text GLabel 9575 5425 0    60   Input ~ 0
D8
Text GLabel 3125 6450 0    60   Input ~ 0
D8
Text GLabel 3125 6350 0    60   Input ~ 0
D9
Text GLabel 3125 6250 0    60   Input ~ 0
D10
Text GLabel 3125 6150 0    60   Input ~ 0
D11
Text GLabel 3125 6050 0    60   Input ~ 0
D12
Text GLabel 3125 5950 0    60   Input ~ 0
D13
Text GLabel 3125 5850 0    60   Input ~ 0
DGND
Text GLabel 5725 5425 0    60   Input ~ 0
D13
Text GLabel 6325 1700 0    60   Input ~ 0
D12
Text GLabel 6325 700  0    60   Input ~ 0
D11
$Comp
L Schematic-rescue:CONN_8-DoraBabu P9
U 1 1 5C3EFD0C
P 3475 6100
F 0 "P9" V 3425 6100 60  0000 C CNN
F 1 "CONN_8" V 3525 6100 60  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x08_P2.54mm_Horizontal" H 3475 6100 60  0001 C CNN
F 3 "" H 3475 6100 60  0000 C CNN
	1    3475 6100
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
Text GLabel 6825 1900 0    60   Input ~ 0
DGND
Text GLabel 6825 900  0    60   Input ~ 0
DGND
Text GLabel 6225 5625 0    60   Input ~ 0
DGND
Wire Wire Line
	6975 5625 6975 5675
Connection ~ 6975 5625
$Comp
L Schematic-rescue:CONN_6-DoraBabu P1
U 1 1 5C3F096C
P 950 1100
F 0 "P1" V 900 1100 60  0000 C CNN
F 1 "CONN_6" V 1000 1100 60  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x07_P2.54mm_Horizontal" H 950 1100 60  0001 C CNN
F 3 "" H 950 1100 60  0000 C CNN
	1    950  1100
	-1   0    0    1   
$EndComp
Text GLabel 1300 850  2    60   Input ~ 0
RST
Text GLabel 1300 1050 2    60   Input ~ 0
5V
Text GLabel 1300 1150 2    60   Input ~ 0
DGND
Text GLabel 1300 1250 2    60   Input ~ 0
DGND
Text GLabel 1800 2400 0    60   Input ~ 0
RST
Text GLabel 1800 2600 0    60   Input ~ 0
5V
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
Text GLabel 8875 5525 2    60   Input ~ 0
EX 5 V
Text GLabel 10775 5525 2    60   Input ~ 0
EX 5 V
$Comp
L Schematic-rescue:R-DoraBabu R11
U 1 1 5C3F0A84
P 8875 5975
F 0 "R11" V 8955 5975 40  0000 C CNN
F 1 "15k" V 8882 5976 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 8805 5975 30  0001 C CNN
F 3 "~" H 8875 5975 30  0001 C CNN
	1    8875 5975
	1    0    0    -1  
$EndComp
Wire Wire Line
	8875 5725 8875 5675
$Comp
L Schematic-rescue:AGND-DoraBabu #PWR05
U 1 1 5C3F0AE2
P 8875 6325
F 0 "#PWR05" H 8875 6325 40  0001 C CNN
F 1 "AGND" H 8875 6255 50  0000 C CNN
F 2 "" H 8875 6325 60  0000 C CNN
F 3 "" H 8875 6325 60  0000 C CNN
	1    8875 6325
	1    0    0    -1  
$EndComp
Wire Wire Line
	8875 6325 8875 6225
Wire Wire Line
	8925 5675 8875 5675
Connection ~ 8875 5675
Text GLabel 8175 5625 0    60   Input ~ 0
DGND
$Comp
L Schematic-rescue:R-DoraBabu R13
U 1 1 5C3F0BA2
P 10775 5975
F 0 "R13" V 10855 5975 40  0000 C CNN
F 1 "15k" V 10782 5976 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 10705 5975 30  0001 C CNN
F 3 "~" H 10775 5975 30  0001 C CNN
	1    10775 5975
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:AGND-DoraBabu #PWR07
U 1 1 5C3F0BA8
P 10775 6325
F 0 "#PWR07" H 10775 6325 40  0001 C CNN
F 1 "AGND" H 10775 6255 50  0000 C CNN
F 2 "" H 10775 6325 60  0000 C CNN
F 3 "" H 10775 6325 60  0000 C CNN
	1    10775 6325
	1    0    0    -1  
$EndComp
Wire Wire Line
	10775 6325 10775 6225
Wire Wire Line
	10775 5725 10775 5675
Wire Wire Line
	10775 5675 10875 5675
Connection ~ 10775 5675
Text GLabel 1850 4800 2    60   Input ~ 0
Tone1
Text GLabel 1850 4900 2    60   Input ~ 0
AGND
Text GLabel 1850 5000 2    60   Input ~ 0
Tone2
Text GLabel 1850 5100 2    60   Input ~ 0
AGND
$Comp
L Schematic-rescue:AGND-DoraBabu #PWR02
U 1 1 5C3F0CE1
P 6975 6225
F 0 "#PWR02" H 6975 6225 40  0001 C CNN
F 1 "AGND" H 6975 6155 50  0000 C CNN
F 2 "" H 6975 6225 60  0000 C CNN
F 3 "" H 6975 6225 60  0000 C CNN
	1    6975 6225
	1    0    0    -1  
$EndComp
Wire Wire Line
	6975 6225 6975 6175
Text GLabel 1850 6100 2    60   Input ~ 0
Tone3
Text GLabel 1850 6200 2    60   Input ~ 0
AGND
Text GLabel 1950 6600 0    60   Input ~ 0
Spare1
Text GLabel 1950 6800 0    60   Input ~ 0
Spare2
Text GLabel 1850 5900 2    60   Input ~ 0
Spare1
Text GLabel 1850 6000 2    60   Input ~ 0
Spare2
$Comp
L Schematic-rescue:R-DoraBabu R9
U 1 1 5C3EFA73
P 7625 1200
F 0 "R9" V 7705 1200 40  0000 C CNN
F 1 "15k" V 7632 1201 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 7555 1200 30  0001 C CNN
F 3 "~" H 7625 1200 30  0001 C CNN
	1    7625 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	7625 900  7625 950 
Text GLabel 7675 900  2    60   Input ~ 0
ULN_IN1
Connection ~ 7625 900 
Text GLabel 8650 825  0    60   Input ~ 0
ULN_IN1
Text GLabel 7525 1800 2    60   Input ~ 0
EX 5 V
Text GLabel 7625 1900 2    60   Input ~ 0
ULN_IN2
Wire Wire Line
	7625 1900 7575 1900
Wire Wire Line
	7575 1900 7575 1950
$Comp
L Schematic-rescue:AGND-DoraBabu #PWR04
U 1 1 5C3F0E1A
P 7625 1450
F 0 "#PWR04" H 7625 1450 40  0001 C CNN
F 1 "AGND" H 7625 1380 50  0000 C CNN
F 2 "" H 7625 1450 60  0000 C CNN
F 3 "" H 7625 1450 60  0000 C CNN
	1    7625 1450
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:AGND-DoraBabu #PWR03
U 1 1 5C3F0E20
P 7575 2450
F 0 "#PWR03" H 7575 2450 40  0001 C CNN
F 1 "AGND" H 7575 2380 50  0000 C CNN
F 2 "" H 7575 2450 60  0000 C CNN
F 3 "" H 7575 2450 60  0000 C CNN
	1    7575 2450
	1    0    0    -1  
$EndComp
Text GLabel 8650 925  0    60   Input ~ 0
ULN_IN2
Text Notes 8075 5075 0    60   ~ 0
ToneDrivers\n
Text Notes 8250 650  0    60   ~ 0
SolenoidDrivers\n
Text GLabel 10075 5625 0    60   Input ~ 0
DGND
Wire Wire Line
	10050 1625 10100 1625
Wire Wire Line
	10050 1875 10050 2025
Wire Wire Line
	6975 5625 7025 5625
Wire Wire Line
	8875 5675 8875 5625
Wire Wire Line
	10775 5675 10775 5625
Wire Wire Line
	7625 900  7675 900 
$Comp
L Device:C C1
U 1 1 5D1EA995
P 5225 2300
F 0 "C1" H 5340 2346 50  0000 L CNN
F 1 "47 uF" H 5340 2255 50  0000 L CNN
F 2 "Capacitor_THT:CP_Axial_L11.0mm_D6.0mm_P18.00mm_Horizontal" H 5263 2150 50  0001 C CNN
F 3 "~" H 5225 2300 50  0001 C CNN
	1    5225 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5225 2025 5225 2150
Wire Wire Line
	5225 2600 5225 2450
Text GLabel 5050 1875 1    50   Input ~ 0
A0
Wire Wire Line
	5050 1875 5050 2025
Connection ~ 5050 2025
Wire Wire Line
	5050 2025 5225 2025
Wire Wire Line
	5050 2725 5050 2600
Connection ~ 5050 2600
Wire Wire Line
	5050 2600 5225 2600
Wire Wire Line
	5975 3375 6125 3375
Wire Wire Line
	6100 3575 5975 3575
Text GLabel 4925 3450 0    60   Input ~ 0
5V
Text GLabel 4925 3550 0    60   Input ~ 0
DGND
Text GLabel 4925 3650 0    60   Input ~ 0
D4
Text GLabel 4925 3850 0    60   Input ~ 0
D6
$Comp
L Connector:Jack-DC J-InStimInput1
U 1 1 5D253190
P 7325 3900
F 0 "J-InStimInput1" H 7095 3858 50  0000 R CNN
F 1 "90V" H 7095 3949 50  0000 R CNN
F 2 "Connector_BarrelJack:BarrelJack_CUI_PJ-036AH-SMT_Horizontal" H 7375 3860 50  0001 C CNN
F 3 "~" H 7375 3860 50  0001 C CNN
	1    7325 3900
	-1   0    0    1   
$EndComp
Wire Wire Line
	7025 3775 5975 3775
Wire Wire Line
	7025 3800 7025 3775
Wire Wire Line
	5975 3975 7025 3975
Wire Wire Line
	7025 3975 7025 4000
Wire Wire Line
	5975 3675 6750 3675
Wire Wire Line
	6575 3875 6575 3475
Wire Wire Line
	5975 3875 6575 3875
Wire Wire Line
	6575 3475 6775 3475
Wire Wire Line
	6750 4075 6750 3675
Wire Wire Line
	5975 4075 6750 4075
Connection ~ 6750 3675
Wire Wire Line
	6750 3675 6925 3675
$Comp
L Connector_Generic:Conn_01x06 J1
U 1 1 5D26CD0F
P 5300 3650
F 0 "J1" H 5380 3642 50  0000 L CNN
F 1 "SSR-ToInput" H 5380 3551 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 5300 3650 50  0001 C CNN
F 3 "~" H 5300 3650 50  0001 C CNN
	1    5300 3650
	1    0    0    -1  
$EndComp
Text GLabel 6100 3575 2    60   Input ~ 0
A0
Connection ~ 6575 3475
Wire Wire Line
	5975 3475 6575 3475
Text GLabel 6100 3375 2    60   Input ~ 0
D5
$Comp
L Connector_Generic:Conn_01x08 J2
U 1 1 5D27E79B
P 5775 3775
F 0 "J2" H 5693 3150 50  0000 C CNN
F 1 "SSR-ToOutput" H 5693 3241 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x09_P2.54mm_Horizontal" H 5775 3775 50  0001 C CNN
F 3 "~" H 5775 3775 50  0001 C CNN
	1    5775 3775
	-1   0    0    1   
$EndComp
Wire Wire Line
	4925 3450 5100 3450
Wire Wire Line
	4925 3550 5100 3550
Wire Wire Line
	4925 3650 5000 3650
Wire Wire Line
	5100 3750 5000 3750
Wire Wire Line
	5000 3750 5000 3650
Connection ~ 5000 3650
Wire Wire Line
	5000 3650 5100 3650
Wire Wire Line
	4925 3850 5000 3850
Wire Wire Line
	5100 3950 5000 3950
Wire Wire Line
	5000 3950 5000 3850
Connection ~ 5000 3850
Wire Wire Line
	5000 3850 5100 3850
$Comp
L Connector:Screw_Terminal_01x02 JPad1
U 1 1 5D29FD5E
P 7225 3400
F 0 "JPad1" H 7305 3392 50  0000 L CNN
F 1 "ShockPad" H 7305 3301 50  0000 L CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 7225 3400 50  0001 C CNN
F 3 "~" H 7225 3400 50  0001 C CNN
	1    7225 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	6775 3475 6775 3400
Wire Wire Line
	6775 3400 7025 3400
Wire Wire Line
	6925 3500 7025 3500
Wire Wire Line
	6925 3500 6925 3675
Wire Wire Line
	4675 2150 4675 2025
Wire Wire Line
	4675 2025 5050 2025
Wire Wire Line
	4675 2450 4675 2600
Wire Wire Line
	4675 2600 5050 2600
$Comp
L Device:R_Variable R3
U 1 1 5D1EA22E
P 4675 2300
F 0 "R3" H 4803 2346 50  0000 L CNN
F 1 "1M" H 4803 2255 50  0000 L CNN
F 2 "Potentiometer_THT:Potentiometer_Alps_RK09K_Single_Horizontal" V 4605 2300 50  0001 C CNN
F 3 "~" H 4675 2300 50  0001 C CNN
	1    4675 2300
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 JPad2
U 1 1 5D2D0992
P 7225 3100
F 0 "JPad2" H 7305 3092 50  0000 L CNN
F 1 "StimInput" H 7305 3001 50  0000 L CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 7225 3100 50  0001 C CNN
F 3 "~" H 7225 3100 50  0001 C CNN
	1    7225 3100
	1    0    0    -1  
$EndComp
Text GLabel 6850 3100 0    60   Input ~ 0
D7
Text GLabel 6850 3200 0    60   Input ~ 0
DGND
Wire Wire Line
	6850 3100 7025 3100
Wire Wire Line
	6850 3200 7025 3200
$Comp
L Schematic-rescue:AGND-DoraBabu #PWR06
U 1 1 5C3EFA74
P 8600 1725
F 0 "#PWR06" H 8600 1725 40  0001 C CNN
F 1 "AGND" H 8600 1655 50  0000 C CNN
F 2 "" H 8600 1725 60  0000 C CNN
F 3 "" H 8600 1725 60  0000 C CNN
	1    8600 1725
	0    1    1    0   
$EndComp
Wire Wire Line
	8950 1725 8600 1725
NoConn ~ 1800 2500
$Comp
L Schematic-rescue:ARDUINO_SHIELD-DoraBabu SHIELD1
U 1 1 5C3EFA63
P 2750 2800
F 0 "SHIELD1" H 2400 3750 60  0000 C CNN
F 1 "ARDUINO_SHIELD" H 2800 1850 60  0000 C CNN
F 2 "Module:Arduino_UNO_R3_WithMountingHoles" H 2750 2800 60  0001 C CNN
F 3 "" H 2750 2800 60  0001 C CNN
	1    2750 2800
	1    0    0    -1  
$EndComp
NoConn ~ 3700 2100
$Comp
L Isolator:4N35 IC1
U 1 1 5D2001DC
P 6525 5525
F 0 "IC1" H 6525 5885 40  0000 C CNN
F 1 "4N35" H 6525 5809 40  0000 C CNN
F 2 "Package_DIP:DIP-6_W7.62mm_Socket" H 6525 5742 29  0001 C CNN
F 3 "" H 6525 5525 60  0001 C CNN
	1    6525 5525
	1    0    0    -1  
$EndComp
Wire Wire Line
	6825 5525 6925 5525
Wire Wire Line
	6825 5625 6975 5625
Wire Wire Line
	8175 5425 8225 5425
Wire Wire Line
	8175 5625 8225 5625
Wire Wire Line
	8825 5525 8875 5525
Wire Wire Line
	8800 5625 8825 5625
Connection ~ 8825 5625
Wire Wire Line
	8825 5625 8875 5625
Wire Wire Line
	10075 5425 10125 5425
Wire Wire Line
	10075 5625 10125 5625
Wire Wire Line
	10725 5525 10775 5525
Wire Wire Line
	10725 5625 10775 5625
Wire Wire Line
	6825 700  6875 700 
Wire Wire Line
	6825 900  6875 900 
Wire Wire Line
	7475 800  7525 800 
Wire Wire Line
	7475 900  7625 900 
Wire Wire Line
	7475 1800 7525 1800
Wire Wire Line
	7475 1900 7575 1900
Connection ~ 7575 1900
Wire Wire Line
	6825 1700 6875 1700
Wire Wire Line
	6825 1900 6875 1900
$Comp
L Schematic-rescue:AGND-DoraBabu #PWR0101
U 1 1 5D23393F
P 5050 2725
F 0 "#PWR0101" H 5050 2725 40  0001 C CNN
F 1 "AGND" H 5050 2655 50  0000 C CNN
F 2 "" H 5050 2725 60  0000 C CNN
F 3 "" H 5050 2725 60  0000 C CNN
	1    5050 2725
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:AGND-DoraBabu #PWR0102
U 1 1 5D239D97
P 1450 2750
F 0 "#PWR0102" H 1450 2750 40  0001 C CNN
F 1 "AGND" H 1450 2680 50  0000 C CNN
F 2 "" H 1450 2750 60  0000 C CNN
F 3 "" H 1450 2750 60  0000 C CNN
	1    1450 2750
	0    1    1    0   
$EndComp
Wire Wire Line
	1800 2700 1625 2700
Wire Wire Line
	1625 2700 1625 2750
Wire Wire Line
	1625 2750 1450 2750
NoConn ~ 1800 2800
NoConn ~ 8825 5425
NoConn ~ 10725 5425
NoConn ~ 7475 1700
NoConn ~ 7475 700 
NoConn ~ 6825 5425
NoConn ~ 8650 1025
NoConn ~ 8650 1125
NoConn ~ 8650 1225
NoConn ~ 8650 1325
NoConn ~ 8650 1425
NoConn ~ 9950 1025
NoConn ~ 9950 1125
NoConn ~ 9950 1225
NoConn ~ 9950 1325
NoConn ~ 9950 1425
NoConn ~ 3700 2000
NoConn ~ 1800 2900
NoConn ~ 1300 950 
NoConn ~ 1300 1350
NoConn ~ 3125 5750
$Comp
L Schematic-rescue:R-DoraBabu R1
U 1 1 5C3EFA99
P 2550 4100
F 0 "R1" V 2630 4100 40  0000 C CNN
F 1 "560E" V 2557 4101 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 2480 4100 30  0001 C CNN
F 3 "~" H 2550 4100 30  0001 C CNN
	1    2550 4100
	0    -1   -1   0   
$EndComp
$Comp
L Schematic-rescue:CONN_2-DoraBabu P4
U 1 1 5C3F0D30
P 2300 6700
F 0 "P4" V 2250 6700 40  0000 C CNN
F 1 "CONN_2" V 2350 6700 40  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Horizontal" H 2300 6700 60  0001 C CNN
F 3 "" H 2300 6700 60  0000 C CNN
	1    2300 6700
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:R-DoraBabu R4
U 1 1 5C3EFA94
P 5975 5425
F 0 "R4" V 6055 5425 40  0000 C CNN
F 1 "560E" V 5982 5426 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 5905 5425 30  0001 C CNN
F 3 "~" H 5975 5425 30  0001 C CNN
	1    5975 5425
	0    -1   -1   0   
$EndComp
$Comp
L Schematic-rescue:R-DoraBabu R2
U 1 1 5C3EFA9A
P 2550 4300
F 0 "R2" V 2630 4300 40  0000 C CNN
F 1 "560E" V 2557 4301 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 2480 4300 30  0001 C CNN
F 3 "~" H 2550 4300 30  0001 C CNN
	1    2550 4300
	0    -1   -1   0   
$EndComp
$Comp
L Schematic-rescue:R-DoraBabu R7
U 1 1 5C3EFA96
P 6975 5925
F 0 "R7" V 7075 6075 40  0000 C CNN
F 1 "15k" V 6982 5926 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 6905 5925 30  0001 C CNN
F 3 "~" H 6975 5925 30  0001 C CNN
	1    6975 5925
	-1   0    0    1   
$EndComp
$EndSCHEMATC
