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
L Schematic-rescue:ULN2003A-DoraBabu-Schematic-rescue U1
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
L Schematic-rescue:DIODE-DoraBabu-Schematic-rescue D1
U 1 1 5C3EFA72
P 10300 1625
F 0 "D1" H 10300 1725 40  0000 C CNN
F 1 "DIODE" H 10300 1525 40  0000 C CNN
F 2 "Diode_THT:D_DO-27_P5.08mm_Vertical_KathodeUp" H 10300 1625 60  0001 C CNN
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
L Schematic-rescue:R-DoraBabu-Schematic-rescue R8
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
L Schematic-rescue:R-DoraBabu-Schematic-rescue R6
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
L Schematic-rescue:R-DoraBabu-Schematic-rescue R5
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
L Schematic-rescue:R-DoraBabu-Schematic-rescue R10
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
Text GLabel 10450 1875 2    60   Input ~ 0
Solenoid1_1
Text GLabel 10200 925  2    60   Input ~ 0
Solenoid1_2
Text GLabel 10450 2025 2    60   Input ~ 0
Solenoid2_1
Text GLabel 10200 825  2    60   Input ~ 0
Solenoid2_2
$Comp
L Schematic-rescue:HDR-1X15-15-91-?-DoraBabu-Schematic-rescue CN1
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
L Schematic-rescue:R-DoraBabu-Schematic-rescue R12
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
Text GLabel 5725 5425 0    60   Input ~ 0
D13
Text GLabel 6325 1700 0    60   Input ~ 0
D12
Text GLabel 6325 700  0    60   Input ~ 0
D11
Text GLabel 3700 2700 2    60   Input ~ 0
D8
Text GLabel 3700 2600 2    60   Input ~ 0
D9
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
L Schematic-rescue:R-DoraBabu-Schematic-rescue R11
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
L Schematic-rescue:AGND-DoraBabu-Schematic-rescue #PWR05
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
L Schematic-rescue:R-DoraBabu-Schematic-rescue R13
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
L Schematic-rescue:AGND-DoraBabu-Schematic-rescue #PWR07
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
L Schematic-rescue:AGND-DoraBabu-Schematic-rescue #PWR02
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
$Comp
L Schematic-rescue:R-DoraBabu-Schematic-rescue R9
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
L Schematic-rescue:AGND-DoraBabu-Schematic-rescue #PWR04
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
L Schematic-rescue:AGND-DoraBabu-Schematic-rescue #PWR03
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
F 2 "Capacitor_THT:C_Disc_D4.7mm_W2.5mm_P5.00mm" H 5263 2150 50  0001 C CNN
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
	5875 3825 6025 3825
Wire Wire Line
	6000 4025 5875 4025
Text GLabel 4825 3900 0    60   Input ~ 0
5V
Text GLabel 4825 4000 0    60   Input ~ 0
DGND
Text GLabel 4825 4100 0    60   Input ~ 0
D4
Text GLabel 4825 4300 0    60   Input ~ 0
D6
$Comp
L Connector:Jack-DC J-InStimInput1
U 1 1 5D253190
P 7225 4350
F 0 "J-InStimInput1" H 6995 4308 50  0000 R CNN
F 1 "90V" H 6995 4399 50  0000 R CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 7275 4310 50  0001 C CNN
F 3 "~" H 7275 4310 50  0001 C CNN
	1    7225 4350
	-1   0    0    1   
$EndComp
Wire Wire Line
	6925 4225 5875 4225
Wire Wire Line
	6925 4250 6925 4225
Wire Wire Line
	5875 4425 6925 4425
Wire Wire Line
	6925 4425 6925 4450
Wire Wire Line
	5875 4125 6650 4125
Wire Wire Line
	6475 4325 6475 3925
Wire Wire Line
	5875 4325 6475 4325
Wire Wire Line
	6475 3925 6675 3925
Wire Wire Line
	6650 4525 6650 4125
Wire Wire Line
	5875 4525 6650 4525
Connection ~ 6650 4125
Wire Wire Line
	6650 4125 6825 4125
