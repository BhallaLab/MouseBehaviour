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

void funcPREStart(const callback_data_t* info, void* data)
{
}

void funcPREEnd(const callback_data_t* info, void* data) 
{ 
}

void funcUSStart(const callback_data_t* info, void* data)
{
}

void funcUSEnd(const callback_data_t* info, void* data)
{
}

void funcTRACEStart(const callback_data_t* info, void* data)
{
}

void funcTRACEEnd(const callback_data_t* info, void* data)
{ 
}

void funcCSStart(const callback_data_t* info, void* data)
{
}

void funcCSEnd(const callback_data_t* info, void* data)
{
}

void funcPOSTStart(const callback_data_t* info, void* data)
{
}

void funcPOSTEnd(const callback_data_t* info, void* data)
{
}


#endif /* end of include guard: CALLBACK_H */
