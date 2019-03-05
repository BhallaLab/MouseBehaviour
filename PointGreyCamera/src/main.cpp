#include "Spinnaker.h"
#include "SpinGenApi/SpinnakerGenApi.h"
#include <iostream>
#include <csignal>
#include <queue>
#include <exception>
#include <opencv2/highgui/highgui.hpp>
#include <boost/thread/thread.hpp>
#include <boost/chrono.hpp>
#include <boost/asio.hpp>

#define ARDUINO_SERIAL_PORT "/dev/ttyACM0"
#define ARDUINO_SERIAL_BAUD_RATE 96400

// Libserial.
#include <SerialStream.h>

#include "config.h"

using namespace cv;

using namespace Spinnaker;
using namespace Spinnaker::GenApi;
using namespace Spinnaker::GenICam;
using namespace std;

int total_frames_ = 0;
float fps_ = 0.0;                               /* Frame per second. */

SystemPtr system_;
CameraList cam_list_;

// Global queue.
queue<string> arduinoQ_({"", "", "", "", "", "", "", "", "", ""});

void sig_handler( int s )
{
    throw runtime_error( "Ctrl+C pressed" );
}

void ArduinoClient()
{
    // Connect to arduino client.
    bool connected = false;

    LibSerial::SerialStream arduinoStream(string(ARDUINO_SERIAL_PORT));
    arduinoStream.SetBaudRate(ARDUINO_SERIAL_BAUD_RATE);

    while(! connected)
    {
        cout << "Trying to connect to arduino." << endl;
    }

    while(true)
    {
        arduinoQ_.push("Nothing");
        arduinoQ_.pop();
        boost::this_thread::sleep_for(boost::chrono::milliseconds(100));
    }
}

// This function returns the camera to its default state by re-enabling automatic
// exposure.
int ResetExposure(INodeMap & nodeMap)
{
    try
    {
        //
        // Turn automatic exposure back on
        //
        // *** NOTES ***
        // Automatic exposure is turned on in order to return the camera to its
        // default state.
        //
        CEnumerationPtr ptrExposureAuto = nodeMap.GetNode("ExposureAuto");
        if (!IsAvailable(ptrExposureAuto) || !IsWritable(ptrExposureAuto))
        {
            cout << "Unable to enable automatic exposure (node retrieval). Non-fatal error..." << endl << endl;
            return -1;
        }

        CEnumEntryPtr ptrExposureAutoContinuous = ptrExposureAuto->GetEntryByName("Continuous");
        if (!IsAvailable(ptrExposureAutoContinuous) || !IsReadable(ptrExposureAutoContinuous))
        {
            cout << "Unable to enable automatic exposure (enum entry retrieval). Non-fatal error..." << endl << endl;
            return -1;
        }
        ptrExposureAuto->SetIntValue(ptrExposureAutoContinuous->GetValue());
        cout << "Automatic exposure enabled..." << endl << endl;
    }
    catch (Spinnaker::Exception &e)
    {
        cout << "Error: " << e.what() << endl;
    }
    return 0;
}

/**
 * @brief Show data.
 *
 * @param data
 * @param size
 *
 * @return
 */
int ProcessFrame(void* data, size_t width, size_t height)
{
    Mat img(height, width, CV_8UC1, data );
    // data = img.data;

    // Write frame number on the frame.
    string msg("Frame:" +std::to_string(total_frames_));
    msg += "|" + string(arduinoQ_.back());
    putText(img, msg, Point(10,10), FONT_HERSHEY_SIMPLEX, 0.3, 255);

#if 1
    if( total_frames_ % 10 == 0)
    {
        imshow("Camera",  img );
        waitKey(1);
    }
#endif
    return 0;
}