$Comp
L Connector_Generic:Conn_01x06 J1
U 1 1 5D26CD0F
P 5200 4100
F 0 "J1" H 5280 4092 50  0000 L CNN
F 1 "SSR-ToInput" H 5280 4001 50  0000 L CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 5200 4100 50  0001 C CNN
F 3 "~" H 5200 4100 50  0001 C CNN
	1    5200 4100
	1    0    0    -1  
$EndComp
Text GLabel 6000 4025 2    60   Input ~ 0
A0
Connection ~ 6475 3925
Wire Wire Line
	5875 3925 6475 3925
Text GLabel 6000 3825 2    60   Input ~ 0
D5
$Comp
L Connector_Generic:Conn_01x08 J2
U 1 1 5D27E79B
P 5675 4225
F 0 "J2" H 5593 3600 50  0000 C CNN
F 1 "SSR-ToOutput" H 5593 3691 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x09_P2.54mm_Horizontal" H 5675 4225 50  0001 C CNN
F 3 "~" H 5675 4225 50  0001 C CNN
	1    5675 4225
	-1   0    0    1   
$EndComp
Wire Wire Line
	4825 3900 5000 3900
Wire Wire Line
	4825 4000 5000 4000
Wire Wire Line
	4825 4100 4900 4100
Wire Wire Line
	5000 4200 4900 4200
Wire Wire Line
	4900 4200 4900 4100
Connection ~ 4900 4100
Wire Wire Line
	4900 4100 5000 4100
Wire Wire Line
	4825 4300 4900 4300
Wire Wire Line
	5000 4400 4900 4400
Wire Wire Line
	4900 4400 4900 4300
Connection ~ 4900 4300
Wire Wire Line
	4900 4300 5000 4300
$Comp
L Connector:Screw_Terminal_01x02 JPad1
U 1 1 5D29FD5E
P 7125 3850
F 0 "JPad1" H 7205 3842 50  0000 L CNN
F 1 "ShockPad" H 7205 3751 50  0000 L CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 7125 3850 50  0001 C CNN
F 3 "~" H 7125 3850 50  0001 C CNN
	1    7125 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6675 3925 6675 3850
Wire Wire Line
	6675 3850 6925 3850
Wire Wire Line
	6825 3950 6925 3950
Wire Wire Line
	6825 3950 6825 4125
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
P 7125 3550
F 0 "JPad2" H 7205 3542 50  0000 L CNN
F 1 "StimInput" H 7205 3451 50  0000 L CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 7125 3550 50  0001 C CNN
F 3 "~" H 7125 3550 50  0001 C CNN
	1    7125 3550
	1    0    0    -1  
$EndComp
Text GLabel 6750 3550 0    60   Input ~ 0
D7
Text GLabel 6750 3650 0    60   Input ~ 0
DGND
Wire Wire Line
	6750 3550 6925 3550
Wire Wire Line
	6750 3650 6925 3650
$Comp
L Schematic-rescue:AGND-DoraBabu-Schematic-rescue #PWR06
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
L Schematic-rescue:AGND-DoraBabu-Schematic-rescue #PWR0101
U 1 1 5D23393F
P 5050 2725
F 0 "#PWR0101" H 5050 2725 40  0001 C CNN
F 1 "AGND" H 5050 2655 50  0000 C CNN
F 2 "" H 5050 2725 60  0000 C CNN
F 3 "" H 5050 2725 60  0000 C CNN
	1    5050 2725
	1    0    0    -1  
$EndComp
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
$Comp
L Schematic-rescue:R-DoraBabu-Schematic-rescue R4
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
L Schematic-rescue:R-DoraBabu-Schematic-rescue R7
U 1 1 5C3EFA96
P 6975 5925
F 0 "R7" V 7075 6075 40  0000 C CNN
F 1 "15k" V 6982 5926 40  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric" V 6905 5925 30  0001 C CNN
F 3 "~" H 6975 5925 30  0001 C CNN
	1    6975 5925
	-1   0    0    1   
