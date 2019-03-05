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
#include <boost/algorithm/string.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>

#include <tiffio.h>
#include <tiffio.hxx>

#define ARDUINO_SERIAL_PORT     "/dev/ttyACM0"
#define OPENCV_MAIN_WINDOW      "Frame"

// Libserial.
#include <SerialStream.h>
#include "config.h"
#include "helper.hh"
#include "videoio.h"

using namespace LibSerial;
using namespace cv;
using namespace Spinnaker;
using namespace Spinnaker::GenApi;
using namespace Spinnaker::GenICam;
using namespace std;


/*-----------------------------------------------------------------------------
 *  Globals.
 *-----------------------------------------------------------------------------*/
int total_frames_ = 0;
double fps_       = 0.0;                          /* Frame per second. */
SystemPtr system_;
CameraList cam_list_;
bool all_done_ = false;
string validCommands_ = "stlr";                   // Valid char commands.

// Storage for images.
vector<Mat> frames_;


// queue.
queue<string> arduinoQ_({"", "", "", "", "", "", "", "", "", ""});
SerialStream serial_;

void sig_handler( int s )
{
    cerr << "user pressed ctrl+c. Terminating everything.. " << endl;
    all_done_ = true;
}

string get_timestamp()
{
    using namespace boost::posix_time;
    ptime t = microsec_clock::universal_time();
    return to_iso_extended_string(t);
}

void SaveAllFrames(vector<Mat>& frames, const size_t trial)
{
    if(frames.size() < 1)
    {
        cout << "[WARN] No frames to save." << endl;
        return;
    }

    cout << "[INFO] Saving " << frames.size() << " frames to disk." << endl;
    cout << "\t Trial number " << trial << endl;
    write_frames_to_tiff("/tmp/out.tif", frames);

    cout << "\t All done." << endl;
}

/* --------------------------------------------------------------------------*/
/**
 * @Synopsis  Store house.
 *
 * @Param mat
 * @Param arduino
 */
/* ----------------------------------------------------------------------------*/
void AddToStoreHouse(Mat& mat, const string arduino)
{
    static int currentTrial = 0;

    vector<string> arduinoData;
    boost::split(arduinoData, arduino, boost::is_any_of(","));
    if(arduinoData.size() < 13)
        return;


    // Else we have valid data.
    size_t storeFrameIdx = 8;
    if( (int)std::stoi(arduinoData[storeFrameIdx]) == 1)
        frames_.push_back(mat);

    size_t trialNumIdx = 4;
    if( (int)std::stoi(arduinoData[trialNumIdx]) > currentTrial)
    {
        cout << "[INFO] New trial is strating: " << currentTrial+1<< endl;
        cout << "[INFO] Total frames to store: " << frames_.size() << endl;

        // Save everything.
        vector<Mat> data = frames_;
        auto t = boost::thread(SaveAllFrames, data, currentTrial);
        t.detach();

        frames_.clear();
        currentTrial = std::stoi(arduinoData[trialNumIdx]);
    }

}

void ReadLine(string& res)
{
    res.clear();
    char next_char = ' ';
    while(next_char != '\n')
    {
        serial_.get(next_char);
        if( next_char < 32 ) // less than SPACE.
            continue;
        res += next_char;
        if(all_done_)
            break;
    }
    // Append timestamp to the line.
    res = get_timestamp() + ',' + res;
}

/* --------------------------------------------------------------------------*/
/**
 * @Synopsis  Arduino client. It read the data from arduino and put them into a
 * queue which is consumed by Camera Client.
 */
/* ----------------------------------------------------------------------------*/
void ArduinoClient()
{
    // Connect to arduino client.
    bool connected = false;

    while(! connected)
    {
        cout << "[INFO] Trying to connect to arduino." << endl;
        try 
        {
            serial_.Open(string(ARDUINO_SERIAL_PORT));
            connected = true;
        } 
        catch(std::exception& e) 
        {
            cerr << "Failed to open serial port." << e.what() << endl;
            boost::this_thread::sleep_for(boost::chrono::milliseconds(500));
        }
    }

    // Config.
    serial_.SetCharSize(SerialStreamBuf::CHAR_SIZE_8);
    serial_.SetBaudRate(SerialStreamBuf::BAUD_115200);

    string line;
    while(! all_done_)
    {
        // Read line from serial.
        ReadLine(line);
        arduinoQ_.push(line);
        arduinoQ_.pop();
    }
}

