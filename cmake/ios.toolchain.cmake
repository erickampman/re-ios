# iOS toolchain file for building re-ios via CMake + Xcode

# set(CMAKE_SYSTEM_NAME iOS)
# set(CMAKE_SYSTEM_PROCESSOR arm64)
# set(CMAKE_HOST_SYSTEM_NAME Darwin)  # Optional, for host tools
# 
# set(CMAKE_OSX_SYSROOT iphoneos)
# set(CMAKE_OSX_ARCHITECTURES arm64)
# set(CMAKE_OSX_DEPLOYMENT_TARGET "12.0" CACHE STRING "Minimum iOS version")
# set(CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE "NO")

# Set system info
set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_HOST_SYSTEM_NAME Darwin)  # Optional, for host tools
set(CMAKE_OSX_DEPLOYMENT_TARGET "12.0" CACHE STRING "Minimum iOS version")
set(CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE "NO")

# Determine platform and apply settings
if(CMAKE_OSX_SYSROOT STREQUAL "iphoneos")
  message(STATUS "✅ Configuring for iOS Device (iphoneos)")
  set(CMAKE_SYSTEM_PROCESSOR arm64)
  set(CMAKE_OSX_SYSROOT iphoneos)
  set(CMAKE_OSX_ARCHITECTURES arm64 CACHE STRING "Device arch" FORCE)

elseif(CMAKE_OSX_SYSROOT STREQUAL "iphonesimulator")
  message(STATUS "✅ Configuring for iOS Simulator (iphonesimulator)")
  set(CMAKE_SYSTEM_PROCESSOR x86_64)  # Most conservative default
  set(CMAKE_OSX_SYSROOT iphonesimulator)
  set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64" CACHE STRING "Fat sim archs" FORCE)

else()
  message(WARNING "⚠️ Unknown platform for CMAKE_OSX_SYSROOT: ${CMAKE_OSX_SYSROOT}")
endif()

# Toolchain-relative OpenSSL
# get_filename_component(TOOLCHAIN_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(RE_IOS_PARENT_DIR "${CMAKE_SOURCE_DIR}" DIRECTORY)
set(OPENSSL_ROOT_DIR "${RE_IOS_PARENT_DIR}/openssl" CACHE PATH "OpenSSL root")

# set(OPENSSL_ROOT_DIR "${TOOLCHAIN_DIR}/../openssl" CACHE PATH "OpenSSL root")
set(OPENSSL_INCLUDE_DIR "${OPENSSL_ROOT_DIR}/include" CACHE PATH "OpenSSL includes")
set(OPENSSL_CRYPTO_LIBRARY "${OPENSSL_ROOT_DIR}/libcrypto.a" CACHE FILEPATH "libcrypto")
set(OPENSSL_SSL_LIBRARY "${OPENSSL_ROOT_DIR}/libssl.a" CACHE FILEPATH "libssl")

# These paths help CMake find OpenSSL
set(CMAKE_INCLUDE_PATH "${OPENSSL_INCLUDE_DIR}")
set(CMAKE_LIBRARY_PATH "${OPENSSL_ROOT_DIR}")
set(CMAKE_PREFIX_PATH "${OPENSSL_ROOT_DIR}")
set(CMAKE_FIND_ROOT_PATH "${CMAKE_OSX_SYSROOT};${OPENSSL_ROOT_DIR}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Dependency compile-time feature toggles
set(USE_ZLIB OFF CACHE BOOL "" FORCE)
set(USE_BACKTRACE OFF CACHE BOOL "" FORCE)
set(USE_STUN OFF CACHE BOOL "" FORCE)
set(USE_TURN OFF CACHE BOOL "" FORCE)
set(USE_ICE OFF CACHE BOOL "" FORCE)
set(USE_TRICE OFF CACHE BOOL "" FORCE)
set(USE_UDP_SIP OFF CACHE BOOL "" FORCE)

