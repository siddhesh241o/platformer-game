# OBJS specifies which object files to create as part of the project

SRCS = main.cpp src/core/Engine.cpp # Use forward slashes for paths even on Windows for Makefiles

OBJS = main.o Engine.o # List the object files that will be created

# CC specifies which compiler we're using
CC = g++

# INCLUDE_PATHS specifies the additional include paths we'll need
INCLUDE_PATHS = -IC:\mingw_dev_lib\include\SDL2

# LIBRARY_PATHS specifies the additional library paths we'll need
LIBRARY_PATHS = -LC:\mingw_dev_lib\lib

# COMPILER_FLAGS specifies the additional compilation options we're using
# -w suppresses all warnings (consider -Wall -Wextra instead)
# -Wl,-subsystem,windows gets rid of the console window
COMPILER_FLAGS = -w  -std=c++17 # Added -std=c++17 for modern C++ features

# LINKER_FLAGS specifies the libraries we're linking against
# Added -lSDL2_image for SDL_image support
LINKER_FLAGS = -lmingw32 -lSDL2main -lSDL2 -lSDL2_image

# OBJ_NAME specifies the name of our executable
OBJ_NAME = mygame # Changed to 'mygame' for clarity, as 'main' is also a .cpp file

# This is the primary target that builds our executable
all: $(OBJ_NAME)

# Rule to link the object files into the final executable
$(OBJ_NAME): $(OBJS)
	$(CC) $(OBJS) $(LIBRARY_PATHS) $(LINKER_FLAGS) -o $@ $(COMPILER_FLAGS)


main.o: main.cpp
	$(CC) -c $< $(INCLUDE_PATHS) $(COMPILER_FLAGS) -o $@

Engine.o: src/core/Engine.cpp # Explicit rule for Engine.o from its specific path
	$(CC) -c $< $(INCLUDE_PATHS) $(COMPILER_FLAGS) -o $@

# Phony targets are not actual files, but commands
.PHONY: all clean

# Target to clean up compiled files
clean:
	del $(OBJ_NAME).exe $(OBJS) 