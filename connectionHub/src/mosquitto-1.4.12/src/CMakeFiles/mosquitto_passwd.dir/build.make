# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.6

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/pi/connectionHub/src/mosquitto-1.4.12

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/pi/connectionHub/src/mosquitto-1.4.12

# Include any dependencies generated for this target.
include src/CMakeFiles/mosquitto_passwd.dir/depend.make

# Include the progress variables for this target.
include src/CMakeFiles/mosquitto_passwd.dir/progress.make

# Include the compile flags for this target's objects.
include src/CMakeFiles/mosquitto_passwd.dir/flags.make

src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o: src/CMakeFiles/mosquitto_passwd.dir/flags.make
src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o: src/mosquitto_passwd.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/pi/connectionHub/src/mosquitto-1.4.12/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o"
	cd /home/pi/connectionHub/src/mosquitto-1.4.12/src && /usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o   -c /home/pi/connectionHub/src/mosquitto-1.4.12/src/mosquitto_passwd.c

src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.i"
	cd /home/pi/connectionHub/src/mosquitto-1.4.12/src && /usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/pi/connectionHub/src/mosquitto-1.4.12/src/mosquitto_passwd.c > CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.i

src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.s"
	cd /home/pi/connectionHub/src/mosquitto-1.4.12/src && /usr/bin/cc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/pi/connectionHub/src/mosquitto-1.4.12/src/mosquitto_passwd.c -o CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.s

src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o.requires:

.PHONY : src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o.requires

src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o.provides: src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o.requires
	$(MAKE) -f src/CMakeFiles/mosquitto_passwd.dir/build.make src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o.provides.build
.PHONY : src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o.provides

src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o.provides.build: src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o


# Object files for target mosquitto_passwd
mosquitto_passwd_OBJECTS = \
"CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o"

# External object files for target mosquitto_passwd
mosquitto_passwd_EXTERNAL_OBJECTS =

src/mosquitto_passwd: src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o
src/mosquitto_passwd: src/CMakeFiles/mosquitto_passwd.dir/build.make
src/mosquitto_passwd: /usr/lib/arm-linux-gnueabihf/libssl.so
src/mosquitto_passwd: /usr/lib/arm-linux-gnueabihf/libcrypto.so
src/mosquitto_passwd: src/CMakeFiles/mosquitto_passwd.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/pi/connectionHub/src/mosquitto-1.4.12/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable mosquitto_passwd"
	cd /home/pi/connectionHub/src/mosquitto-1.4.12/src && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/mosquitto_passwd.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/CMakeFiles/mosquitto_passwd.dir/build: src/mosquitto_passwd

.PHONY : src/CMakeFiles/mosquitto_passwd.dir/build

src/CMakeFiles/mosquitto_passwd.dir/requires: src/CMakeFiles/mosquitto_passwd.dir/mosquitto_passwd.c.o.requires

.PHONY : src/CMakeFiles/mosquitto_passwd.dir/requires

src/CMakeFiles/mosquitto_passwd.dir/clean:
	cd /home/pi/connectionHub/src/mosquitto-1.4.12/src && $(CMAKE_COMMAND) -P CMakeFiles/mosquitto_passwd.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/mosquitto_passwd.dir/clean

src/CMakeFiles/mosquitto_passwd.dir/depend:
	cd /home/pi/connectionHub/src/mosquitto-1.4.12 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/pi/connectionHub/src/mosquitto-1.4.12 /home/pi/connectionHub/src/mosquitto-1.4.12/src /home/pi/connectionHub/src/mosquitto-1.4.12 /home/pi/connectionHub/src/mosquitto-1.4.12/src /home/pi/connectionHub/src/mosquitto-1.4.12/src/CMakeFiles/mosquitto_passwd.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/mosquitto_passwd.dir/depend

