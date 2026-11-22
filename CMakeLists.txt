cmake_minimum_required(VERSION 3.16)

# Fester Compiler: gcc. (Der parallele Makefile-Build kompiliert mit gcc.)
# Achtung: greift nur beim ersten Konfigurieren - ein bereits mit gcc
# konfiguriertes build/ muss vorher geloescht werden.
set(CMAKE_C_COMPILER clang-22)

project(template C)

# Standard-Build-Typ, falls beim Konfigurieren keiner angegeben wurde.
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

# Optimierung/Debug-Infos je Build-Typ (statt fest verdrahtetem -O2).
#   Debug   -> -O0 -g3   (volles Debugging)
#   Release -> -O2 -DNDEBUG
set(CMAKE_C_FLAGS_DEBUG "-O0 -g3")
set(CMAKE_C_FLAGS_RELEASE "-O2 -DNDEBUG")

# Sprachversion C23 (-std=c23).
set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

# Beim Konfigurieren compile_commands.json fuer clangd erzeugen.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Zentraler Target-Name.
set(APP_TARGET snake)

add_executable(${APP_TARGET}
    lib3d/glcore.c
    lib3d/lib3d_util.c
    lib3d/lib3d.c
    app/grid.c
    app/snake.c
    app/main.c
)

target_include_directories(${APP_TARGET} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/lib3d
)

target_compile_options(${APP_TARGET} PRIVATE -Wall -Wextra)

find_package(glfw3 REQUIRED)
find_package(OpenGL REQUIRED)

target_link_libraries(${APP_TARGET} PRIVATE glfw OpenGL::GL m)
