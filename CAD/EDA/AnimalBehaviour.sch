EESchema Schematic File Version 4
LIBS:AnimalBehaviour-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "MouseBehaviour: EDA Designs"
Date "2019-07-10"
Rev "7"
Comp "BhallaLab, NCBS Bangalore"
Comment1 "Dorababu/Dilawar Singh"
Comment2 "Helpdesk Ticket No: 197588"
Comment3 ""
Comment4 ""
$EndDescr
Text GLabel 10075 1050 0    60   Input ~ 0
EncB
Text GLabel 10075 1150 0    60   Input ~ 0
EncA
Text GLabel 5725 1125 2    60   Input ~ 0
EncA
Text GLabel 5725 1225 2    60   Input ~ 0
EncB
Text GLabel 5725 1325 2    60   Input ~ 0
ShockRelayCh12
Text GLabel 5725 1425 2    60   Input ~ 0
ShockPWM
Text GLabel 5725 1525 2    60   Input ~ 0
ShockRelayCh34
Text GLabel 5725 1625 2    60   Input ~ 0
ShockStimIsolator
Text GLabel 5725 1725 2    60   Input ~ 0
TONE+
Text GLabel 5725 1825 2    60   Input ~ 0
LED
Text GLabel 5725 1925 2    60   Input ~ 0
CamTTL
Text GLabel 5725 2025 2    60   Input ~ 0
Puff
Text GLabel 5725 2125 2    60   Input ~ 0
ImagingTrig
Text Notes 3325 825  0    60   ~ 0
Arduino  Uno\n
$Comp
L Isolator:4N35 U1
U 1 1 5D2209DC
P 8000 5125
F 0 "U1" H 8000 5450 50  0000 C CNN
F 1 "4N35" H 8000 5359 50  0000 C CNN
F 2 "Package_DIP:DIP-6_W7.62mm_Socket" H 7800 4925 50  0001 L CIN
F 3 "https://www.vishay.com/docs/81181/4n35.pdf" H 8000 5125 50  0001 L CNN
	1    8000 5125
	1    0    0    -1  
$EndComp
Text GLabel 7200 5025 0    60   Input ~ 0
Puff
Text GLabel 7700 5225 0    60   Input ~ 0
DGND
Wire Wire Line
	8300 5225 8350 5225
Text GLabel 8350 5875 3    60   Input ~ 0
AGND
Wire Wire Line
	8350 5875 8350 5825
Wire Wire Line
	8350 5125 8300 5125
Connection ~ 8350 5225
$Comp
L Transistor_FET:IRF540N Q1
U 1 1 5D2269C5
P 9000 5225
F 0 "Q1" H 9206 5271 50  0000 L CNN
F 1 "IRF540N" H 9206 5180 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Horizontal_TabDown" H 9250 5150 50  0001 L CIN
F 3 "http://www.irf.com/product-info/datasheets/data/irf540n.pdf" H 9000 5225 50  0001 L CNN
	1    9000 5225
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 5225 8800 5225
Wire Wire Line
	9100 5425 9100 5825
Wire Wire Line
	9100 5825 8350 5825
Connection ~ 8350 5825
$Comp
L Connector:Conn_01x02_Male J10
U 1 1 5D2282D7
P 9300 4825
F 0 "J10" H 9272 4799 50  0000 R CNN
F 1 "JSolenoid" H 9272 4708 50  0000 R CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 9300 4825 50  0001 C CNN
F 3 "~" H 9300 4825 50  0001 C CNN
	1    9300 4825
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9100 4525 9100 4625
Wire Wire Line
	9100 4925 9100 5025
$Comp
L Device:D D1
U 1 1 5D22A71C
P 8850 4825
F 0 "D1" V 8888 4747 40  0000 R CNN
F 1 "DIODE" V 8812 4747 40  0000 R CNN
F 2 "Diode_THT:D_DO-15_P12.70mm_Horizontal" H 8850 4825 60  0001 C CNN
F 3 "" H 8850 4825 60  0000 C CNN
	1    8850 4825
	0    1    1    0   
