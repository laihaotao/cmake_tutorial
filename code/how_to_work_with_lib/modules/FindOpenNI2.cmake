# FindOpenNI2.cmake

# This file is used to find OpenNi2 in your local machine
# Usage: find_package(OpenNI2)
# 
# Variables defined by this module:
#
# OPENNI2_FOUND               True if OpenNI2 was found
# OPENNI2_INCLUDE_DIRS        The location(s) of OpenNI2 headers
# OPENNI2_LIBRARIES           Libraries needed to use OpenNI2

find_path(OPENNI2_INCLUDE_DIR OpenNI.h
          PATHS "$ENV{OPENNI2_INCLUDE${OPENNI2_SUFFIX}}"
                "/usr/include/openni2" "/usr/include/ni2" "/usr/local/include/ni2"
          PATH_SUFFIXES include/openni2
        )

find_library(OPENNI2_LIBRARY
             NAMES OpenNI2      # No suffix needed on Win64
                   libOpenNI2   # Linux
             PATHS "$ENV{OPENNI2_LIB${OPENNI2_SUFFIX}}" "$ENV{OPENNI2_REDIST}"
                   "/usr/lib/ni2" "/usr/local/lib/ni2"
            )

if(OPENNI2_INCLUDE_DIR AND OPENNI2_LIBRARY)
  
  set(OPENNI2_FOUND true)
  
  # Include directories
  set(OPENNI2_INCLUDE_DIRS ${OPENNI2_INCLUDE_DIR})
  include_directories(${OPENNI2_INCLUDE_DIRS})

  # Libraries
  if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(OPENNI2_LIBRARIES ${OPENNI2_LIBRARY} ${LIBUSB_1_LIBRARIES})
  else()
    set(OPENNI2_LIBRARIES ${OPENNI2_LIBRARY})
  endif()

  set(OPENNI2_REDIST_DIR $ENV{OPENNI2_REDIST${OPENNI2_SUFFIX}})
endif(OPENNI2_INCLUDE_DIR AND OPENNI2_LIBRARY)