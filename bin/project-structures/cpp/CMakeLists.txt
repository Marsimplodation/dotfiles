
cmake_minimum_required(VERSION 3.7)

# Project name
project(MyProject)

# Set C++ standard (if it's a C++ project)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# Add executable
add_executable(${PROJECT_NAME} src/main.cpp)
