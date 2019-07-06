EESchema Schematic File Version 4
LIBS:AnimalBehaviour-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "MouseBehaviour: Electrical CAD Design"
Date "2019-07-06"
Rev "0.2.0"
Comp "BhallaLab, NCBS Bangalore"
Comment1 "Dorababu/Dilawar Singh"
Comment2 ""
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
P 9075 4500
F 0 "U1" H 9075 4825 50  0000 C CNN
F 1 "4N35" H 9075 4734 50  0000 C CNN
F 2 "Package_DIP:DIP-6_W7.62mm_Socket" H 8875 4300 50  0001 L CIN
F 3 "https://www.vishay.com/docs/81181/4n35.pdf" H 9075 4500 50  0001 L CNN
	1    9075 4500
	1    0    0    -1  
$EndComp
Text GLabel 8275 4400 0    60   Input ~ 0
Puff
Text GLabel 8775 4600 0    60   Input ~ 0
DGND
$Comp
L Device:R R3
U 1 1 5D222B56
P 9425 4900
F 0 "R3" H 9496 4938 40  0000 L CNN
F 1 "10K" H 9496 4862 40  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P25.40mm_Horizontal" V 9355 4900 30  0001 C CNN
F 3 "" H 9425 4900 30  0000 C CNN
	1    9425 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	9375 4600 9425 4600
Text GLabel 9425 5250 0    60   Input ~ 0
AGND
Wire Wire Line
	9425 5250 9425 5200
Wire Wire Line
	9425 4500 9375 4500
Connection ~ 9425 4600
$Comp
L Transistor_FET:IRF540N Q1
U 1 1 5D2269C5
P 10075 4600
F 0 "Q1" H 10281 4646 50  0000 L CNN
F 1 "IRF540N" H 10281 4555 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Horizontal_TabDown" H 10325 4525 50  0001 L CIN
F 3 "http://www.irf.com/product-info/datasheets/data/irf540n.pdf" H 10075 4600 50  0001 L CNN
	1    10075 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9425 4600 9875 4600
Wire Wire Line
	10175 4800 10175 5200
Wire Wire Line
	10175 5200 9425 5200
Connection ~ 9425 5200
$Comp
L Connector:Conn_01x02_Male J12
U 1 1 5D2282D7
P 10375 4200
F 0 "J12" H 10347 4174 50  0000 R CNN
F 1 "Conn_01x02_Male" H 10347 4083 50  0000 R CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 10375 4200 50  0001 C CNN
F 3 "~" H 10375 4200 50  0001 C CNN
	1    10375 4200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	10175 3900 10175 4000
Wire Wire Line
	10175 4300 10175 4400
$Comp
L Device:D D1
U 1 1 5D22A71C
P 9925 4200
F 0 "D1" V 9963 4122 40  0000 R CNN
F 1 "DIODE" V 9887 4122 40  0000 R CNN
F 2 "Diode_THT:D_DO-15_P12.70mm_Horizontal" H 9925 4200 60  0001 C CNN
F 3 "" H 9925 4200 60  0000 C CNN
	1    9925 4200
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9925 4400 10175 4400
Connection ~ 10175 4400
Wire Wire Line
	9925 4000 10175 4000
Connection ~ 10175 4000
Wire Wire Line
	10175 4000 10175 4200
Text Notes 9225 3800 0    50   ~ 10
Solenoid driver\n
Text GLabel 5950 5575 0    60   Input ~ 0
ShockStimIsolator
Text GLabel 5950 5675 0    60   Input ~ 0
DGND
Text GLabel 9450 6100 0    60   Input ~ 0
AGND
Wire Wire Line
	9450 6100 9550 6100
Text GLabel 9450 5900 0    60   Input ~ 0
EX_12V
Wire Wire Line
	9450 5900 9550 5900
Text GLabel 10175 3900 2    60   Input ~ 0
EX_12V
$Comp
L Connector:Conn_01x03_Male J8
U 1 1 5D2389C2
P 9750 6000
F 0 "J8" H 9722 6024 50  0000 R CNN
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
Text GLabel 9425 4000 0    60   Input ~ 0
EX_5V
Wire Wire Line
	9425 4000 9425 4500
Text Notes 9250 5650 0    50   ~ 10
External supply\n
Text GLabel 8350 3200 2    60   Input ~ 0
DGND
Text GLabel 8350 3100 2    60   Input ~ 0
ImagingTrig
$Comp
L Connector:Conn_01x02_Male J6
U 1 1 5D25BBED
P 8175 2350
F 0 "J6" H 8283 2531 50  0000 C CNN
F 1 "CAM" H 8283 2440 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 8175 2350 50  0001 C CNN
F 3 "~" H 8175 2350 50  0001 C CNN
	1    8175 2350
	1    0    0    -1  