int AcquireImages(CameraPtr pCam, INodeMap& nodeMap, INodeMap& nodeMapTLDevice)
{
    int result = 0;
    try
    {
        auto startTime = boost::chrono::system_clock::now();

        CEnumerationPtr ptrAcquisitionMode = nodeMap.GetNode("AcquisitionMode");
        if (!IsAvailable(ptrAcquisitionMode) || !IsWritable(ptrAcquisitionMode))
        {
            cout << "Unable to set acquisition mode to continuous "
                 << " (enum retrieval). Aborting..." << endl << endl;
            return -1;
        }

        // Retrieve entry node from enumeration node
        CEnumEntryPtr ptrAcquisitionModeContinuous = ptrAcquisitionMode->GetEntryByName("Continuous");
        if (!IsAvailable(ptrAcquisitionModeContinuous) || !IsReadable(ptrAcquisitionModeContinuous))
        {
            cout << "Unable to set acquisition mode to continuous " <<
                 " (entry retrieval). Aborting..." << endl << endl;
            return -1;
        }

        // Retrieve integer value from entry node
        int64_t acquisitionModeContinuous = ptrAcquisitionModeContinuous->GetValue();

        // Set integer value from entry node as new value of enumeration node
        ptrAcquisitionMode->SetIntValue(acquisitionModeContinuous);
        cout << "Acquisition mode set to continuous..." << endl;

        // Change the acquition frame rate.
        pCam->BeginAcquisition();

        gcstring deviceSerialNumber("");
        CStringPtr ptrStringSerial = nodeMapTLDevice.GetNode("DeviceSerialNumber");
        if (IsAvailable(ptrStringSerial) && IsReadable(ptrStringSerial))
        {
            deviceSerialNumber = ptrStringSerial->GetValue();
            cout << "Device serial number retrieved " << deviceSerialNumber
                 << endl;
        }


        char notification[100] = "running ..";
        while( true )
        {
            try
            {
                ImagePtr pResultImage = pCam->GetNextImage();
                //cout << "Pixal format: " << pResultImage->GetPixelFormatName( ) << endl;

                if ( pResultImage->IsIncomplete() ) /* Image is incomplete. */
                {
                    cout << "[WARN] Image incomplete with image status " <<
                         pResultImage->GetImageStatus() << " ..." << endl;
                }
                else
                {
                    size_t width = pResultImage->GetWidth();
                    size_t height = pResultImage->GetHeight();
                    size_t size = pResultImage->GetBufferSize( );
                    total_frames_ += 1;
                    //cout << "H: "<< height << " W: " << width << " S: " << size << endl;
                    // Convert the image to Monochorme, 8 bits (1 byte) and send
                    // the output.
                    //auto img = pResultImage->Convert( PixelFormat_Mono8 );
                    ProcessFrame( pResultImage->GetData(), width, height);
                    if( total_frames_ % 100 == 0 )
                    {
                        boost::chrono::duration<double> elapsedSecs = 
                            boost::chrono::system_clock::now() - startTime;
                        fps_ = (double) total_frames_ / elapsedSecs.count();
                        cout << "Running FPS : " << fps_ << endl;
                    }
                }
            }
            catch( runtime_error& e )
            {
                cout << "User pressed Ctrl+c" << endl;
                break;
            }
            catch (Spinnaker::Exception &e)
            {
                cout << "Error: " << e.what() << endl;
                result = -1;
            }
        }
        pCam->EndAcquisition();
    }
    catch (Spinnaker::Exception &e)
    {
        cout << "Error: " << e.what() << endl;
        result = -1;
    }

    return result;
}

// This function prints the device information of the camera from the transport
// layer; please see NodeMapInfo example for more in-depth comments on printing
// device information from the nodemap.
int PrintDeviceInfo(INodeMap & nodeMap)
{
    int result = 0;

    cout << endl << "*** DEVICE INFORMATION ***" << endl << endl;

    try
    {
        FeatureList_t features;
        CCategoryPtr category = nodeMap.GetNode("DeviceInformation");
        if (IsAvailable(category) && IsReadable(category))
        {
            category->GetFeatures(features);

            FeatureList_t::const_iterator it;
            for (it = features.begin(); it != features.end(); ++it)
            {
                CNodePtr pfeatureNode = *it;
                cout << pfeatureNode->GetName() << " : ";
                CValuePtr pValue = (CValuePtr)pfeatureNode;
                cout << (IsReadable(pValue) ? pValue->ToString() : "Node not readable");
                cout << endl;
            }

        }
        else
        {
            cout << "Device control information not available." << endl;
        }
    }
    catch (Spinnaker::Exception &e)
    {
        cout << "Error: " << e.what() << endl;
        result = -1;
    }

    return result;
}

