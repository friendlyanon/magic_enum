cmake_minimum_required(VERSION 3.14)

project(magic_enum_examples CXX)

include(../cmake/options.cmake)
include(FetchContent)
FetchContent_Declare(magic_enum SOURCE_DIR "${PROJECT_SOURCE_DIR}/..")
FetchContent_MakeAvailable(magic_enum)

foreach(name IN ITEMS example enum_flag_example example_custom_name)
  add_executable("${name}" "${name}.cpp")
  if(DEFINED options)
    target_compile_options("${name}" PRIVATE ${options})
  endif()
  target_link_libraries("${name}" PRIVATE magic_enum::magic_enum)
  target_compile_features("${name}" PRIVATE cxx_std_17)
  set_property(TARGET "${name}" PROPERTY CXX_EXTENSIONS OFF)
endforeach()
