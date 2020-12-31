if(MSVC)
  set(options /W4 /WX /permissive-)
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
  set(options -Wall -Wextra -pedantic-errors -Werror)
else()
  message(STATUS "Unknown compiler: ${CMAKE_CXX_COMPILER_ID}")
endif()