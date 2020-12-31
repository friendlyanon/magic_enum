cmake_minimum_required(VERSION 3.14)

project(magic_enum
        VERSION 0.7.2
        DESCRIPTION "Static reflection for enums for modern C++"
        HOMEPAGE_URL "https://github.com/Neargye/magic_enum"
        LANGUAGES CXX)

# ---- Warning guard ----

# Protect dependents from this project's warnings if the guard isn't disabled
set(magic_enum_warning_guard SYSTEM)
if(magic_enum_INCLUDE_WITHOUT_SYSTEM)
  set(magic_enum_warning_guard "")
endif()

# ---- Declare library ----

add_library(magic_enum INTERFACE)
add_library(magic_enum::magic_enum ALIAS magic_enum)

target_include_directories(magic_enum
        ${magic_enum_warning_guard}
        INTERFACE
        "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>")

target_compile_features(magic_enum INTERFACE cxx_std_17)

# ---- Install ----

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

set(magic_enum_directory "magic_enum-${PROJECT_VERSION}")
set(magic_enum_include_directory
        "${CMAKE_INSTALL_INCLUDEDIR}/${magic_enum_directory}")

install(DIRECTORY "${PROJECT_SOURCE_DIR}/include/"
        DESTINATION "${magic_enum_include_directory}"
        COMPONENT magic_enum_Development)

install(TARGETS magic_enum
        EXPORT magic_enumTargets
        INCLUDES DESTINATION "${magic_enum_include_directory}")

write_basic_package_version_file(
        magic_enum-config-version.cmake
        COMPATIBILITY AnyNewerVersion
        ARCH_INDEPENDENT)

set(magic_enum_install_cmakedir
        "${CMAKE_INSTALL_LIBDIR}/cmake/${magic_enum_directory}")

install(FILES "${PROJECT_BINARY_DIR}/magic_enum-config-version.cmake"
        DESTINATION "${magic_enum_install_cmakedir}"
        COMPONENT magic_enum_Development)

install(EXPORT magic_enumTargets
        FILE magic_enum-config.cmake
        NAMESPACE magic_enum::
        DESTINATION "${magic_enum_install_cmakedir}"
        COMPONENT magic_enum_Development)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  include(CPack)
endif()
