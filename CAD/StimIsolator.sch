EESchema Schematic File Version 4
LIBS:Schematic-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 3
Title "Stim Isolator - Black box"
Date ""
Rev "0.1.0"
Comp "BhallaLab"
Comment1 "Incomplete."
Comment2 "VENDOR: ISO Flex AMPI."
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:Battery BT1
U 1 1 5D1928AF
P 5075 3100
F 0 "BT1" H 5183 3146 50  0000 L CNN
F 1 "Batterr 90V" H 5183 3055 50  0000 L CNN
F 2 "" V 5075 3160 50  0001 C CNN
F 3 "~" V 5075 3160 50  0001 C CNN
	1    5075 3100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5D1939C5
P 5075 3500
F 0 "#PWR?" H 5075 3250 50  0001 C CNN
F 1 "GND" H 5080 3327 50  0000 C CNN
F 2 "" H 5075 3500 50  0001 C CNN
F 3 "" H 5075 3500 50  0001 C CNN
	1    5075 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	5075 3300 5075 3500
Text HLabel 3775 3500 0    50   Input ~ 0
INPUT
Text HLabel 6425 3300 2    50   Output ~ 0
OUT+
Text HLabel 6425 3675 2    50   Output ~ 0
OUT-
$Comp
L Device:R_Variable R?
U 1 1 5D19516A
P 4700 4150
F 0 "R?" V 4455 4150 50  0000 C CNN
F 1 "R_Variable" V 4546 4150 50  0000 C CNN
F 2 "" V 4630 4150 50  0001 C CNN
F 3 "~" H 4700 4150 50  0001 C CNN
	1    4700 4150
	0    1    1    0   
$EndComp
$Comp
L Device:R_Variable R?
U 1 1 5D1978E1
P 5550 4200
F 0 "R?" V 5815 4200 50  0000 C CNN
F 1 "R_Variable" V 5724 4200 50  0000 C CNN
F 2 "" V 5480 4200 50  0001 C CNN
F 3 "~" H 5550 4200 50  0001 C CNN
	1    5550 4200
	0    -1   -1   0   
$EndComp
$EndSCHEMATC
