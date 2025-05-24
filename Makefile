# OBJS specifies which object files to create as part of the project
# Note: These are .o files derived from SRCS.
# We need to list the source files with their full paths if they are in subdirectories.
SRCS = main.cpp src/core/Engine.cpp # Use forward slashes for paths even on Windows for Makefiles

# OBJS: Automatically convert .cpp to .o
# We need to make sure the .o files are placed where make expects them, often in the same dir.
# Using 'notdir' gets just the filename, then adds .o suffix.
# Or, if you want .o files in a separate build directory, that's a more advanced setup.
# For now, let's keep the .o files in the current directory and use the original SRCS paths.
# If you want to keep the .o files in the same directory as the .cpp, use this:
# OBJS = $(patsubst %.cpp,%.o,$(SRCS))
# However, for simplicity and to match common behavior with complex paths,
# let's just create the .o files in the current directory.
# The pattern rule below will handle this by creating 'main.o' and 'Engine.o' (derived from src/core/Engine.cpp)
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

# Pattern rule to compile .cpp files into .o files
# This rule is crucial for Make to understand how to build 'main.o' and 'Engine.o'
# when their source files are 'main.cpp' and 'src/core/Engine.cpp' respectively.
# For 'src/core/Engine.cpp', the target will be 'Engine.o' (in the current directory).
# Make will automatically map 'Engine.o' to 'src/core/Engine.cpp' if it exists.
# We explicitly list the full paths in the OBJS and the dependency for Engine.o.
main.o: main.cpp
	$(CC) -c $< $(INCLUDE_PATHS) $(COMPILER_FLAGS) -o $@

Engine.o: src/core/Engine.cpp # Explicit rule for Engine.o from its specific path
	$(CC) -c $< $(INCLUDE_PATHS) $(COMPILER_FLAGS) -o $@

# Phony targets are not actual files, but commands
.PHONY: all clean

# Target to clean up compiled files
clean:
	del $(OBJ_NAME).exe $(OBJS) 