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


/* --------------------------------------------------------------------------*/
/**
 * @Synopsis  ISR.
 *
 * @Param TIMER1_COMPA_vect  When Timer1 overflows, the interrupt vector
 * TIMER1_COMPA is read by the CPU. 
 * NOTE: Timer2 is used by rotary encoder which is on PIN3.
 *       Time1 controlls pin 5 which is Shocker.
 */
/* ----------------------------------------------------------------------------*/
ISR(TIMER1_COMPA_vect) 
{
    // do analog read
    Serial.println("Int");
    idx++;
    if (idx >= SAMPLING_DIVIDER) 
    {
        idx = 0;
        shock_pin_readout = analogRead( SHOCK_PAD_READOUT_PIN );
        stop_shocker();
    }
}

void start_shocker() 
{
    Serial.println('+');
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
    Serial.println('.');
    cli();
    // Disable interrupt
    TIMSK1 &= ~_BV(OCIE1A);

    // Disable the timer: We don't do this now to avoid on-off clicks.
    // TCCR1B &= ~(_BV(WGM12) | _BV(CS10));
    sei();
    // digitalWrite( pwm, 0);
}


#endif /* end of include guard: SHOCKER_H */
