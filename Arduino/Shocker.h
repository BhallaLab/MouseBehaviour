/*
 *    Description:  Shock protocol. 
 *        Author :  Upinder Bhalla. See attached file on issue #44.
 *     Maintainer:  Dilawar Singh (), dilawars@ncbs.res.in
 *   Organization:  NCBS Bangalore
 *
 */

#ifndef SHOCKER_H
#define SHOCKER_H

int NUM_SAMPLES        = 100;
int idx                = 0;

// Do analog sampling only 1 in 10 times, for a freq of of 100 Hz.
int SAMPLING_DIVIDER   = 10;
int STIM_INTERVAL      = 150;
int NUM_LOOP_RESET     = 50;

// Minimum reading for foot touch to allow stimulus to go ahead.
int TOUCH_THRESHOLD    = 50;
int numLoops           = 0;
int shock_pin_readout  = 0;

void configureShockingTimer() 
{
    Serial.println("[INFO] Configuring ShockingTimer --- ");
    cli(); // stop interrupts
    TCCR1A = _BV( COM1A1 ) | _BV(COM1B1) | _BV(WGM11) | _BV(WGM10);

    // Respectively: set Waveform Generation Mode to fast PWM, prescaler (CS) to 64x.
    TCCR1B = _BV(WGM12) | _BV(CS12);
    TIMSK1 |= _BV( OCIE1A ); // Enable timer compare interrupt.
    OCR1A = 255; // half duty cycle
    OCR1B = 128;
    sei(); // enable interrupts
}

void stop_shocker() 
{
    Serial.print('.');
    cli();
    // Disable interrupt
    TIMSK1 &= ~_BV(OCIE1A);

    // Disable the timer: We don't do this now to avoid on-off clicks.
    // TCCR1B &= ~(_BV(WGM12) | _BV(CS10));
    sei();
    // digitalWrite( pwm, 0);
}


/* --------------------------------------------------------------------------*/
/**
 * @Synopsis  ISR.
 *
 * THIS TIMER IS 8 bit.
 *
 * NOTE: Timer1 controlls pin 5. This PIN acts as a fast switch: switching
 *       between stimulus delivery (when available) and reading value from
 *       SHOCK pad. When reading values from SHOCK_VALUE, a 5V 
 *
 *       TIMER0 is used by millis(), delays() etc. Better I do not touch it.
 *       TIMER2 is used by tone(). You can't use it here.
 *
 *       TIMER1 is used which is 16 bits.
 */
/* ----------------------------------------------------------------------------*/
ISR(TIMER1_COMPA_vect) 
{
    // do analog read
    idx++;
    if (idx >= SAMPLING_DIVIDER) 
    {
        idx = 0;
        shock_pin_readout = analogRead( SHOCK_PAD_READOUT_PIN );
        // stop_shocker();
    }
}

#endif /* end of include guard: SHOCKER_H */
