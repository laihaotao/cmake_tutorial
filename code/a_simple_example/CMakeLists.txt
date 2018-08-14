project(a_simple_example)
cmake_minimum_required(VERSION 3.4)

aux_source_directory(. SRC_FILES)
add_executable(a_simple_example ${SRC_FILES})
