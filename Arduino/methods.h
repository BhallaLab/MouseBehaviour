// =====================================================================================
//
//       Filename:  helper.h
//
//    Description:  
//
//        Version:  1.0
//        Created:  Wednesday 25 September 2019 07:07:26  IST
//       Revision:  none
//       Compiler:  g++
//
//         Author:  Dilawar Singh (), dilawar.s.rajput@gmail.com
//   Organization:  NCBS Bangalore
//
// =====================================================================================

#ifndef HELPER_H
#define HELPER_H



/* --------------------------------------------------------------------------*/
/** WATCHDOG TIMER:
 * @Synopsis  When ctrl+c is pressed, reboot_ is set true and we restart the
 * arduino. Without watchdog timer, I could not think of any other way to
 * implement ctrl+C resetting the board.
 */
/* ----------------------------------------------------------------------------*/
ISR(WDT_vect)
{ }

void reset_watchdog( )
{
    if( not reboot_ )
        wdt_reset( );
}


/**
 * @brief  Read a command from command line. Consume when character is matched.
 *
 * @param command
 *
 * @return False when not mactched. If first character is matched, it is
 * consumed, second character is left in  the buffer.
 */
bool is_command_read( char command, bool consume = true )
{
    if( ! Serial.available() )
        return false;

    // Peek for the first character.
    if( command == Serial.peek( ) )
    {
        if( consume )
            Serial.read( );
        return true;
    }

    return false;
}

void check_for_reset( void )
{
    if( is_command_read('r', true ) )
    {
        Serial.println( ">>> Received r. Reboot in 2 seconds" );
        reboot_ = true;
    }
}


/**
 * @brief Write data line to Serial port in csv format.
 * @param data
 * @param timestamp
 */
void write_data_line( )
{
    check_for_reset();
    reset_watchdog();

    // Just read the registers where pin data is saved.
    int puff = digitalRead( PUFF_PIN );
    int tone = digitalRead( TONE_PIN );
    int led = digitalRead( LED_PIN );
    int camera = digitalRead( CAMERA_TTL_PIN );
    int microscope = digitalRead( IMAGING_TRIGGER_PIN);

    unsigned long timestamp = millis() - trial_start_time_;

    char msg[100];
    sprintf(msg, "%lu,%s,%d,%d,%d,%d,%d,%d,%s,%d,%ld"
            , timestamp, PROTO_CODE, trial_count_
            , puff, tone, led
            , camera, microscope, trial_state_
            , shock_pin_readout, encoder_value_
           );

    // Compute angular velocity.
    int dt = millis() - lastT_;
    lastT_ = millis();
    angular_velocity_ = 2*3.1416*(encoder_value_ - prev_encoder_value_)/1200.0/dt;
    prev_encoder_value_ = encoder_value_;

    Serial.print(msg + String(","));
    Serial.println(angular_velocity_, 5);
}

/**
 * @brief Play tone for given period and duty cycle.
 *
 * NOTE: We can not block the arduino using delay, since we have to write the
 * values onto Serial as well.
 *
 * @param period
 * @param duty_cycle
 */
void play_tone( unsigned long period, double duty_cycle = 0.5 )
{
    reset_watchdog( );
    check_for_reset( );
    unsigned long toneStart = millis();
    while( (millis() - toneStart) <= period )
    {
        write_data_line();
        if( (millis() - toneStart) <= (period * duty_cycle) )
            tone( TONE_PIN, TONE_FREQ );
        else
            noTone( TONE_PIN );
    }
    noTone( TONE_PIN );
}


/**
 * @brief Play puff for given duration.
 *
 * @param duration
 */
void play_puff( unsigned long duration )
{
    check_for_reset( );
    stamp_ = millis();
    while( millis() - stamp_ <= duration )
    {
        digitalWrite( PUFF_PIN, HIGH);
        write_data_line( );
    }
    digitalWrite( PUFF_PIN, LOW );
}

void led_on( unsigned int duration )
{
    stamp_ = millis( );
    while( millis() - stamp_ <= duration )
    {
        digitalWrite( LED_PIN, HIGH );
        write_data_line( );
    }
    digitalWrite( LED_PIN, LOW );
}

/* --------------------------------------------------------------------------*/
/**
 * @Synopsis  Apply shock to animal.
 *
 * @Param duration
 */
/* ----------------------------------------------------------------------------*/
void deliverShock( int duration )
{
    Serial.println( ">>>Delivering shock" );
    enableInputToStimIsolator();
    stamp_ = millis();
    while( (millis() - stamp_) < duration)
        write_data_line();
    disableInputToStimIsolator();
}


/**
 * @brief Wait for trial to start.
 */
void wait_for_start( )
{
    sprintf( trial_state_, "INVA" );
    enableReadingShockPad();

    while( true )
    {

        /*-----------------------------------------------------------------------------
         *  Make sure each after reading command, we send >>>Received to serial
         *  port. The python client waits for it.
         *-----------------------------------------------------------------------------*/
        write_data_line( );
        if( is_command_read( 's', true ) )
        {
            Serial.println( ">>>Received s. Start" );
            break;                              /* Only START can break the loop */
        }
        else if( is_command_read( 'p', true ) )
        {
            Serial.println( ">>>Received p. Playing puff" );
            play_puff( PUFF_DURATION );
        }
        else if( is_command_read( 't', true ) )
        {
            Serial.println( ">>>Received t. Playing tone" );
            play_tone( TONE_DURATION, 1.0);
        }
        else if( is_command_read( 'c', true ) )
        {
            Serial.println( ">>>Received c. Giving shock for 500 ms" );
            disableReadingShockPad();
            delay(10);
            deliverShock( 500 );
            delay(10);
            enableReadingShockPad();
        }
        else if( is_command_read( 'l', true ) )
        {
            Serial.println( ">>>Received l. LED ON" );
            led_on( LED_DURATION );
        }
        else if( is_command_read( '1', true ) )
        {
            Serial.println( ">>>Received 1. Start capturing frame" );
            digitalWrite( CAMERA_TTL_PIN, HIGH );
        }
        else if( is_command_read( 'r', true ) )
        {
            Serial.println( ">>>Received r. Rebooting " );
            reboot_ = true;
        }
        else if( is_command_read( '2', true ) )
        {
            Serial.println( ">>>Received 2. Stop capturing frames" );
            digitalWrite( CAMERA_TTL_PIN, LOW );
        }
        else
        {
            char c = Serial.read( );
            if(c > ' ')
            {
                Serial.print( ">>> Unknown command: " );
                Serial.println(c);
            }
        }
    }
}

void print_trial_info( )
{
    Serial.print( ">> ANIMAL NAME: " );
    Serial.print( ANIMAL_NAME );
    Serial.print( " SESSION NUM: " );
    Serial.print( SESSION_NUM );
    Serial.print( " PROTO CODE: " );
    Serial.println(PROTO_CODE);
}

#endif /* end of include guard: HELPER_H */
