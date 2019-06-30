EESchema Schematic File Version 4
LIBS:Schematic-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 3
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
L BhallaLabComponents:G3MB202PDC12 K2
U 1 1 5D18AD83
P 5225 3975
F 0 "K2" V 4460 4045 50  0000 C CNN
F 1 "G3MB202PDC12" V 4551 4045 50  0000 C CNN
F 2 "RELAY_G3MB202PDC12" H 5225 3975 50  0001 L BNN
F 3 "" H 5225 3975 50  0001 L BNN
F 4 "Relay • Solid-State • Phototriac • Base: PCB terminal • Amperage: 2 AMP • Coil Voltage: 24 Vdc • Configuration: SPST-..." H 5225 3975 50  0001 L BNN "Field4"
F 5 "G3MB-202P-DC12" H 5225 3975 50  0001 L BNN "Field5"
F 6 "SIP-4 Omron" H 5225 3975 50  0001 L BNN "Field6"
F 7 "None" H 5225 3975 50  0001 L BNN "Field7"
F 8 "Unavailable" H 5225 3975 50  0001 L BNN "Field8"
	1    5225 3975
	0    1    1    0   
$EndComp
Text HLabel 4575 2800 1    50   Input ~ 10
DC+
Text HLabel 4750 2800 1    50   Input ~ 10
DC-
Text HLabel 5425 2825 1    50   Input ~ 10
CH1
Text HLabel 5575 2825 1    50   Input ~ 10
CH2
Text HLabel 4625 4925 3    50   Output ~ 10
A1
Text HLabel 4825 4925 3    50   Output ~ 10
B1
Text HLabel 5125 4925 3    50   Output ~ 10
A2
Text HLabel 5325 4925 3    50   Output ~ 10
B2
Wire Wire Line
	5725 4125 5740 4125
$Comp
L BhallaLabComponents:G3MB202PDC12 K1
U 1 1 5D18ADB3
P 4575 3975
F 0 "K1" V 3810 4045 50  0000 C CNN
F 1 "G3MB202PDC12" V 3901 4045 50  0000 C CNN
F 2 "RELAY_G3MB202PDC12" H 4575 3975 50  0001 L BNN
F 3 "" H 4575 3975 50  0001 L BNN
F 4 "Relay • Solid-State • Phototriac • Base: PCB terminal • Amperage: 2 AMP • Coil Voltage: 24 Vdc • Configuration: SPST-..." H 4575 3975 50  0001 L BNN "Field4"
F 5 "G3MB-202P-DC12" H 4575 3975 50  0001 L BNN "Field5"
F 6 "SIP-4 Omron" H 4575 3975 50  0001 L BNN "Field6"
F 7 "None" H 4575 3975 50  0001 L BNN "Field7"
F 8 "Unavailable" H 4575 3975 50  0001 L BNN "Field8"
	1    4575 3975
	0    1    1    0   
$EndComp
Wire Wire Line
	4875 4425 4875 4625
Wire Wire Line
	4875 4625 4625 4625
Wire Wire Line
	4625 4625 4625 4925
Wire Wire Line
	4875 4125 4900 4125
Wire Wire Line
	4975 4125 4975 4675
Wire Wire Line
	4975 4675 4825 4675
Wire Wire Line
	4825 4675 4825 4925
Connection ~ 4900 4125
Wire Wire Line
	4900 4125 4975 4125
Wire Wire Line
	5550 4425 5550 4575
Wire Wire Line
	5550 4575 5125 4575
Wire Wire Line
	5125 4575 5125 4925
Wire Wire Line
	5550 4125 5600 4125
Wire Wire Line
	5600 4125 5600 4625
Wire Wire Line
	5600 4625 5325 4625
Wire Wire Line
	5325 4625 5325 4925
Wire Wire Line
	5425 2825 5425 2950
Wire Wire Line
	5425 2950 5000 2950
Wire Wire Line
	5000 2950 5000 3625
Wire Wire Line
	5000 3625 4900 3625
Wire Wire Line
	5575 2825 5575 3200
Wire Wire Line
	5575 3200 5675 3200
Wire Wire Line
	5675 3200 5675 3625
Wire Wire Line
	5675 3625 5550 3625
Wire Wire Line
	5550 3500 5550 3475
Connection ~ 5550 3475
Wire Wire Line
	5550 3475 5550 3225