$EndComp
Text GLabel 8375 2450 2    60   Input ~ 0
DGND
Text GLabel 8375 2350 2    60   Input ~ 0
CamTTL
$Comp
L Device:R_POT RV1
U 1 1 5D261470
P 1525 1600
F 0 "RV1" H 1456 1646 50  0000 R CNN
F 1 "1 MegOhm" H 1456 1555 50  0000 R CNN
F 2 "Potentiometer_THT:Potentiometer_Alps_RK09L_Single_Vertical" H 1525 1600 50  0001 C CNN
F 3 "~" H 1525 1600 50  0001 C CNN
	1    1525 1600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5D261F4B
P 1525 2100
F 0 "R1" H 1596 2138 40  0000 L CNN
F 1 "1K" H 1596 2062 40  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P25.40mm_Horizontal" V 1455 2100 30  0001 C CNN
F 3 "" H 1525 2100 30  0000 C CNN
	1    1525 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5D263290
P 1875 2150
F 0 "C1" H 1990 2196 50  0000 L CNN
F 1 "47nF" H 1990 2105 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.00mm" H 1913 2000 50  0001 C CNN
F 3 "~" H 1875 2150 50  0001 C CNN
	1    1875 2150
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_Coaxial J4
U 1 1 5D263EAD
P 6300 5575
F 0 "J4" H 6400 5550 50  0000 L CNN
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
F 2 "Connector_BarrelJack:BarrelJack_CUI_PJ-063AH_Horizontal" H 6200 4885 50  0001 C CNN
F 3 "~" H 6200 4885 50  0001 C CNN
	1    6150 4925
	-1   0    0    1   
$EndComp
Text GLabel 5850 5025 0    60   Input ~ 0
OUT+
Text GLabel 5850 4825 0    60   Input ~ 0
OUT-
Text GLabel 1375 2350 0    60   Input ~ 0
DGND
Wire Wire Line
	1525 1850 1675 1850
Wire Wire Line
	1675 1850 1675 1600
NoConn ~ 1525 1750
NoConn ~ 9375 4400
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
	9425 5050 9425 5200
Wire Wire Line
	9425 4600 9425 4750
Wire Wire Line
	9925 4000 9925 4050
Wire Wire Line
	9925 4350 9925 4400
$Comp
L Device:R R2
U 1 1 5D221F97
P 8525 4400
F 0 "R2" V 8340 4400 40  0000 C CNN
F 1 "470E" V 8416 4400 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P25.40mm_Horizontal" V 8455 4400 30  0001 C CNN
F 3 "" H 8525 4400 30  0000 C CNN
	1    8525 4400
	0    1    1    0   
$EndComp
Wire Wire Line
	8275 4400 8375 4400
Wire Wire Line
	8675 4400 8775 4400
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
$Comp
L AnimalBehaviour-rescue:PCB_SSR_4Ch_LLT-BhallaLabComponents Assr4ch1
U 1 1 5D27A18F
P 2550 5150
F 0 "Assr4ch1" H 2375 5850 50  0000 L CNN
F 1 "PCB_SSR_4Ch_LLT" H 2200 5750 50  0000 L CNN
F 2 "SSR4Channel:4ChannelSSR" H 2550 5150 50  0001 C CNN
F 3 "https://www.amazon.in/MagiDeal-Solid-State-Module-High-level-Output/dp/B0772RP6KM/ref=sr_1_1?keywords=low+level+trigger+solid+state+relay&qid=1562403716&s=kitchen&sr=1-1" H 2550 5150 50  0001 C CNN
	1    2550 5150
	1    0    0    -1  
$EndComp
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
$Comp
L Connector:AudioJack2 J7
U 1 1 5D36E723
P 8750 1550
F 0 "J7" H 8570 1533 50  0000 R CNN
F 1 "AudioJack2" H 8570 1624 50  0000 R CNN
F 2 "Connector_Audio:Jack_3.5mm_CUI_SJ-3523-SMT_Horizontal" H 8750 1550 50  0001 C CNN
F 3 "~" H 8750 1550 50  0001 C CNN
	1    8750 1550
	-1   0    0    1   
$EndComp
Text GLabel 8550 1550 0    50   Input ~ 0
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
Text Notes 1000 1275 0    50   ~ 0
ShockPad is connected to A0.
Text GLabel 8550 1650 0    50   Input ~ 0
TONE-
Text GLabel 8550 1850 0    50   Input ~ 0
TONE-
$Comp
L power:GNDA #PWR03
U 1 1 5D3E5D29
P 8800 1850
F 0 "#PWR03" H 8800 1600 50  0001 C CNN
F 1 "GNDA" V 8805 1722 50  0000 R CNN
F 2 "" H 8800 1850 50  0001 C CNN
F 3 "" H 8800 1850 50  0001 C CNN
	1    8800 1850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8800 1850 8550 1850
Wire Wire Line
	10500 1675 10600 1675
Wire Wire Line
	10200 1675 10000 1675