// This function acts as the body of the example; please see NodeMapInfo example
// for more in-depth comments on setting up cameras.
int RunSingleCamera(CameraPtr pCam)
{
    int result = 0;
    try
    {
        // Retrieve TL device nodemap and print device information
        INodeMap & nodeMapTLDevice = pCam->GetTLDeviceNodeMap();

        result = PrintDeviceInfo(nodeMapTLDevice);

        // Initialize camera
        pCam->Init();

        // Retrieve GenICam nodemap
        INodeMap & nodeMap = pCam->GetNodeMap();

        // Set width, height
        CIntegerPtr width = nodeMap.GetNode("Width");
        width->SetValue( FRAME_WIDTH );

        CIntegerPtr height = nodeMap.GetNode("Height");
        height->SetValue( FRAME_HEIGHT );

        // Set frame rate manually.
        CBooleanPtr pAcquisitionManualFrameRate = nodeMap.GetNode( "AcquisitionFrameRateEnable" );
        pAcquisitionManualFrameRate->SetValue( true );

        CFloatPtr ptrAcquisitionFrameRate = nodeMap.GetNode("AcquisitionFrameRate");

        try
        {
            cout << "Trying to set frame rate to " << EXPECTED_FPS << endl;
            ptrAcquisitionFrameRate->SetValue( EXPECTED_FPS );
        }
        catch ( std::exception & e )
        {
            cout << "Failed to set frame rate. Using default ... " << endl;
            cout << "\tError was " << e.what( ) << endl;
        }

        if (!IsAvailable(ptrAcquisitionFrameRate) || !IsReadable(ptrAcquisitionFrameRate))
            cout << "Unable to retrieve frame rate. " << endl << endl;
        else
        {
            fps_ = static_cast<float>(ptrAcquisitionFrameRate->GetValue());
            cout << "[INFO] Expected frame set to " << fps_ << endl;
        }

        // Switch off auto-exposure and set it manually.
        CEnumerationPtr ptrExposureAuto = nodeMap.GetNode("ExposureAuto");
        if (!IsAvailable(ptrExposureAuto) || !IsWritable(ptrExposureAuto))
        {
            cout << "Unable to disable automatic exposure (node retrieval). Aborting..." << endl << endl;
            return -1;
        }

        CEnumEntryPtr ptrExposureAutoOff = ptrExposureAuto->GetEntryByName("Off");
        if (!IsAvailable(ptrExposureAutoOff) || !IsReadable(ptrExposureAutoOff))
        {
            cout << "Unable to disable automatic exposure (enum entry retrieval). Aborting..." << endl << endl;
            return -1;
        }

        ptrExposureAuto->SetIntValue(ptrExposureAutoOff->GetValue());
        cout << "Automatic exposure disabled..." << endl;
        CFloatPtr ptrExposureTime = nodeMap.GetNode("ExposureTime");
        if (!IsAvailable(ptrExposureTime) || !IsWritable(ptrExposureTime))
        {
            cout << "Unable to set exposure time. Aborting..." << endl << endl;
            return -1;
        }

        // Ensure desired exposure time does not exceed the maximum
        const double exposureTimeMax = ptrExposureTime->GetMax();

        ptrExposureTime->SetValue( EXPOSURE_TIME_IN_US );
        cout << "Exposure time set to " << ptrExposureTime->GetValue( ) << " us..." << endl << endl;

#if 1
        // Turn of automatic gain
        CEnumerationPtr ptrGainAuto = nodeMap.GetNode("GainAuto");
        if (!IsAvailable(ptrGainAuto) || !IsWritable(ptrGainAuto))
        {
            cout << "Unable to disable automatic gain (node retrieval). Aborting..." << endl << endl;
            return -1;
        }
        CEnumEntryPtr ptrGainAutoOff = ptrGainAuto->GetEntryByName("Off");
        if (!IsAvailable(ptrGainAutoOff) || !IsReadable(ptrGainAutoOff))
        {
            cout << "Unable to disable automatic gain (enum entry retrieval). Aborting..." << endl << endl;
            return -1;
        }

        // Set gain; gain recorded in decibels
        CFloatPtr ptrGain = nodeMap.GetNode("Gain");
        if (!IsAvailable(ptrGain) || !IsWritable(ptrGain))
        {
            cout << "[WARN] Unable to set gain (node retrieval). Using default ..." << endl;
        }
        else
        {
            double gainMax = ptrGain->GetMax();
            double gainToSet = ptrGain->GetMin( );
            ptrGain->SetValue(gainToSet);
        }

#endif

        /*-----------------------------------------------------------------------------
         *  IMAGE ACQUISITION
         *  Infinite loop.
         *-----------------------------------------------------------------------------*/
        result = AcquireImages(pCam, nodeMap, nodeMapTLDevice);

        // Reset settings.
        ResetExposure( nodeMap );

        // Deinitialize camera
        pCam->DeInit();
    }
    catch (Spinnaker::Exception &e)
    {
        cout << "Error: " << e.what() << endl;
        result = -1;
    }

    return result;
}

// Example entry point; please see Enumeration example for more in-depth
// comments on preparing and cleaning up the system.
int main(int /*argc*/, char** /*argv*/)
{
    signal(SIGINT, sig_handler );

    // Print application build information
    cout << "Application build date: " << __DATE__ << " " << __TIME__ << endl << endl;

    // Retrieve singleton reference to system object
    system_ = System::GetInstance();
    if( system_->IsInUse( ) )
    {
        cout << "Warn: Camera is already in use. Reattach and continue";
        exit( -1 );
    }

    // Retrieve list of cameras from the system
    cam_list_ = system_->GetCameras();

    unsigned int numCameras = cam_list_.GetSize();

    cout << "Number of cameras detected: " << numCameras << endl << endl;

    // Finish if there are no cameras
    if (numCameras == 0)
    {
        // Clear camera list before releasing system_
        cam_list_.Clear();

        // Release system_
        system_->ReleaseInstance();
        cout << "Not enough cameras! Existing ..." << endl;
        return -1;
    }

    CameraPtr pCam = cam_list_.GetByIndex( 0 );

    auto t = boost::thread(ArduinoClient);
    cout << "info: Arduino client has been launched." << endl;

    // This function loops forever.
    RunSingleCamera(pCam);

    pCam = 0;
    // Clear camera list before releasing system_
    cam_list_.Clear();

    // Release system_
    system_->ReleaseInstance();

    if( t.joinable() )
        t.join();

    std::cout << "All done" << std::endl;
    return 0;
}
