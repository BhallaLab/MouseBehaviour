/*
 * =====================================================================================
 *
 *       Filename:  config.h.in
 *
 *    Description:  Configuration variables in one place. This file  is also
 *    parsed by python script to its essential and this is not removed or
 *    changed without consulting the python script first.
 *
 *        Version:  1.0
 *        Created:  Tuesday 06 December 2016 02:03:48  IST
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Dilawar Singh (), dilawars@ncbs.res.in
 *   Organization:  NCBS Bangalore
 *
 * =====================================================================================
 */

#ifndef  config_INC
#define  config_INC

#define SOCK_PATH  

/* Block to write. */
#define BLOCK_SIZE  4096 

#define FRAME_HEIGHT            512
#define FRAME_WIDTH             640
#define EXPOSURE_TIME_IN_US     2000
#define EXPECTED_FPS            200

#endif   /* ----- #ifndef config_INC  ----- */
