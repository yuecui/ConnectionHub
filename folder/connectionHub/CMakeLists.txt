cmake_minimum_required(VERSION 3.3)
project(mosquitto)

set(CMAKE_CXX_STANDARD 11)

set(SOURCE_FILES test.cpp Communicator.cpp)
#find_package(modquittopp REQUIRED)
link_directories(${PROJECT_SOURCE_DIR}/src/mosquitto-1.4.12/lib/cpp /usr/local/lib)
include_directories(${PROJECT_SOURCE_DIR}/src/mosquitto-1.4.12/lib/cpp  /usr/local/include)
add_executable(connectionHub ${SOURCE_FILES} )
target_link_libraries(connectionHub mosquittopp)