// This function returns the camera to its default state by re-enabling automatic
// exposure.
int ResetExposure(INodeMap & nodeMap)
{
    try
    {
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

/* --------------------------------------------------------------------------*/
/**
 * @Synopsis  Process frame. Append data collected from arduino.
 *
 * @Param data
 * @Param width
 * @Param height
 *
 * @Returns   
 */
/* ----------------------------------------------------------------------------*/
int ProcessFrame(void* data, size_t width, size_t height)
{
    Mat img(height, width, CV_8UC1, data );

    // Write frame number on the frame.
    string aLine = arduinoQ_.back();
    if( '<' == aLine[0] )
        cout << aLine << endl;

    string arduinoData = get_timestamp() + ',' + aLine;

    // Draw a back rectangle on the top.
    rectangle(img, Point(10,2), Point(width, 16), 0, -1);
    putText(img, arduinoData, Point(10,10), FONT_HERSHEY_SIMPLEX, 0.3, 200);

    // Convert msg to array of uint8 and append to first frame.
    string toWrite = arduinoData;
    toWrite.resize(width, ' ');
    cv::Mat infoRow(1, width, CV_8UC1, (void*) toWrite.data());
    
    // Prepent to image.
    cv::vconcat(infoRow, img, img);

    // Show every 25th frame.
    if( total_frames_ % 25 == 0)
        imshow(OPENCV_MAIN_WINDOW,  img);

    // This frame and arduino data are stamped together.
    AddToStoreHouse(img, arduinoData);

    char k = waitKey(2);
    if( k < ' ')
        return 0;

    cout << "[INFO] Key pressed " << k << endl;
    if(validCommands_.find(k) != std::string::npos)
    {
        cout << "[INFO] Got valid command. Writing to serial." << k << endl;
        serial_ << k << endl;
    }
    return 0;
}

int AcquireImages(CameraPtr pCam, INodeMap& nodeMap, INodeMap& nodeMapTLDevice)
{
    int result = 0;
    try
    {
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
    }
    catch( runtime_error& e )
    {
        cout << "User pressed Ctrl+c" << endl;
        return -1;
    }
    catch (Spinnaker::Exception &e)
    {
        cout << "Error: " << e.what() << endl;
        return  -1;
    }

    auto startTime = boost::chrono::system_clock::now();
    while(! all_done_)
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

            ProcessFrame( pResultImage->GetData(), width, height);

            if( total_frames_ % 100 == 0)
            {
                boost::chrono::duration<double> elapsedSecs = 
                    boost::chrono::system_clock::now() - startTime;
                fps_ = (double) total_frames_ / elapsedSecs.count();
                cout << "[INFO] Running FPS : " << fps_ << endl;
            }
        }
    }

    pCam->EndAcquisition();
    return 0;
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

static void cvMouseCallback(int event, int x, int y, int, void*)
{

}

// This function acts as the body of the example; please see NodeMapInfo example
// for more in-depth comments on setting up cameras.
int InitSingleCamera(CameraPtr pCam, std::pair<INodeMap*, INodeMap*>& res)
{
    // Retrieve TL device nodemap and print device information
    INodeMap& nodeMapTLDevice = pCam->GetTLDeviceNodeMap();
    // PrintDeviceInfo(nodeMapTLDevice);

    // Initialize camera
    pCam->Init();

    // Retrieve GenICam nodemap
    INodeMap& nodeMap = pCam->GetNodeMap();

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

    res.first = &nodeMap;
    res.second = &nodeMapTLDevice;
    return 0;
}

void RunSingleCamera(CameraPtr pCam, INodeMap* pNodeMap, INodeMap* pNodeMapTLDevice)
{
    /*-----------------------------------------------------------------------------
     *  IMAGE ACQUISITION
     *  Infinite loop.
     *-----------------------------------------------------------------------------*/
    AcquireImages(pCam, *pNodeMap, *pNodeMapTLDevice);

    // Reset settings.
    ResetExposure( *pNodeMap );

    // Deinitialize camera
    pCam->DeInit();
}

void initOpenCV()
{
    namedWindow(OPENCV_MAIN_WINDOW);
    setMouseCallback(OPENCV_MAIN_WINDOW, cvMouseCallback);
}

// Example entry point; please see Enumeration example for more in-depth
// comments on preparing and cleaning up the system.
int main(int argc, char** argv)
{
    signal(SIGINT, sig_handler );

    // Intialize opencv windown and callback function.
    initOpenCV();

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
    cout << "[INFO] Arduino client has been launched." << endl;

    pair<INodeMap*, INodeMap*> res;
    InitSingleCamera(pCam, res);

    // This function loops forever.
    RunSingleCamera(pCam, res.first, res.second);

    pCam = 0;
    // Clear camera list before releasing system_
    cam_list_.Clear();

    // Release system_
    system_->ReleaseInstance();

    destroyAllWindows();
    if( t.joinable() )
        t.join();

    std::cout << "All done" << std::endl;
    return 0;
}
