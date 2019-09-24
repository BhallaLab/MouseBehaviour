/***
 *    The protocols are stored in '../Protocols/BehaviourProtocols.csv'. A
 *    protocol is chosen at build time by passing -DPROTO_CODE option to cmake.
 *    A python script '../Protocols/protocol_to_config.py" converts a given
 *    protocol to protocol.h file.
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

// Protocol information is in this file. Note that this file is generated by
// build system (cmake) at configuration time.
#include "protocol.h"

// Functions and variable related to rotary encoder.
#include "RotaryEncoder.h"
#include "Shocker.h"

unsigned long stamp_            = 0;
unsigned dt_                    = 2;
unsigned write_dt_              = 2;
unsigned trial_count_           = 0;
unsigned long trial_start_time_ = 0;
int incoming_byte_              = 0;
bool reboot_                    = false;

// NOTE: Should be big enough to hold the state. 10 char long is ok.
// NOTE: ProtoUSValue should be more than 10 character long.
char trial_state_[11]            = "PRE_";


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


void setup()
{
    // Set the highest baud rate possible. The value of x for baud rate is
    // rougly x/10 char per seconds or x/1000 char per 10 ms. We want rougly 100
    // chars per ms i.e. baud rate should be higher than 100,000.
    Serial.begin( 115200 );


    // Random seed.
    randomSeed( analogRead(A5) );

    //esetup watchdog. If not reset in 2 seconds, it reboots the system.
    stamp_ = millis( );

    pinMode(SHOCK_PWM_PIN, OUTPUT);
    pinMode(SHOCK_STIM_ISOLATER_PIN, OUTPUT);

    pinMode( SHOCK_RELAY_PIN_CHAN_12, OUTPUT);
    pinMode( SHOCK_RELAY_PIN_CHAN_34, OUTPUT);

    // CS AND US
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

    // NOTE: This changes with board. Testing with UNO. The above snippet is
    // preferred when available.
    attachInterrupt(0, ISR_ON_PIN2, RISING);
    attachInterrupt(1, ISR_ON_PIN3, RISING);

    // It is in Shocker.h file.
    configureShockingTimer();

    // setup watchdog. If not reset in 2 seconds, it reboots the system.
    wdt_enable( WDTO_2S );
    wdt_reset();
    
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

void wait_and_print( size_t howlong )  // ms
{
    int s = millis();
    while( millis() - s <= howlong )
        write_data_line();
}


/**
 * @brief Do a single trial.
 *
 * @param trial_num. Index of the trial.
 * @param ttype. Type of the trial.
 */