$EndComp
NoConn ~ 1800 2800
Wire Wire Line
	1625 2750 1450 2750
Wire Wire Line
	1625 2700 1625 2750
Wire Wire Line
	1800 2700 1625 2700
$Comp
L Schematic-rescue:AGND-DoraBabu-Schematic-rescue #PWR0102
U 1 1 5D239D97
P 1450 2750
F 0 "#PWR0102" H 1450 2750 40  0001 C CNN
F 1 "AGND" H 1450 2680 50  0000 C CNN
F 2 "" H 1450 2750 60  0000 C CNN
F 3 "" H 1450 2750 60  0000 C CNN
	1    1450 2750
	0    1    1    0   
$EndComp
$Comp
L Schematic-rescue:ARDUINO_SHIELD-DoraBabu-Schematic-rescue SHIELD1
U 1 1 5C3EFA63
P 2750 2800
F 0 "SHIELD1" H 2400 3750 60  0000 C CNN
F 1 "ARDUINO_SHIELD" H 2800 1850 60  0000 C CNN
F 2 "Module:Arduino_UNO_R3_WithMountingHoles" H 2750 2800 60  0001 C CNN
F 3 "" H 2750 2800 60  0001 C CNN
	1    2750 2800
	1    0    0    -1  
$EndComp
NoConn ~ 1800 2500
Text GLabel 1800 2600 0    60   Input ~ 0
5V
$Comp
L Connector_Generic:Conn_01x04 J3
U 1 1 5D235513
P 7100 3100
F 0 "J3" H 7180 3092 50  0000 L CNN
F 1 "RotaryEncoder" H 7180 3001 50  0000 L CNN
F 2 "Connector_PinSocket_1.27mm:PinSocket_1x04_P1.27mm_Vertical" H 7100 3100 50  0001 C CNN
F 3 "~" H 7100 3100 50  0001 C CNN
	1    7100 3100
	1    0    0    -1  
$EndComp
$Comp
L Schematic-rescue:AGND-DoraBabu-Schematic-rescue #PWR01
U 1 1 5D23D211
P 6650 3300
F 0 "#PWR01" H 6650 3300 40  0001 C CNN
F 1 "AGND" H 6650 3230 50  0000 C CNN
F 2 "" H 6650 3300 60  0000 C CNN
F 3 "" H 6650 3300 60  0000 C CNN
	1    6650 3300
	0    1    1    0   
$EndComp
Wire Wire Line
	6650 3300 6900 3300
Text GLabel 6650 3200 0    60   Input ~ 0
5V
Wire Wire Line
	6650 3200 6900 3200
Text GLabel 6650 3000 0    60   Input ~ 0
D2
Wire Wire Line
	6650 3000 6900 3000
Text GLabel 6650 3100 0    60   Input ~ 0
D3
Wire Wire Line
	6650 3100 6900 3100
NoConn ~ 3700 3500
NoConn ~ 3700 3600
NoConn ~ 3700 2500
NoConn ~ 1800 2400
Text GLabel 3300 4800 0    60   Input ~ 0
A0
Text GLabel 3300 4900 0    60   Input ~ 0
A1
Text GLabel 3300 5000 0    60   Input ~ 0
A2
Text GLabel 3300 5200 0    60   Input ~ 0
A4
Text GLabel 3300 5300 0    60   Input ~ 0
A5
$Comp
L Connector_Generic:Conn_01x06 J4
U 1 1 5D264F7F
P 3500 5000
F 0 "J4" H 3580 4992 50  0000 L CNN
F 1 "AnalogIn" H 3580 4901 50  0000 L CNN
F 2 "Connector_PinSocket_1.27mm:PinSocket_1x06_P1.27mm_Vertical" H 3500 5000 50  0001 C CNN
F 3 "~" H 3500 5000 50  0001 C CNN
	1    3500 5000
	1    0    0    -1  
$EndComp
Text GLabel 3300 5100 0    60   Input ~ 0
A3
NoConn ~ 1850 5900
NoConn ~ 1850 6000
$EndSCHEMATC
