// =====================================================================================
//
//       Filename:  callback.h
//
//    Description:  Callback functions.
//                  This header contains functions which are used in protocol.h
//                  file.
//
//         Author:  Dilawar Singh (), dilawar.s.rajput@gmail.com
//   Organization:  NCBS Bangalore
//
// =====================================================================================

#ifndef CALLBACK_H
#define CALLBACK_H

typedef struct CallbackData {
    size_t trialNum;
    size_t duration;
    bool isProbe = false;
} callback_data_t;

/* --------------------------------------------------------------------------*/
/**
 * @Synopsis  Callback at the start of PRE.
 *
 * @Param info
 * @Param data
 */
/* ----------------------------------------------------------------------------*/
void funcPREStart(const callback_data_t* info, void* data)
{
    // RUN at PRE START
    Serial.println("funcPREStart");

    // From Ananth. He suggested that 60ms delay is required for every protocol. This is
    // apprently shutter delay for the camera and only required for trial number
    // 1.
    if (info->trialNum > 0)
        delay(60); // Shutter delay.
    sprintf(trial_state_, "PRE_" );
    digitalWrite(IMAGING_TRIGGER_PIN, HIGH);   // Imaging START
    digitalWrite(CAMERA_TTL_PIN, LOW );        // Camera STOP.
    digitalWrite(LED_PIN, LOW );               // LED STOP.
}

/* --------------------------------------------------------------------------*/
/**
 * @Synopsis  Called at the end of PRE.
 *
 * @Param info
 * @Param data
 */
/* ----------------------------------------------------------------------------*/
void funcPREEnd(const callback_data_t* info, void* data) 
{ 
    // Nothing happens here.
    // Serial.println("funcPREEnd");
}


//-----------------------------------------------------------------------------
//  CS
//-----------------------------------------------------------------------------
void funcCSStart(const callback_data_t* info, void* data)
{
    if( String("NONE") == String(intervalCS.value) )
    {
        sprintf( trial_state_, "NOCS" );
        while((millis( ) - stamp_) <= duration)
            write_data_line( );
    }
    else
    {
        stamp_ = millis( );
        sprintf( trial_state_, "CS+" );
        if(String("LIGHT") == String(intervalCS.value))
        {
            led_on( duration );
        }
        else if(String("TONE") == String(intervalCS.value))
        {
            play_tone(duration);
        }
        else if(String("TONE/LIGHT") == String(intervalCS.value))
        {
            // Because real trial starts from trial #1.
            if((trialNum-1) % 10 < 5)
                play_tone(duration);
            else
                led_on(duration);
        }
        else
        {
            Serial.println( "<<<Error: Unknown CS" );
        }
    }
}

void funcCSEnd(const callback_data_t* info, void* data)
{
}


//-----------------------------------------------------------------------------
//  TRACE
//-----------------------------------------------------------------------------
void funcTRACEStart(const callback_data_t* info, void* data)
{
}

void funcTRACEEnd(const callback_data_t* info, void* data)
{ 
}

//-----------------------------------------------------------------------------
//  US
//-----------------------------------------------------------------------------
void funcUSStart(const callback_data_t* info, void* data)
{
}

void funcUSEnd(const callback_data_t* info, void* data)
{
}


//-----------------------------------------------------------------------------
//  POST
//-----------------------------------------------------------------------------
void funcPOSTStart(const callback_data_t* info, void* data)
{
}

void funcPOSTEnd(const callback_data_t* info, void* data)
{
}


#endif /* end of include guard: CALLBACK_H */