$EndComp
Wire Wire Line
	8850 5025 9100 5025
Connection ~ 9100 5025
Wire Wire Line
	8850 4625 9100 4625
Connection ~ 9100 4625
Wire Wire Line
	9100 4625 9100 4825
Text Notes 8150 4425 0    50   ~ 10
Solenoid driver\n
Text GLabel 5950 5575 0    60   Input ~ 0
ShockStimIsolator
Text GLabel 5950 5675 0    60   Input ~ 0
DGND
Text GLabel 10175 5050 0    60   Input ~ 0
AGND
Wire Wire Line
	10175 5050 10275 5050
Text GLabel 10175 4850 0    60   Input ~ 0
EX_12V
Wire Wire Line
	10175 4850 10275 4850
Text GLabel 9100 4525 2    60   Input ~ 0
EX_12V
$Comp
L Connector:Conn_01x03_Male J14
U 1 1 5D2389C2
P 10475 4950
F 0 "J14" H 10447 4974 50  0000 R CNN
F 1 "Ext Supp" H 10447 4883 50  0000 R CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-03A_1x03_P2.54mm_Vertical" H 10475 4950 50  0001 C CNN
F 3 "~" H 10475 4950 50  0001 C CNN
	1    10475 4950
	-1   0    0    -1  
$EndComp
Text GLabel 10175 4950 0    60   Input ~ 0
EX_5V
Wire Wire Line
	10175 4950 10275 4950
Text GLabel 8350 4625 0    60   Input ~ 0
EX_5V
Wire Wire Line
	8350 4625 8350 5125
Text Notes 9875 4700 0    50   ~ 10
External supply\n
Text GLabel 8575 4025 2    60   Input ~ 0
DGND
Text GLabel 8575 3925 2    60   Input ~ 0
ImagingTrig
Text GLabel 8600 3275 2    60   Input ~ 0
DGND
Text GLabel 8600 3175 2    60   Input ~ 0
CamTTL
$Comp
L Device:C C1
U 1 1 5D263290
P 1875 2150
F 0 "C1" H 1990 2196 50  0000 L CNN
F 1 "47nF" H 1990 2105 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P5.00mm" H 1913 2000 50  0001 C CNN
F 3 "~" H 1875 2150 50  0001 C CNN
	1    1875 2150
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J5
U 1 1 5D263EAD
P 6300 5575
F 0 "J5" H 6400 5550 50  0000 L CNN
F 1 "StimIsoIN" H 6000 5725 50  0000 L CNN
F 2 "Connector_Coaxial:BNC_TEConnectivity_1478204_Vertical" H 6300 5575 50  0001 C CNN
F 3 " ~" H 6300 5575 50  0001 C CNN
	1    6300 5575
	1    0    0    -1  
$EndComp
Wire Wire Line
	5950 5575 6100 5575
Wire Wire Line
	5950 5675 6150 5675
Wire Wire Line
	6150 5675 6150 5775
Wire Wire Line
	6150 5775 6300 5775
Wire Wire Line
	1875 2350 1875 2300
Wire Wire Line
	1525 1450 1525 1400
Wire Wire Line
	1525 1400 1875 1400
Wire Wire Line
	1875 1400 1875 2000
Text GLabel 1175 1400 0    60   Input ~ 0
ShockRead
Wire Wire Line
	1175 1400 1525 1400
Connection ~ 1525 1400
$Comp
L Connector:Jack-DC J3
U 1 1 5D26C0F3
P 6150 4925
F 0 "J3" H 6150 4525 50  0000 C CNN
F 1 "StimCurrentInject" H 6150 4650 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_CUI_PJ-063AH_Horizontal_CircularHoles" H 6200 4885 50  0001 C CNN
F 3 "~" H 6200 4885 50  0001 C CNN
	1    6150 4925
	-1   0    0    1   
