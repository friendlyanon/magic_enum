cmake_minimum_required(VERSION 3.14)

project(magic_enum_tests CXX)

include(../cmake/options.cmake)
include(FetchContent)
FetchContent_Declare(magic_enum SOURCE_DIR "${PROJECT_SOURCE_DIR}/..")
FetchContent_MakeAvailable(magic_enum)

enable_testing()

foreach(name IN ITEMS main main_flags)
  add_executable("${name}" "${name}.cpp")
  if(DEFINED options)
    target_compile_options("${name}" PRIVATE ${options})
  endif()
  target_link_libraries("${name}" PRIVATE magic_enum::magic_enum)
  target_compile_features("${name}" PRIVATE cxx_std_17)
  target_include_directories("${name}" SYSTEM PRIVATE
          "${PROJECT_SOURCE_DIR}/3rdparty/Catch2")
  set_property(TARGET "${name}" PROPERTY CXX_EXTENSIONS OFF)
  add_test(NAME "${name}" COMMAND "${name}")
endforeach()
