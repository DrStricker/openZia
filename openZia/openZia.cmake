cmake_minimum_required(VERSION 3.0)
project(openZia)

# This modules builds the API library
# It can be imported to easily add the API to an existing CMake project

# Requires C++ 17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED 17 ON)

# Retreive where is located 'openZia.cmake'
get_filename_component(OpenZiaSourcesDir ${CMAKE_CURRENT_LIST_FILE} PATH)

# Define external variables in order to link with ease
set(OpenZiaLibs openZia)
set(OpenZiaIncludes ${OpenZiaSourcesDir}/..)

# Library sources
set(OpenZiaSources
    ${OpenZiaSourcesDir}/BaseHTTP.hpp
    ${OpenZiaSourcesDir}/HTTP.hpp
    ${OpenZiaSourcesDir}/HTTP.cpp
    
    ${OpenZiaSourcesDir}/Context.hpp
    ${OpenZiaSourcesDir}/Context.cpp

    ${OpenZiaSourcesDir}/IModule.hpp
    ${OpenZiaSourcesDir}/ILogger.hpp
    
    ${OpenZiaSourcesDir}/APipeline.hpp
    ${OpenZiaSourcesDir}/APipeline.cpp
    ${OpenZiaSourcesDir}/APipeline.ipp
)

# Create openZia library
add_library(${PROJECT_NAME} ${OpenZiaSources})