$EndComp
Text GLabel 5850 4825 0    60   Input ~ 0
OUT+
Text GLabel 5850 5025 0    60   Input ~ 0
OUT-
Text GLabel 1375 2350 0    60   Input ~ 0
DGND
Wire Wire Line
	1525 1850 1675 1850
Wire Wire Line
	1675 1850 1675 1600
NoConn ~ 1525 1750
NoConn ~ 8300 5025
$Comp
L arduino:Arduino_Uno_Shield XA1
U 1 1 5D1FCEB8
P 4425 2175
F 0 "XA1" H 4425 3562 60  0000 C CNN
F 1 "Arduino_Uno_Shield" H 4425 3456 60  0000 C CNN
F 2 "Arduino:Arduino_Uno_Shield" H 6225 5925 60  0001 C CNN
F 3 "https://store.arduino.cc/arduino-uno-rev3" H 6225 5925 60  0001 C CNN
	1    4425 2175
	1    0    0    -1  
$EndComp
NoConn ~ 3125 1125
NoConn ~ 3125 1225
NoConn ~ 3125 1425
NoConn ~ 3125 1525
Wire Wire Line
	1375 2350 1525 2350
Wire Wire Line
	1525 1850 1525 1950
Wire Wire Line
	1525 2250 1525 2350
Connection ~ 1525 2350
Wire Wire Line
	1525 2350 1875 2350
Wire Wire Line
	8350 5675 8350 5825
Wire Wire Line
	8350 5225 8350 5375
Wire Wire Line
	8850 4625 8850 4675
Wire Wire Line
	8850 4975 8850 5025
$Comp
L Device:R R2
U 1 1 5D221F97
P 7450 5025
F 0 "R2" V 7265 5025 40  0000 C CNN
F 1 "470E" V 7341 5025 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P5.08mm_Vertical" V 7380 5025 30  0001 C CNN
F 3 "" H 7450 5025 30  0000 C CNN
	1    7450 5025
	0    1    1    0   
$EndComp
Wire Wire Line
	7200 5025 7300 5025
Wire Wire Line
	7600 5025 7700 5025
Text GLabel 3125 3125 0    60   Input ~ 0
5V
NoConn ~ 5725 2425
NoConn ~ 5725 2525
NoConn ~ 5725 2625
NoConn ~ 5725 2725
NoConn ~ 5725 2825
NoConn ~ 5725 2925
NoConn ~ 5725 3225
Text GLabel 4550 5575 2    60   Input ~ 0
PAD-
Text GLabel 4550 5375 2    60   Input ~ 0
PAD+
Text GLabel 4550 5175 2    60   Input ~ 0
PAD-
Text GLabel 4550 4975 2    60   Input ~ 0
PAD+
Text GLabel 4550 5475 2    60   Input ~ 0
OUT-
Text GLabel 4550 5275 2    60   Input ~ 0
OUT+
Text GLabel 4550 5075 2    60   Input ~ 0
ShockRead
Text GLabel 4550 4875 2    60   Input ~ 0
ShockPWM
$Comp
L Connector_Generic:Conn_01x08 J2
U 1 1 5D26665C
P 4350 5275
F 0 "J2" H 4350 4625 50  0000 C CNN
F 1 "SSR OUT" H 4350 4750 50  0000 C TNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-08A_1x08_P2.54mm_Vertical" H 4350 5275 50  0001 C CNN
F 3 "~" H 4350 5275 50  0001 C CNN
	1    4350 5275
	-1   0    0    1   
$EndComp
Text GLabel 1625 5275 0    60   Input ~ 0
ShockRelayCh12
Wire Wire Line
	1950 5200 1825 5200
Wire Wire Line
	1825 5350 1950 5350
Wire Wire Line
	1950 5500 1825 5500
Wire Wire Line
	1825 5500 1825 5575
Wire Wire Line
	1825 5650 1950 5650
Wire Wire Line
	1625 5275 1825 5275
Wire Wire Line
	1825 5200 1825 5275
Connection ~ 1825 5275
Wire Wire Line
	1825 5275 1825 5350