Wire Wire Line
	4900 3225 4900 3475
Wire Wire Line
	4900 3225 5550 3225
Wire Wire Line
	4750 2825 4750 3225
Wire Wire Line
	4750 3225 4900 3225
Connection ~ 4900 3225
$Comp
L BhallaLabComponents:G3MB202PDC12 K3
U 1 1 5D1D4113
P 5950 3975
F 0 "K3" V 5185 4045 50  0000 C CNN
F 1 "G3MB202PDC12" V 5276 4045 50  0000 C CNN
F 2 "RELAY_G3MB202PDC12" H 5950 3975 50  0001 L BNN
F 3 "" H 5950 3975 50  0001 L BNN
F 4 "Relay • Solid-State • Phototriac • Base: PCB terminal • Amperage: 2 AMP • Coil Voltage: 24 Vdc • Configuration: SPST-..." H 5950 3975 50  0001 L BNN "Field4"
F 5 "G3MB-202P-DC12" H 5950 3975 50  0001 L BNN "Field5"
F 6 "SIP-4 Omron" H 5950 3975 50  0001 L BNN "Field6"
F 7 "None" H 5950 3975 50  0001 L BNN "Field7"
F 8 "Unavailable" H 5950 3975 50  0001 L BNN "Field8"
	1    5950 3975
	0    1    1    0   
$EndComp
$Comp
L BhallaLabComponents:G3MB202PDC12 K4
U 1 1 5D1D5B7E
P 6800 3975
F 0 "K4" V 6035 4045 50  0000 C CNN
F 1 "G3MB202PDC12" V 6126 4045 50  0000 C CNN
F 2 "RELAY_G3MB202PDC12" H 6800 3975 50  0001 L BNN
F 3 "" H 6800 3975 50  0001 L BNN
F 4 "Relay • Solid-State • Phototriac • Base: PCB terminal • Amperage: 2 AMP • Coil Voltage: 24 Vdc • Configuration: SPST-..." H 6800 3975 50  0001 L BNN "Field4"
F 5 "G3MB-202P-DC12" H 6800 3975 50  0001 L BNN "Field5"
F 6 "SIP-4 Omron" H 6800 3975 50  0001 L BNN "Field6"
F 7 "None" H 6800 3975 50  0001 L BNN "Field7"
F 8 "Unavailable" H 6800 3975 50  0001 L BNN "Field8"
	1    6800 3975
	0    1    1    0   
$EndComp
Text HLabel 5750 2825 1    50   Input ~ 10
CH3
Text HLabel 5900 2825 1    50   Input ~ 10
CH4
Wire Wire Line
	5750 2825 5750 3075
Wire Wire Line
	5750 3075 6400 3075
Wire Wire Line
	6400 3625 6275 3625
Wire Wire Line
	5900 2825 5900 3000
Wire Wire Line
	5900 3000 7300 3000
Wire Wire Line
	7300 3625 7125 3625
Wire Wire Line
	7300 3000 7300 3625
Wire Wire Line
	6400 3075 6400 3625
Wire Wire Line
	5550 3225 6275 3225
Wire Wire Line
	6275 3225 6275 3475
Connection ~ 5550 3225
Wire Wire Line
	6275 3225 7125 3225
Wire Wire Line
	7125 3225 7125 3475
Connection ~ 6275 3225
Text HLabel 6075 4925 3    50   Output ~ 10
A3
Text HLabel 6350 4925 3    50   Output ~ 10
B3
Text HLabel 6825 4925 3    50   Output ~ 10
A4
Text HLabel 7050 4925 3    50   Output ~ 10
B4
Wire Wire Line
	6075 4925 6075 4575
Wire Wire Line
	6075 4575 6275 4575
Wire Wire Line
	6275 4575 6275 4425
Wire Wire Line
	6350 4925 6350 4125
Wire Wire Line
	6350 4125 6275 4125
Wire Wire Line
	6825 4925 6825 4575
Wire Wire Line
	6825 4575 7125 4575
Wire Wire Line
	7125 4575 7125 4425
Wire Wire Line
	7050 4925 7050 4675
Wire Wire Line
	7050 4675 7250 4675
Wire Wire Line
	7250 4675 7250 4125
Wire Wire Line
	7250 4125 7125 4125
$EndSCHEMATC
