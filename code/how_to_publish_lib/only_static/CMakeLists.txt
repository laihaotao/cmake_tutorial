cmake_minimum_required(VERSION 3.4)
project(how_to_publish_lib)
add_subdirectory(src/)
add_executable(use_lib_demo main.cpp)
target_link_libraries(use_lib_demo JashAdd)