Text GLabel 1625 5575 0    60   Input ~ 0
ShockRelayCh34
Wire Wire Line
	1625 5575 1825 5575
Connection ~ 1825 5575
Wire Wire Line
	1825 5575 1825 5650
Text GLabel 1800 4800 0    60   Input ~ 0
VCC
Text GLabel 1800 4900 0    60   Input ~ 0
DGND
Wire Wire Line
	1800 4800 1950 4800
Wire Wire Line
	1800 4900 1950 4900
Wire Wire Line
	3475 5600 3150 5600
Wire Wire Line
	3475 5500 3150 5500
Wire Wire Line
	3475 5350 3150 5350
Wire Wire Line
	3475 5250 3150 5250
Wire Wire Line
	3475 5100 3150 5100
Wire Wire Line
	3475 5000 3150 5000
Wire Wire Line
	3475 4850 3150 4850
Wire Wire Line
	3150 4750 3475 4750
Text GLabel 3475 5600 2    60   Input ~ 0
PAD-
Text GLabel 3475 5500 2    60   Input ~ 0
OUT-
Text GLabel 3475 5350 2    60   Input ~ 0
PAD+
Text GLabel 3475 5250 2    60   Input ~ 0
OUT+
Text GLabel 3475 5100 2    60   Input ~ 0
PAD-
Text GLabel 3475 5000 2    60   Input ~ 0
ShockRead
Text GLabel 3475 4850 2    60   Input ~ 0
PAD+
Text GLabel 3475 4750 2    60   Input ~ 0
ShockPWM
NoConn ~ 3125 2825
NoConn ~ 3125 2925
NoConn ~ 3125 3225
NoConn ~ 3125 3025
NoConn ~ 3125 2025
NoConn ~ 3125 1925
NoConn ~ 3125 1825
NoConn ~ 5725 2225
Text GLabel 8775 2475 0    50   Input ~ 0
TONE+
Wire Wire Line
	10225 1050 10075 1050
Wire Wire Line
	10225 1150 10075 1150
Text GLabel 10075 850  0    60   Input ~ 0
VCC
Wire Wire Line
	10225 850  10075 850 
Text GLabel 10075 950  0    60   Input ~ 0
DGND
Wire Wire Line
	10075 950  10225 950 
Text Notes 1000 1275 0    50   ~ 0
ShockPad is connected to A0.
Text GLabel 8775 2375 0    50   Input ~ 0
TONE-
Wire Wire Line
	10725 2500 10825 2500
Wire Wire Line
	10425 2500 10225 2500
$Comp
L Device:R R4
U 1 1 5D21C427
P 10575 2500
F 0 "R4" V 10390 2500 40  0000 C CNN
F 1 "470E" V 10466 2500 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P5.08mm_Vertical" V 10505 2500 30  0001 C CNN
F 3 "" H 10575 2500 30  0000 C CNN
	1    10575 2500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10675 2400 10225 2400
$Comp
L Connector:Conn_01x02_Male J11
U 1 1 5D2AE3AD
P 10025 2500
F 0 "J11" H 9997 2474 50  0000 R CNN
F 1 "LED" H 9997 2383 50  0000 R CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 10025 2500 50  0001 C CNN
F 3 "~" H 10025 2500 50  0001 C CNN
	1    10025 2500
	1    0    0    1   
$EndComp
Text GLabel 10675 2400 2    60   Input ~ 0
DGND
Text GLabel 10825 2500 2    60   Input ~ 0
LED
Text GLabel 10300 3425 2    60   Input ~ 0
DGND
Text GLabel 10025 3950 0    60   Input ~ 0
ImagingTrig
Text GLabel 10325 4350 2    60   Input ~ 0
DGND
Text GLabel 10000 3025 0    60   Input ~ 0
CamTTL
Text Notes 3300 4400 0    50   ~ 10
Shock Pad Subcircuit
Text GLabel 1225 2950 0    60   Input ~ 0
DGND
$Comp
L power:GNDD #PWR01
U 1 1 5D247656
P 1550 2950
F 0 "#PWR01" H 1550 2700 50  0001 C CNN
F 1 "GNDD" V 1554 2840 50  0000 R CNN
F 2 "" H 1550 2950 50  0001 C CNN
F 3 "" H 1550 2950 50  0001 C CNN
	1    1550 2950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1225 2950 1400 2950