void do_trial( size_t trial_num, bool isprobe = false )
{
    reset_watchdog( );
    check_for_reset( );

    print_trial_info( );
    trial_start_time_ = millis( );

#if 0
    /*-----------------------------------------------------------------------------
     * PRE. Start imaging;
     * Usually durations of PRE_ is 8000 ms. For some trials is it randomly
     * chosen between 6000 ms and 8000 ms. See protocol.h file and
     * ./Protocols/BehaviourProtocols.xlsx file.
     *-----------------------------------------------------------------------------*/
    size_t duration = random(PROTO_PreStimDuration_LOW, PROTO_PreStimDuration_HIGH+1);

    // From Ananth. He suggested that 60ms delay is required for every protocol. This is
    // apprently shutter delay for the camera and only required for trial number
    // 1.
    if (trial_num > 0)
        delay(60); // Shutter delay.

    stamp_ = millis( );

    sprintf(trial_state_, "PRE_" );
    digitalWrite(IMAGING_TRIGGER_PIN, HIGH);   // Imaging START
    digitalWrite(CAMERA_TTL_PIN, LOW );        // Camera STOP.
    digitalWrite(LED_PIN, LOW );               // LED STOP.

    while( (millis( ) - trial_start_time_ ) <= duration ) /* PRE_ time */
    {
        // 500 ms before the PRE_ ends, start camera pin high. We start
        // recording as well.
        if( (millis( ) - stamp_) >= (duration - 500 ) )
        {
            if( LOW == digitalRead( CAMERA_TTL_PIN ) )
            {
                digitalWrite( CAMERA_TTL_PIN, HIGH );
            }
        }

        write_data_line( );
    }
    stamp_ = millis( );

    /*-----------------------------------------------------------------------------
     *  CS: 50 ms duration.
     *-----------------------------------------------------------------------------*/
    duration = PROTO_CSDuration;
    if( String("NONE") == String(PROTO_CSValue) )
    {
        sprintf( trial_state_, "NOCS" );
        while((millis( ) - stamp_) <= duration)
        {
            write_data_line( );
        }
    }
    else
    {
        stamp_ = millis( );
        sprintf( trial_state_, "CS+" );
        if(String("LIGHT") == String(PROTO_CSValue))
        {
            led_on( duration );
        }
        else if(String("TONE") == String(PROTO_CSValue))
        {
            play_tone(duration);
        }
        else if(String("TONE/LIGHT") == String(PROTO_CSValue))
        {
            // Because real trial starts from trial #1.
            if((trial_num-1) % 10 < 5)
                play_tone(duration);
            else
                led_on(duration);
        }
        else
        {
            Serial.println( "<<<Error: Unknown CS" );
        }
    }

    stamp_ = millis( );

    /*-----------------------------------------------------------------------------
     *  TRACE. The duration of trace varies from trial to trial. If US is shock
     *  then 10ms before the US, switch on the relay pin.
     *-----------------------------------------------------------------------------*/
    if(String(PROTO_USValue) == String("SHOCK"))
        duration = PROTO_TraceDuration - 10;
    else
        duration = PROTO_TraceDuration;

    sprintf( trial_state_, "TRAC" );
    while( (millis() - stamp_) <= duration )
        write_data_line();
    stamp_ = millis();

    if(String(PROTO_USValue) == String("SHOCK"))
    {
        //Serial.println( ">>>Disabled SHOCKPAD." );
        disableReadingShockPad();
        delay(10);
    }

    /*-----------------------------------------------------------------------------
     *  US for 50 ms if trial is not a probe type.
     *-----------------------------------------------------------------------------*/
    duration = PROTO_USDuration;
    if(isprobe)
    {
        sprintf( trial_state_, "PROB" );
        while( (millis( ) - stamp_) <= duration )
            write_data_line( );
    }
    else
    {
        sprintf( trial_state_, PROTO_USValue );
        if(String(PROTO_USValue) == String("SHOCK"))
        {
            //Serial.println( ">>> DELIVER shock");
            deliverShock(duration);
        }
        else if(String(PROTO_USValue) == String("PUFF"))
            play_puff( duration );
        else
        {
            while( (millis( ) - stamp_) <= duration )
                write_data_line( );
        }
    }

    // POST has started.
    stamp_ = millis( );
    sprintf( trial_state_, "POST" );
    if(String(PROTO_USValue) == String("SHOCK"))
    {
        delay(10);
        //Serial.println( ">>>Enabled SHOCKPAD." );
        enableReadingShockPad();
    }

    /*-----------------------------------------------------------------------------
     *  POST, flexible duration till trial is over. It is 8 second long.
     *-----------------------------------------------------------------------------*/
    // Last phase is post. If we are here just spend rest of time here.
    duration = PROTO_PostStimDuration;
    while( (millis( ) - stamp_) <= duration )
    {
        write_data_line( );
        // Switch camera OFF after 2500 ms into POST.
        if( (millis() - stamp_) >= 2500 )
            digitalWrite( CAMERA_TTL_PIN, LOW );
    }

    digitalWrite( IMAGING_TRIGGER_PIN, LOW ); /* Shut down the imaging. */

    /*-----------------------------------------------------------------------------
     *  ITI.
     *-----------------------------------------------------------------------------*/
    unsigned long rduration = random(23000, 25001);
    Serial.print(">>Trial is over. Waiting "); 
    Serial.print(rduration - stamp_);
    Serial.println(" ms (ITI) before starting new trial." );
    stamp_ = millis();
    sprintf(trial_state_, "ITI_");
    while((millis() - stamp_) <= rduration)
    {
        reset_watchdog();
        write_data_line();
        delay(200);
    }
#endif 
}

void loop()
{
    reset_watchdog();

    // Initialize probe trials index. Mean 6 +/- 2 trials.
    unsigned numProbeTrials = 0;
    unsigned nextProbeTrialIndex = random(5, 10);

    for (size_t i = 1; i <= PROTO_NumTrialsInABlock; i++)
    {
        check_for_reset();
        reset_watchdog();
        trial_count_ = i;

        if(String("TONE/LIGHT") == String(PROTO_CSValue))
        {
            // FOR Shomu. Mixed trials.
            bool isprobe = false;
            if( i % 5 == 0 )
                isprobe = true;
            do_trial(i, isprobe );
        }
        else
        {
            bool isprobe = false;
            // Probe trial.
            if( i == nextProbeTrialIndex )
            {
                isprobe = true;
                numProbeTrials +=1 ;
                nextProbeTrialIndex = random( (numProbeTrials+1)*10-2, (numProbeTrials+1)*10+3);
            }
            do_trial(i, isprobe);
        }
    }

    // Don't do anything once all trails are over.
    while( true )
    {
        reset_watchdog( );
        Serial.println( ">>> Good job. All done. Go home and play!" );
        delay( 2000 );
    }
}
