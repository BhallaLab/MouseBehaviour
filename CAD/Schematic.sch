EESchema Schematic File Version 4
LIBS:test-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 2
Title "Shocking Protocol"
Date ""
Rev "0.0.1"
Comp "Bhalla Lab"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Module:Arduino_UNO_R3 ArduinoUno
U 1 1 5D1837FC
P 6800 3200
F 0 "ArduinoUno" H 6800 4381 50  0000 C CNB
F 1 "Arduino_UNO_R3" H 6800 4290 50  0000 C CNN
F 2 "Module:Arduino_UNO_R3" H 6950 2150 50  0001 L CNN
F 3 "https://www.arduino.cc/en/Main/arduinoBoardUno" H 6600 4250 50  0001 C CNN
	1    6800 3200
	1    0    0    -1  
$EndComp
$Comp
L OrangeRotaryEncoder:RotaryEncoder RotaryEncoder?
U 1 1 5D191567
P 4650 2700
F 0 "RotaryEncoder?" H 4650 2700 50  0001 C CNN
F 1 "RotaryEncoder" H 5368 2700 0   0000 L CNN
F 2 "" H 4450 2850 50  0001 C CNN
F 3 "https://robu.in/wp-content/uploads/2016/02/User-Manual-Orange-3806-OPTI-400-AB-OC-Rotary-Encoder-ROBU.IN_.pdf" H 4450 2850 50  0001 C CNN
	1    4650 2700
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 2500 5900 2500
Wire Wire Line
	5900 2500 5900 2800
Wire Wire Line
	5900 2800 6300 2800
Wire Wire Line
	5000 2600 5800 2600
Wire Wire Line
	5800 2600 5800 2900
Wire Wire Line
	5800 2900 6300 2900
$Comp
L BhallaLabComponents:ShockPad ShockPad?
U 1 1 5D197A8E
P 4550 3750
F 0 "ShockPad?" H 4900 3600 50  0001 C CNN
F 1 "ShockPad" H 3782 3530 50  0000 R CNN
F 2 "" H 4900 3600 50  0001 C CNN
F 3 "" H 4900 3600 50  0001 C CNN
	1    4550 3750
	1    0    0    -1  
$EndComp
$Sheet
S 3300 5200 2200 1000
U 5D1ADABF
F0 "SSR 4Channel" 50
F1 "SSR_4CH.sch" 50
F2 "DC+" I L 3300 5400 50 
F3 "DC-" I L 3300 5525 50 
F4 "CH1" I L 3300 5750 50 
F5 "CH2" I L 3300 5850 50 
F6 "CH3" I L 3300 5950 50 
F7 "CH4" I L 3300 6050 50 
F8 "A1" O R 5500 5300 50 
F9 "B1" O R 5500 5375 50 
F10 "B2" O R 5500 5550 50 
F11 "A3" O R 5500 5700 50 
F12 "B3" O R 5500 5800 50 
F13 "A4" O R 5500 5925 50 
F14 "B4" O R 5500 6000 50 
F15 "A2" O R 5500 5475 50 
$EndSheet
$Comp
L Simulation_SPICE:IDC I?
U 1 1 5D189A99
P 3125 3350
F 0 "I?" H 3255 3441 50  0000 L CNN
F 1 "IDC" H 3255 3350 50  0000 L CNN
F 2 "" H 3125 3350 50  0001 C CNN
F 3 "~" H 3125 3350 50  0001 C CNN
F 4 "Y" H 3125 3350 50  0001 L CNN "Spice_Netlist_Enabled"
F 5 "I" H 3125 3350 50  0001 L CNN "Spice_Primitive"
F 6 "dc(1)" H 3255 3259 50  0000 L CNN "Spice_Model"
	1    3125 3350
	1    0    0    -1  
$EndComp
Wire Wire Line
	3125 3550 4000 3550
Wire Wire Line
	4000 3550 4000 3600
$EndSCHEMATC