Text GLabel 1225 3175 0    60   Input ~ 0
AGND
$Comp
L power:GNDA #PWR02
U 1 1 5D24B4AF
P 1550 3175
F 0 "#PWR02" H 1550 2925 50  0001 C CNN
F 1 "GNDA" V 1555 3047 50  0000 R CNN
F 2 "" H 1550 3175 50  0001 C CNN
F 3 "" H 1550 3175 50  0001 C CNN
	1    1550 3175
	0    -1   -1   0   
$EndComp
$Comp
L power:PWR_FLAG #FLG03
U 1 1 5D24E1FD
P 1400 2950
F 0 "#FLG03" H 1400 3025 50  0001 C CNN
F 1 "PWR_FLAG" H 1400 3123 50  0000 C CNN
F 2 "" H 1400 2950 50  0001 C CNN
F 3 "~" H 1400 2950 50  0001 C CNN
	1    1400 2950
	1    0    0    -1  
$EndComp
Connection ~ 1400 2950
Wire Wire Line
	1400 2950 1550 2950
Text GLabel 1550 3475 2    60   Input ~ 0
5V
Wire Wire Line
	1550 3475 1375 3475
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5D251149
P 1375 3475
F 0 "#FLG02" H 1375 3550 50  0001 C CNN
F 1 "PWR_FLAG" H 1375 3648 50  0000 C CNN
F 2 "" H 1375 3475 50  0001 C CNN
F 3 "~" H 1375 3475 50  0001 C CNN
	1    1375 3475
	1    0    0    -1  
$EndComp
Connection ~ 1375 3475
Wire Wire Line
	1375 3475 1225 3475
NoConn ~ 10300 2825
NoConn ~ 10600 3025
NoConn ~ 10600 3225
NoConn ~ 10000 3225
NoConn ~ 10025 4150
NoConn ~ 10325 3750
NoConn ~ 10625 3950
NoConn ~ 10625 4150
Text GLabel 7800 725  0    60   Input ~ 0
PAD+
Text GLabel 7800 1125 0    60   Input ~ 0
PAD-
Text GLabel 1225 3475 0    60   Input ~ 0
VCC
NoConn ~ 3125 2425
NoConn ~ 3125 2225
NoConn ~ 3125 2125
Text GLabel 3125 2725 0    60   Input ~ 0
DGND
NoConn ~ 5725 3125
Text GLabel 3125 2325 0    60   Input ~ 0
ShockRead
$Comp
L Connector_Generic:Conn_01x04 J1
U 1 1 5D2916A0
P 1700 4375
F 0 "J1" H 1780 4367 50  0000 L CNN
F 1 "SSR_INPUT" H 1500 4650 50  0000 L CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-04A_1x04_P2.54mm_Vertical" H 1700 4375 50  0001 C CNN
F 3 "~" H 1700 4375 50  0001 C CNN
	1    1700 4375
	1    0    0    -1  
$EndComp
Text GLabel 1500 4275 0    60   Input ~ 0
VCC
Text GLabel 1500 4375 0    60   Input ~ 0
DGND
Text GLabel 1500 4475 0    60   Input ~ 0
ShockRelayCh12
Text GLabel 1500 4575 0    60   Input ~ 0
ShockRelayCh34
Wire Wire Line
	7800 725  7875 725 
Wire Wire Line
	7800 1125 7900 1125
$Comp
L power:PWR_FLAG #FLG05
U 1 1 5D29A9FD
P 7900 1125
F 0 "#FLG05" H 7900 1200 50  0001 C CNN
F 1 "PWR_FLAG" H 7900 1298 50  0000 C CNN
F 2 "" H 7900 1125 50  0001 C CNN
F 3 "~" H 7900 1125 50  0001 C CNN
	1    7900 1125
	1    0    0    -1  
