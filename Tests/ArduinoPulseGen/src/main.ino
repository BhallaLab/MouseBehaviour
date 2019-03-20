/***
 *    Protocol for EyeBlinkConditioning.
 *
 *    The protocols are read from the file '../Protocols/BehaviourProtocols.csv'
 *    by a python script. The cmake build system generates appropriate header
 *    file protocol.h.
 *
 *         Author:  Dilawar Singh <dilawars@ncbs.res.in>
 *   Organization:  NCBS Bangalore
 *
 *        License:  GNU GPLv3
 *
 *  See the GIT changelog for more details.
 */

#include <avr/wdt.h>

#define MYPIN 8

void setup()
{
    Serial.begin(38400);
    pinMode(MYPIN, OUTPUT );
}

void print()
{
    int i = digitalRead(MYPIN);
    Serial.println(i);
}


void loop()
{
    digitalWrite(MYPIN, HIGH);
    delay(2000);
    // print();
    digitalWrite(MYPIN, LOW);
    delay(2000);
    // print();
}
