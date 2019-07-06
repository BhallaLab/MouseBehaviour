cmake_minimum_required(VERSION 2.8)
project(EyeBlinkBehavour)

###############################################################################
# TIMESTAMP
string(TIMESTAMP COMPILE_TIME "%Y-%m-%d%H:%M:%S")

################################################################################
# ARDUINO BOARD 
################################################################################
if(NOT PORT)
    execute_process( 
        COMMAND bash ${CMAKE_SOURCE_DIR}/scripts/list_serial_ports.sh 
        OUTPUT_VARIABLE PORT 
        OUTPUT_STRIP_TRAILING_WHITESPACE
        )
endif(NOT PORT)

if (NOT PORT )
    message(STATUS
        "WARNING:"
        "\nCould not find a serial port automatically. You won't be able to upload"
        "\n and run the arduino target. If you are sure that arduino board is "
        "\n connected and functional, you should provide port path from "
        "\n command line: e.g. \n"
        "\t -DPORT=/dev/ttyACM0 etc."
        "\n\n Or you may not be part of 'dailout' group?"
        )
else (NOT PORT)
    message(STATUS "Default serial port ${PORT}" )
endif (NOT PORT)

set(CMAKE_CXX_STANDARD 11)

find_package(PythonInterp REQUIRED)

# Options related to Arduino board.
# Set the board tag
set(ARDUINO_PROJECT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# Extra paths to search for headers.
set(ARDUINO_EXTRA_CXXFLAGS "")

set(BOARD_TAG   uno)
# Baud rate of 115200 roughly translates to 115 char per 10ms. 
set(BAUD_RATE   115200)
find_program(ARDUINO_BIN arduino )

set(ARDUINO_BOARD_FILE hardware/arduino/boards.txt)
find_path( ARDUINO_DIR 
    NAMES boards.txt
    PATHS /usr/share/arduino/hardware
    PATH_SUFFIXES arduino arduino/avr
    )
message( STATUS "Arduino location ${ARDUINO_DIR}" )

if(NOT ARDUINO_DIR)
    message(FATAL_ERROR "Arduino board list not found")
endif( )
message(STATUS "List of arduino boards ${ARDUINO_DIR}")

################################################################################
# Animal related options.
################################################################################
if((NOT ANIMAL_NAME) OR (NOT SESSION_NUM) OR (NOT PROTO_CODE))
    message(FATAL_ERROR 
        "Set ANIMAL_NAME, SESSION_NUM, and PROTO_CODE to cmake; e.g. \n"
        "\tcmake -DANIMAL_NAME=k3 -DSESSION_NUM=1 -DPROTO_CODE=All1 ..\n"
        "For info on protocols, see file 'Protocols/BehaviourProtocols.csv'"
        " in the top directory."
        )
endif()

# For given PROTO_CODE generate config file. find_package(PythonInterp REQUIRED)
message(STATUS "User asked for protocol code: ${PROTO_CODE}")
execute_process(COMMAND 
    ${PYTHON_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/Protocols/protocol_to_config.py ${PROTO_CODE}
    OUTPUT_VARIABLE PROTOCOL_CONFIG
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/Protocols
    OUTPUT_STRIP_TRAILING_WHITESPACE
    )
message(STATUS "Writing protocol ${PROTO_CODE} config to file.")
file(WRITE ${CMAKE_CURRENT_SOURCE_DIR}/Arduino/protocol.h "${PROTOCOL_CONFIG}")

# Set DATA DIRirectory to store data for given animal, session, and protocol
# code. 
set(DATADIR
    "$ENV{HOME}/DATA/${ANIMAL_NAME}/${ANIMAL_NAME}_${PROTO_CODE}_${SESSION_NUM}")

if(EXISTS ${DATADIR})
    set(DATADIR
        "$ENV{HOME}/DATA/${ANIMAL_NAME}/${ANIMAL_NAME}_${PROTO_CODE}_${SESSION_NUM}/${COMPILE_TIME}")
endif()
message(STATUS "Data will be stored in ${DATADIR}")
file(MAKE_DIRECTORY ${DATADIR})
configure_file( ${CMAKE_SOURCE_DIR}/Makefile.arduino.in
    ${CMAKE_SOURCE_DIR}/Makefile.arduino
    )

set(ARDUINO_TARGET_NAME protocol_${PROTO_CODE})
set(ARDUINO_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Arduino)

# Now add the client and server 
set(CAMERA_SERVER_DIR ${CMAKE_CURRENT_SOURCE_DIR}/PointGreyCamera)
add_subdirectory(${CAMERA_SERVER_DIR})

# Write variables to config.h file.
configure_file(${ARDUINO_SRC_DIR}/config.h.in ${ARDUINO_SRC_DIR}/config.h)
set(ARDDUINO_OUT_HEX_FILE 
    ${CMAKE_SOURCE_DIR}/${BOARD_NAME}/${ARDUINO_TARGET_NAME}/${ARDUINO_TARGET_NAME}.hex 
    )

add_custom_target( build_arduino_hex ALL 
    DEPENDS ${ARDDUINO_OUT_HEX_FILE}
    VERBATIM 
    )

add_custom_command(OUTPUT ${ARDDUINO_OUT_HEX_FILE}
    COMMAND $(MAKE) -f ${CMAKE_SOURCE_DIR}/Makefile.arduino
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    VERBATIM
    )

add_custom_target(upload 
    DEPENDS build_arduino_hex 
    COMMAND make -f ${CMAKE_CURRENT_SOURCE_DIR}/Makefile.arduino upload 
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )

# make miniterm will launch the miniterm.py .
add_custom_target(miniterm
    DEPENDS upload 
    COMMAND ${PYTHON_EXECUTABLE} -m serial.tools.miniterm ${PORT} ${BAUD_RATE}
    VERBATIM 
    )

# Reset all attached boards.
add_custom_target(reset_boards
    COMMAND bash scripts/reset_all_boards.sh
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    VERBATIM
    )


# pass these arguments to camera server.
SET(RUN_ARGS --port ${PORT} --datadir ${DATADIR})
add_custom_target(run  
    DEPENDS cam_server upload
    COMMAND LD_LIBRARY_PATH=${CAMERA_SERVER_DIR}/external/lib 
        ${CMAKE_BINARY_DIR}/cam_server ${RUN_ARGS}
    COMMENT "Run arduino client and camera client"
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    VERBATIM
    )