$EndComp
Connection ~ 7900 1125
Wire Wire Line
	7900 1125 7925 1125
$Comp
L power:PWR_FLAG #FLG04
U 1 1 5D29AC37
P 7875 725
F 0 "#FLG04" H 7875 800 50  0001 C CNN
F 1 "PWR_FLAG" H 7875 898 50  0000 C CNN
F 2 "" H 7875 725 50  0001 C CNN
F 3 "~" H 7875 725 50  0001 C CNN
	1    7875 725 
	1    0    0    -1  
$EndComp
Connection ~ 7875 725 
Wire Wire Line
	7875 725  7925 725 
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 5D2BFB14
P 6275 5925
F 0 "J4" H 6355 5917 50  0000 L CNN
F 1 "StimIsoIN" H 6355 5826 50  0000 L CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 6275 5925 50  0001 C CNN
F 3 "~" H 6275 5925 50  0001 C CNN
	1    6275 5925
	1    0    0    -1  
$EndComp
Text GLabel 6075 5925 0    60   Input ~ 0
DGND
Text GLabel 6075 6025 0    60   Input ~ 0
ShockStimIsolator
$Comp
L Connector:DIN-6 J13
U 1 1 5D22EBC4
P 10325 4050
F 0 "J13" H 10325 4531 50  0000 C CNN
F 1 "Imaging" H 10325 4440 50  0000 C CNN
F 2 "MD-60SM:CUI_MD-60SM" H 10325 4050 50  0001 C CNN
F 3 "http://www.mouser.com/ds/2/18/40_c091_abd_e-75918.pdf" H 10325 4050 50  0001 C CNN
	1    10325 4050
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J6
U 1 1 5D25B035
P 8375 3925
F 0 "J6" H 8483 4106 50  0000 C CNN
F 1 "Imaging" H 8800 4100 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 8375 3925 50  0001 C CNN
F 3 "~" H 8375 3925 50  0001 C CNN
	1    8375 3925
	1    0    0    -1  
$EndComp
$Comp
L Connector:DIN-6 J12
U 1 1 5D3F7145
P 10300 3125
F 0 "J12" H 10300 3606 50  0000 C CNN
F 1 "Cam" H 10525 3425 50  0000 C CNN
F 2 "MD-60SM:CUI_MD-60SM" H 10300 3125 50  0001 C CNN
F 3 "http://www.mouser.com/ds/2/18/40_c091_abd_e-75918.pdf" H 10300 3125 50  0001 C CNN
	1    10300 3125
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J7
U 1 1 5D25BBED
P 8400 3175
F 0 "J7" H 8508 3356 50  0000 C CNN
F 1 "CAM" H 8675 3375 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 8400 3175 50  0001 C CNN
F 3 "~" H 8400 3175 50  0001 C CNN
	1    8400 3175
	1    0    0    -1  
$EndComp
$Comp
L Device:R_POT_TRIM RV1
U 1 1 5D22AE7D
P 1525 1600
F 0 "RV1" H 1455 1646 50  0000 R CNN
F 1 "R_POT_TRIM" H 1455 1555 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Bourns_3296Y_Vertical" H 1525 1600 50  0001 C CNN
F 3 "~" H 1525 1600 50  0001 C CNN
	1    1525 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1225 3175 1375 3175
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5D22F188
P 1375 3175
F 0 "#FLG01" H 1375 3250 50  0001 C CNN
F 1 "PWR_FLAG" H 1375 3348 50  0000 C CNN
F 2 "" H 1375 3175 50  0001 C CNN
F 3 "~" H 1375 3175 50  0001 C CNN
	1    1375 3175
	1    0    0    -1  
$EndComp
Connection ~ 1375 3175
Wire Wire Line
	1375 3175 1550 3175
