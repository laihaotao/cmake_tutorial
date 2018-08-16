cmake_minimum_required(VERSION 3.4)
project(a_simple_example)

aux_source_directory(. SRC_FILES)
add_executable(a_simple_example ${SRC_FILES})
