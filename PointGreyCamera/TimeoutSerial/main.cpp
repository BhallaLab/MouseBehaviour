/* 
 * File:   main.cpp
 * Author: fede.tft
 *
 * Created on September 10, 2009, 10:50 AM
 */

#include <iostream>
#include <chrono>
#include <thread>
#include "TimeoutSerial.h"

using namespace std;
using namespace boost;

int main(int argc, char* argv[])
{

    TimeoutSerial serial("/dev/ttyUSB0",115200);
    // serial.setTimeout(posix_time::seconds(5));

    //Text test
    // serial.writeString("Hello world\r\n");
    while(true)
    {
        cout<<serial.readStringUntil("\n")<<endl;
        this_thread::sleep_for(chrono::milliseconds(1));
    }

    //Binary test
    unsigned char values[]={0xde,0xad,0xbe,0xef};
    serial.write(reinterpret_cast<char*>(values),sizeof(values));
    serial.read(reinterpret_cast<char*>(values),sizeof(values));
    for(unsigned int i=0;i<sizeof(values);i++)
    {
        cout<<static_cast<int>(values[i])<<endl;
    }

    serial.close();
  
}