$Comp
L Device:R R4
U 1 1 5D21C427
P 10350 1675
F 0 "R4" V 10165 1675 40  0000 C CNN
F 1 "470E" V 10241 1675 40  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0414_L11.9mm_D4.5mm_P25.40mm_Horizontal" V 10280 1675 30  0001 C CNN
F 3 "" H 10350 1675 30  0000 C CNN
	1    10350 1675
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10450 1575 10000 1575
$Comp
L Connector:Conn_01x02_Male J9
U 1 1 5D2AE3AD
P 9800 1675
F 0 "J9" H 9772 1649 50  0000 R CNN
F 1 "LED" H 9772 1558 50  0000 R CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 9800 1675 50  0001 C CNN
F 3 "~" H 9800 1675 50  0001 C CNN
	1    9800 1675
	1    0    0    1   
$EndComp
Text GLabel 10450 1575 2    60   Input ~ 0
DGND
Text GLabel 10600 1675 2    60   Input ~ 0
LED
$Comp
L Connector:DIN-6 J10
U 1 1 5D3F7145
P 10075 2300
F 0 "J10" H 10075 2781 50  0000 C CNN
F 1 "Cam" H 10075 2690 50  0000 C CNN
F 2 "BhallaLab:Connector_Mini-DIN_Female_6Pin_2rows" H 10075 2300 50  0001 C CNN
F 3 "http://www.mouser.com/ds/2/18/40_c091_abd_e-75918.pdf" H 10075 2300 50  0001 C CNN
	1    10075 2300
	1    0    0    -1  
$EndComp
Text GLabel 10075 2600 2    60   Input ~ 0
DGND
$Comp
L Connector:Conn_01x02_Male J5
U 1 1 5D25B035
P 8150 3100
F 0 "J5" H 8258 3281 50  0000 C CNN
F 1 "ImagingTrig" H 8258 3190 50  0000 C CNN
F 2 "Connector_Molex:Molex_KK-254_AE-6410-02A_1x02_P2.54mm_Vertical" H 8150 3100 50  0001 C CNN
F 3 "~" H 8150 3100 50  0001 C CNN
	1    8150 3100
	1    0    0    -1  
$EndComp
$Comp
L Connector:DIN-6 J11
U 1 1 5D22EBC4
P 10100 3225
F 0 "J11" H 10100 3706 50  0000 C CNN
F 1 "Imaging" H 10100 3615 50  0000 C CNN
F 2 "BhallaLab:Connector_Mini-DIN_Female_6Pin_2rows" H 10100 3225 50  0001 C CNN
F 3 "http://www.mouser.com/ds/2/18/40_c091_abd_e-75918.pdf" H 10100 3225 50  0001 C CNN
	1    10100 3225
	1    0    0    -1  
$EndComp
Text GLabel 9800 3125 0    60   Input ~ 0
ImagingTrig
Text GLabel 10100 3525 2    60   Input ~ 0
DGND
Text GLabel 9775 2200 0    60   Input ~ 0
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
Text GLabel 1225 3250 0    60   Input ~ 0
AGND
$Comp
L power:GNDA #PWR02
U 1 1 5D24B4AF
P 1550 3250
F 0 "#PWR02" H 1550 3000 50  0001 C CNN
F 1 "GNDA" V 1555 3122 50  0000 R CNN
F 2 "" H 1550 3250 50  0001 C CNN
F 3 "" H 1550 3250 50  0001 C CNN
	1    1550 3250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1550 3250 1350 3250
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
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5D24E255
P 1350 3250
F 0 "#FLG01" H 1350 3325 50  0001 C CNN
F 1 "PWR_FLAG" H 1350 3423 50  0000 C CNN
F 2 "" H 1350 3250 50  0001 C CNN
F 3 "~" H 1350 3250 50  0001 C CNN
	1    1350 3250
	1    0    0    -1  
$EndComp
Connection ~ 1350 3250
Wire Wire Line
	1350 3250 1225 3250
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
NoConn ~ 10225 750 
NoConn ~ 10075 2000
NoConn ~ 10375 2200
NoConn ~ 10375 2400
NoConn ~ 9775 2400
NoConn ~ 9800 3325
NoConn ~ 10100 2925
NoConn ~ 10400 3125
NoConn ~ 10400 3325
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
L power:PWR_FLAG #FLG0101
U 1 1 5D29A9FD
P 7900 1125
F 0 "#FLG0101" H 7900 1200 50  0001 C CNN
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
L power:PWR_FLAG #FLG0102
U 1 1 5D29AC37
P 7875 725
F 0 "#FLG0102" H 7875 800 50  0001 C CNN
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
L BhallaLabComponents:PCB-ShockPad ShockPad1
U 1 1 5D3BD131
P 8475 925
F 0 "ShockPad1" H 8825 775 50  0001 C CNN
F 1 "ShockPad" H 9053 730 50  0000 L CNN
F 2 "TerminalBlock:TerminalBlock_Altech_AK300-2_P5.00mm" H 8825 775 50  0001 C CNN
F 3 "" H 8825 775 50  0001 C CNN
	1    8475 925 
	1    0    0    -1  
$EndComp
$EndSCHEMATC
