# Minimum CMake version required
cmake_minimum_required(VERSION 3.16)

# Project name and version
project(terra_quantum_sdk VERSION 0.1 LANGUAGES CXX)

# Set C++ standard to C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Include directories
include_directories(${PROJECT_SOURCE_DIR}/include)

# Add source files
set(SOURCES
    src/terra_quantum_sdk.cpp
)

# Create a library target
add_library(terra_quantum_sdk ${SOURCES})

# Set target properties
set_target_properties(terra_quantum_sdk PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
)

# Installation rules
install(TARGETS terra_quantum_sdk
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})