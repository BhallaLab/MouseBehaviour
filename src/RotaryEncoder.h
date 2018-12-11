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

// Global for rotary encoder.
long last_encoded_  = 0;
long encoder_value_      = 0;
long prev_encoder_value_ = 0;

unsigned long lastT_     = 0;
// radian per second.
double angular_velocity_ = 0.0;
 
// This code is from  https://robu.in/product/incremental-optical-rotary-encoder-6002400-pulse-600-ppr/
void updateEncoder()
{

    // get the anular velocity
    // This rotary encode has 2400 transitions per second.
    // https://robokits.co.in/automation-control-cnc/encoders/rotary-quadrature-encoder-600ppr-2400cpr?gclid=EAIaIQobChMI-62Y8-Co3gIVVxOPCh29fgXcEAQYBCABEgJK6_D_BwE
    // Rotary Quadrature Encoder 600PPR/2400CPR

    int MSB = digitalRead(ROTARY_ENC_A); //MSB = most significant bit
    int LSB = digitalRead(ROTARY_ENC_B); //LSB = least significant bit

    int encoded = (MSB << 1) |LSB; //converting the 2 pin value to single number
    int sum  = (last_encoded_ << 2) | encoded; //adding it to the previous encoded value
 
    if(sum == 0b1101 || sum == 0b0100 || sum == 0b0010 || sum == 0b1011) encoder_value_ ++;
    if(sum == 0b1110 || sum == 0b0111 || sum == 0b0001 || sum == 0b1000) encoder_value_ --;

    last_encoded_ = encoded; //store this value for next time
}

#endif   /* ----- #ifndef RotaryEncoder_INC  ----- */

