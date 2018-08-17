cmake_minimum_required(VERSION 3.4)
project(how_to_work_with_lib)
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/modules")

# invoke the FindOpenNI2 module
find_package(OpenNI2)

# visualize the result
if (OPENNI2_FOUND)
    message("OPENNI2 FOUND")
else(OPENNI2_FOUND)
    message("OPENNI2 NOT FOUND")
endif(OPENNI2_FOUND)