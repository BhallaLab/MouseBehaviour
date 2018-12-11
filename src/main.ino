/***
 *    Protocol for EyeBlinkConditioning. This file contains various protocols
 *    used in BhallaLab for Animal Training. The code of protocol should be
 *    specified in CMakeLists.txt file during compile time.
 *
 *         Author:  Dilawar Singh <dilawars@ncbs.res.in>
 *   Organization:  NCBS Bangalore
 *
 *        License:  GNU GPLv3
 *
 *  See the GIT changelog for more details.
 */

#include <avr/wdt.h>

// Pin configurations and other global variables.
#include "config.h"

// Functions and variable related to rotary encoder.
#include "RotaryEncoder.h"


unsigned long stamp_            = 0;
unsigned dt_                    = 2;
unsigned write_dt_              = 2;
unsigned trial_count_           = 0;
unsigned long trial_start_time_ = 0;
char trial_state_[5]            = "PRE_";

/*-----------------------------------------------------------------------------
 *  User response
 *-----------------------------------------------------------------------------*/
int incoming_byte_              = 0;
bool reboot_                    = false;

/**
 * @brief Interrupt serviving routine (watchdog).
 * @param _vect
 */
ISR(WDT_vect)
{
    // Handle interuppts here.
    // Nothing to handle.
}

void reset_watchdog( )
{
    if( not reboot_ )
        wdt_reset( );
}

