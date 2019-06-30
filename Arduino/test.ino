/*
   paw1.ino: program to generate a square wave at 3 Khz and monitor the
   current going through the mouse paw, as a way to see if it is up or
   down.

   Original by Upi Bhalla.

*/

int pwm = 3;           // the PWM pin
int relay = 7;			// the RELAY pin
int stimIsolator = 8;			// the stimIsolator pin

int resolution = 256;

int sample = 0;

int NUM_SAMPLES = 100;
int idx = 0;
int SAMPLING_DIVIDER = 10; // Do analog sampling only 1 in 10 times, for a freq of of 100 Hz.
int STIM_INTERVAL = 150;
int NUM_LOOP_RESET = 50;
int TOUCH_THRESHOLD = 50; // Minimum reading for foot touch to allow stimulus to go ahead.
int numLoops = 0;

void startPlayback()
{
    cli(); // stop interrupts
    TCCR2A = _BV( COM2A1 ) | _BV(COM2B1) | _BV(WGM21) | _BV(WGM20);
    // Respectively: set Waveform Generation Mode to fast PWM, prescaler (CS) to 64x
    TCCR2B = _BV(WGM22) | _BV(CS22);
    TIMSK2 |= _BV( OCIE2A ); // Enable timer compare interrupt.
    OCR2A = 255; // half duty cycle
    OCR2B = 128;
    sei(); // enable interrupts
}

void stopPlayback()
{
    cli();
    // Disable interrupt
    TIMSK2 &= ~_BV(OCIE2A);
    // Disable the timer: We don't do this now to avoid on-off clicks.
    // TCCR2B &= ~(_BV(WGM22) | _BV(CS20));
    sei();
    // digitalWrite( pwm, 0);
}

ISR(TIMER2_COMPA_vect)
{
    // do analog read
    idx++;
    if (idx >= SAMPLING_DIVIDER)
    {
        idx = 0;
        sample = analogRead( A3 );
        Serial.print('x');
        Serial.println(sample);
        stopPlayback();
    }
}


// the setup routine runs once when you press reset:
void setup()
{
    // declare pin 3 to be an output:
    pinMode(pwm, OUTPUT);
    pinMode(relay, OUTPUT);
    pinMode(A3, INPUT);
    pinMode(stimIsolator, OUTPUT);
    digitalWrite( relay, HIGH ); // set relay to connect ADC to touch pad
    //pinMode(11, OUTPUT);
    Serial.begin( 115200 );
}

// the loop routine runs over and over again forever:
void loop()
{
    startPlayback();
    // Serial.println( sample );
    //Serial.flush();
    delay(1);
    if ( numLoops > STIM_INTERVAL )
    {
        if ( sample < TOUCH_THRESHOLD )
        {
            // Oops, the animal isn't even touching the pad. Wait a bit.
            numLoops = NUM_LOOP_RESET;
        }
        else     // Give the tingle stimulus.
        {
            digitalWrite( relay, LOW ); // Switch in the stim, switch out ADC
            delay(10);
            digitalWrite( stimIsolator, HIGH ); // Deliver stimulus.
            delay(50);
            digitalWrite( stimIsolator, LOW );
            delay(10);
            digitalWrite( relay, HIGH ); // Switch back to ADC
            numLoops = 0;
        }
    }
    numLoops++;
}

