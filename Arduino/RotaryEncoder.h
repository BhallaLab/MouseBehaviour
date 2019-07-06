/*
 * =====================================================================================
 *
 *       Filename:  RotaryEncoder.h
 *
 *    Description:  Functions related to rotary encoder. Our encoder has 2400
 *    steps per rotations. More details must be in BhallaLab online lab-notebook.
 *
 *        Version:  1.0
 *        Created:  Tuesday 11 December 2018 10:03:29  IST
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dilawar Singh (), dilawars@ncbs.res.in
 *   Organization:  NCBS Bangalore
 *
 * =====================================================================================
 */

#ifndef  RotaryEncoder_INC
#define  RotaryEncoder_INC

#include "config.h"

volatile int pin2_;
volatile int pin3_;

// Global for rotary encoder.
long last_encoded_       = 0;
long encoder_value_      = 0;
long prev_encoder_value_ = 0;
unsigned long lastT_     = 0;
long pin2Count_          = 0;
long pin3Count_          = 0;
long val_                = 0;

// radian per second.
double angular_velocity_ = 0.0;
 
void ISR_ON_PIN2( )
{
    // Read the other pin. This pin is HIGH.
    pin3_ = digitalRead( 3 ); 
    // If this pin leads the other pin then add 1 else substract 1.
    pin2Count_ += pin3_ ? -1 : +1;
    encoder_value_ = (pin3Count_ + pin2Count_);
}

void ISR_ON_PIN3( )
{
    // Read the other pin. This pin is HIGH.
    pin2_ = digitalRead(2);
    // If this pin leads the other pin then subtract 1 else add 1.
    pin3Count_ += pin2_ ? +1 : -1;
}

#endif   /* ----- #ifndef RotaryEncoder_INC  ----- */