unsigned int trace_duration( int st, const char* option = "" )
{
    if( st == 3 )
        return 350;
    else if( st == 4 )
        return 500;
    else if( 5 == st )
        return 650;
    else if( 6 == st )
        return 800;
    else if( 7 == st )
        return 1000;

    return 250;
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

/**
 * @brief Write data line to Serial port in csv format.
 * @param data
 * @param timestamp
 */
void write_data_line( )
{
    reset_watchdog( );

    // Just read the registers where pin data is saved.
    int puff = digitalRead( PUFF_PIN ); 
    int tone = digitalRead( TONE_PIN );
    int led = digitalRead( LED_PIN ); 
    int camera = digitalRead( CAMERA_TTL_PIN ); 
    int microscope = digitalRead( IMAGING_TRIGGER_PIN);

    unsigned long timestamp = millis() - trial_start_time_;

    char msg[100];
    sprintf(msg, "%lu,%d,%d,%d,%d,%d,%d,%s,%ld"
            , timestamp, trial_count_, puff, tone, led
            , camera, microscope, trial_state_, encoder_value_
            );
    Serial.print(msg);

    // sprintf does not support float. Therefore this convoluted way of printing
    // float.
    Serial.print( ',');

    double dt = millis() - lastT_;
    lastT_ = millis();

    // In radian per second.
    angular_velocity_ = 1000 * 2 * 3.1416 * (encoder_value_ - prev_encoder_value_) / 2400.0 / dt;
    prev_encoder_value_ = encoder_value_;

    Serial.println( angular_velocity_, 10 );
    // delay( 3 );
}

void check_for_reset( void )
{
    if( is_command_read( 'r', true ) )
    {
        Serial.println( ">>>Received r. Reboot in 2 seconds" );
        reboot_ = true;
    }
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


/**
 * @brief Wait for trial to start.
 */
void wait_for_start( )
{
    sprintf( trial_state_, "INVA" );
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
        else if( is_command_read( '2', true ) ) 
        {
            Serial.println( ">>>Received 2. Stop capturing frames" );
	    digitalWrite( CAMERA_TTL_PIN, LOW );
        }
        else
        {
            char c = Serial.read( );
            if( c != -1 )
            {
                Serial.print( ">>> Unknown command : " );
                Serial.println( c );
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
    Serial.print( " SESSION TYPE: " );
    Serial.println( SESSION_TYPE );
}


void setup()
{
    Serial.begin( 38400 );

    // Random seed.
    randomSeed( analogRead(A5) );

    //esetup watchdog. If not reset in 2 seconds, it reboots the system.
    wdt_enable( WDTO_2S );
    wdt_reset();
    stamp_ = millis( );

    pinMode( TONE_PIN, OUTPUT );
    pinMode( PUFF_PIN, OUTPUT );
    pinMode( LED_PIN, OUTPUT );

    pinMode( CAMERA_TTL_PIN, OUTPUT );
    pinMode( IMAGING_TRIGGER_PIN, OUTPUT );

    // Rotary encode
    pinMode(ROTARY_ENC_A, INPUT); 
    pinMode(ROTARY_ENC_B, INPUT);

    digitalWrite(ROTARY_ENC_A, HIGH); //turn pullup resistor on
    digitalWrite(ROTARY_ENC_B, HIGH); //turn pullup resistor on

    //call updateEncoder() when any high/low changed seen
    //on interrupt 0 (pin 2), or interrupt 1 (pin 3) 
    attachInterrupt(0, updateEncoder, CHANGE); 
    attachInterrupt(1, updateEncoder, CHANGE);


#ifdef USE_MOUSE
    // Configure mouse here
    mouse.initialize( );
    Serial.println( "Stuck in setup() ... mostly due to MOUSE" );
#else
    Serial.println( "Using LED/DIODE pair" );
    pinMode( MOTION1_PIN, INPUT );
    pinMode( MOTION2_PIN, INPUT );
#endif

    print_trial_info( );
    wait_for_start( );
}

void do_zero_trial( )
{
    return;
}

void do_first_trial( )
{
    return;
}

/**
 * @brief Just for testing.
 *
 * @param duration
 */
void do_empty_trial( size_t trial_num, int duration = 10 )
{
    Serial.print( ">> TRIAL NUM: " );
    Serial.println( trial_num );
    //print_trial_info( );
    delay( duration );
    Serial.println( ">>     TRIAL OVER." );
}

/**
 * @brief Do a single trial.
 *
 * @param trial_num. Index of the trial.
 * @param ttype. Type of the trial.
 */
void do_trial( int cs_type, bool isprobe = false )
{
    reset_watchdog( );
    check_for_reset( );

    print_trial_info( );
    trial_start_time_ = millis( );

    /*-----------------------------------------------------------------------------
     *  PRE. Start imaging;  for 8 seconds.
     *-----------------------------------------------------------------------------*/
    unsigned duration = 8000;
    if (trial_num == 1)
	delay(60); // Shutter delay; Only for the first trial

    stamp_ = millis( );

    sprintf( trial_state_, "PRE_" );
    digitalWrite( IMAGING_TRIGGER_PIN, HIGH);   /* Start imaging. */

    digitalWrite( CAMERA_TTL_PIN, LOW );
    digitalWrite( LED_PIN, LOW );

    while( (millis( ) - trial_start_time_ ) <= duration ) /* PRE_ time */
    {
        // 500 ms before the PRE_ ends, start camera pin high. We start
        // recording as well.
        if( (millis( ) - stamp_) >= (duration - 500 ) )
            if( LOW == digitalRead( CAMERA_TTL_PIN ) )
                digitalWrite( CAMERA_TTL_PIN, HIGH );

        write_data_line( );
    }
    stamp_ = millis( );

    /*-----------------------------------------------------------------------------
     *  CS: 50 ms duration. No tone is played here. Write LED pin to HIGH.
     *  Play CS only when SESSION_TYPE is not 5.
     *-----------------------------------------------------------------------------*/
    if( 1 == SESSION_TYPE )
    {
        sprintf( trial_state_, "NOCS" );
        duration =  LED_DURATION;
        while( (millis( ) - stamp_) <= duration )
            write_data_line( );
    }
    else
    {
        duration = LED_DURATION;
        stamp_ = millis( );
        sprintf( trial_state_, "CS+" );
        led_on( duration );
    }

    stamp_ = millis( );

    /*-----------------------------------------------------------------------------
     *  TRACE. The duration of trace varies from trial to trial.
     *-----------------------------------------------------------------------------*/
    duration = trace_duration( SESSION_TYPE );
    sprintf( trial_state_, "TRAC" );
    while( (millis( ) - stamp_) <= duration )
        write_data_line( );
    stamp_ = millis( );

    /*-----------------------------------------------------------------------------
     *  PUFF for 50 ms if trial is not a probe type.
     *-----------------------------------------------------------------------------*/
    if( 1 == SESSION_TYPE || 2 == SESSION_TYPE )
    {
        sprintf( trial_state_, "NOPF" );
        duration =  PUFF_DURATION;
        while( (millis( ) - stamp_) <= duration )
            write_data_line( );
    }
    else
    {
        duration = PUFF_DURATION;
        if( isprobe )
        {
            sprintf( trial_state_, "PROB" );
            while( (millis( ) - stamp_) <= duration )
                write_data_line( );
        }
        else
        {
            sprintf( trial_state_, "PUFF" );
            play_puff( duration );
        }
    }
    stamp_ = millis( );
    
    /*-----------------------------------------------------------------------------
     *  POST, flexible duration till trial is over. It is 8 second long.
     *-----------------------------------------------------------------------------*/
    // Last phase is post. If we are here just spend rest of time here.
    duration = 8000;
    sprintf( trial_state_, "POST" );
    while( (millis( ) - stamp_) <= duration )
    {
        write_data_line( );
        // Switch camera OFF after 500 ms into POST.
        if( (millis() - stamp_) >= 500 )
            digitalWrite( CAMERA_TTL_PIN, LOW );
    }


    /*-----------------------------------------------------------------------------
     *  End trial.
     *-----------------------------------------------------------------------------*/
    digitalWrite( IMAGING_TRIGGER_PIN, LOW ); /* Shut down the imaging. */
    sprintf( trial_state_, "ITI_" );

    Serial.print( ">>END Trial " );
    Serial.print( trial_count_ );
    Serial.println( " is over. Starting new");
}

void loop()
{
    reset_watchdog( );

    // Initialize probe trials index. Mean 6 +/- 2 trials. 
    proble_trial_index_init( 6, 2 );

    for (size_t i = 0; i <= 102; i++) 
    {

        reset_watchdog( );

        // These are normal trial with either SOUND or LIGHT.
        if( SESSION_TYPE == 'S' || SESSION_TYPE == 'L' )
        {
            int cs_type = SOUND;
            if( 'L' == SESSION_TYPE )
                cs_type = LIGHT;

            bool isprobe = false;

            // Probe trial.
            if( i == nextProbbeTrialIndex )
            {
                isprobe = true;
                numProbeTrials +=1 ;
                nextProbbeTrialIndex = random( 
                        (numProbeTrials+1)*10-2, (numProbeTrials+1)*10+3
                        );
            }
#if DEBUG
            if( isprobe )
            {
                Serial.print( ">> PROBE TRIAL. Index :" );
                Serial.print( i );
                Serial.print( ". Next probe " );
                Serial.println( nextProbbeTrialIndex );
            }
#endif

#if DEBUG
            do_empty_trial( i );
#else
            do_trial( cs_type, isprobe );
#endif
        }
	/*************************************************************************
	* MIXED TRIALS
	*************************************************************************/

        else if( 'M' == SESSION_TYPE )  // These are mixed trials.
        {
            // Every 5, 10, 15 etc trial is proble trials.
            bool isprobe = false;
            if( i % 5 == 0 )
                isprobe = true;

#if DEBUG
            if( isprobe )
            {
                Serial.print( ">> PROBE TRIAL. Index :" );
                Serial.println( i );
            }
#endif

            // 1-4, 11-14, 21-24 etc are trails with SOUND.
            int cs_type = LIGHT;
            if( i % 10 > 0 && i % 10 <= 5 )
                cs_type = SOUND;
#if DEBUG
            do_empty_trial( i );
#else
            do_trial( cs_type, isprobe );
#endif

        }
        else
            do_trial( i, false );
        
        /*-----------------------------------------------------------------------------
         *  ITI.
         *-----------------------------------------------------------------------------*/
        unsigned long rduration = random( 23000, 25001);
        stamp_ = millis( );
        sprintf( trial_state_, "ITI_" );
        while((millis( ) - stamp_) <= rduration )
        {
            reset_watchdog( );
            delay( 10 );
        }
        trial_count_ += 1;
    }

    // Don't do anything once trails are over.
    while( true )
    {
        reset_watchdog( );
        Serial.println( ">>> All done" );
        delay( 1000 );
    }
}