$Comp
L Device:R R3
U 1 1 5D222B56
P 8350 5525
F 0 "R3" H 8421 5563 40  0000 L CNN
F 1 "10K" H 8421 5487 40  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P5.08mm_Vertical" V 8280 5525 30  0001 C CNN
F 3 "" H 8350 5525 30  0000 C CNN
	1    8350 5525
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5D261F4B
P 1525 2100
F 0 "R1" H 1596 2138 40  0000 L CNN
F 1 "1K" H 1596 2062 40  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0309_L9.0mm_D3.2mm_P5.08mm_Vertical" V 1455 2100 30  0001 C CNN
F 3 "" H 1525 2100 30  0000 C CNN
	1    1525 2100
	1    0    0    -1  
$EndComp
$Comp
L Connector:AudioJack2 J9
U 1 1 5D36E723
P 8975 2375
F 0 "J9" H 8795 2358 50  0000 R CNN
F 1 "TONE" H 8795 2449 50  0000 R CNN
F 2 "Connector_Audio:Jack_3.5mm_CUI_SJ1-3533NG_Horizontal_CircularHoles" H 8975 2375 50  0001 C CNN
F 3 "https://www.mouser.in/datasheet/2/670/sj1-353xng-1313133.pdf" H 8975 2375 50  0001 C CNN
	1    8975 2375
	-1   0    0    1   
$EndComp
Wire Wire Line
	9025 2675 8775 2675
Text GLabel 8775 2675 0    50   Input ~ 0
TONE-
$Comp
L Connector_Generic:Conn_01x02 J8
U 1 1 5D23E125
P 8925 2075
F 0 "J8" H 9005 2067 50  0000 L CNN
F 1 "TONE" H 9005 1976 50  0000 L CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 8925 2075 50  0001 C CNN
F 3 "~" H 8925 2075 50  0001 C CNN
	1    8925 2075
	1    0    0    -1  
$EndComp
$Comp
L BhallaLabComponents:PCB-ShockPad ShockPad1
U 1 1 5D3BD131
P 8525 975
F 0 "ShockPad1" H 8875 825 50  0001 C CNN
F 1 "ShockPad" H 9103 780 50  0000 L CNN
F 2 "TerminalBlock_Altech:Altech_AK300_1x02_P5.00mm_45-Degree" H 8875 825 50  0001 C CNN
F 3 "" H 8875 825 50  0001 C CNN
	1    8525 975 
	1    0    0    -1  
$EndComp
Text GLabel 8725 2075 0    50   Input ~ 0
TONE-
Text GLabel 8725 2175 0    50   Input ~ 0
TONE+
Text GLabel 9025 2675 2    60   Input ~ 0
DGND
$Comp
L BhallaLabComponents:OrangeOpticalRotaryEncoder RotaryEncoder1
U 1 1 5D3982F6
P 10575 950
F 0 "RotaryEncoder1" H 10575 950 50  0001 C CNN
F 1 "Orange Optical RotaryEncoder" H 10575 950 0   0001 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-04A_1x04_P2.54mm_Vertical" H 10375 1100 50  0001 C CNN
F 3 "" H 10375 1100 50  0001 C CNN
	1    10575 950 
	-1   0    0    1   
$EndComp
Text GLabel 10075 750  0    60   Input ~ 0
DGND
Wire Wire Line
	10075 750  10225 750 
$Comp
L BhallaLabComponents:PCB_SSR_4Ch_LLT Assr4ch1
U 1 1 5D27A18F
P 2550 5150
F 0 "Assr4ch1" H 2375 5850 50  0000 L CNN
F 1 "PCB_SSR_4Ch_LLT" H 2200 5750 50  0000 L CNN
F 2 "SSR4Channel:4ChannelSSR" H 2550 5150 50  0001 C CNN
F 3 "https://www.amazon.in/MagiDeal-Solid-State-Module-High-level-Output/dp/B0772RP6KM/ref=sr_1_1?keywords=low+level+trigger+solid+state+relay&qid=1562403716&s=kitchen&sr=1-1" H 2550 5150 50  0001 C CNN
	1    2550 5150
	1    0    0    -1  
$EndComp
$EndSCHEMATC
