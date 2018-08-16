# How to Publish a Library

## Background

As programmer, sometime we may write a super cool and useful
code and we want to let all other programmers can use it. 

What we can do? Of course, make it as library (static or dynamic).
A library is a binary file contains all the compiled code you think
is useful and others can use them without having the source code,
the user only need to include corresponding header files to use them.

Let's go through these concepts via an example. Assume I am a newbird
in programming, I would like to add two integers together but I don't
know how to do it. My labmate, Jash, is an expert programmer in C++, he
said he can create a library for me do to the addition for two integers.

There is the code Jash may write:

```c++
// add.h
#ifndef JASH_ADD_H
#define JASH_ADD_H

class Math {
    int add(int x, int y);
};
#endif // end of JASH_ADD_H


// add.cpp
#include "add.h"
int Math::add(int x, int y) {
    return x + y;
}
```

But Jash doesn't want me to look into the source code since it is
too "complicated" for a newbird programmer like me, I just need to
know how to use it. So he gave me the `add.h` file and a binary file
name "XXX.a" (the os Jash used is MacOs). 

Jash structure the code in the following format. In case of I don't 
know how to use, Jash also provide me an example in "main.cpp" file.

```
+ how_to_publish_lib/      <- project root
++++ src/                  <- Jash lib source code folder
++++++++ add.cpp           <- the implementation of [add(int, int): int] method
++++++++ CMakeLists.txt    <- specify to build a library (static, in this case)
++++ CMakeLists.txt        <- root CMakeLists.txt, link Jash's lib and the example
++++ add.h                 <- head file with the [add(int, int): int] declaration
++++ main.cpp              <- example show how to use [add(int, int): int]
```

The "CMakeLists.txt" file control to build the library is wrote in the
following way:

```
# src/CMakeLists.txt

set(SRC_FILE add.cpp)
add_library(JashAdd ${SRC_FILE})
```

The above code will produce an binary file name "libJashAdd.a" which is
the static file contain the implementation of add(int, int): int method.
In order for others to use it, the author should provide the interface 
(head file) and the binary lib. In the user side, when you have the lib,
you have to tell the linker to link the library. So the "CMakeLists.txt"
in the root directory will look like:

```
# CMakeLists.txt

cmake_minimum_required(VERSION 3.4)
project(how_to_publish_lib)
add_subdirectory(src/)
add_executable(use_lib_demo main.cpp)
target_link_libraries(use_lib_demo JashAdd)
```

A full version of code can be found the under 
`cmake_tutorial/code/how_to_publish_lib/only_static` folder. `cd` into that 
folder and do an out-of-place build, should be able to see the static library
and the `use_lib_demo` executable.

## New Commands

There are several new commands show up here, let go through them one by one.

### add_subdirctory

This command is used to add a subdirectory to the build. Full syntax shows below:

```
add_subdirectory(source_dir [binary_dir]
                 [EXCLUDE_FROM_ALL])
```

The `binary_dir` specifies the directory in which to place the output files. 
If `binary_dir` is not specified, the value of `source_dir`, before expanding 
any relative path, will be used (the typical usage). The "CMakeLists.txt" 
file in the specified source directory will be processed immediately by 
CMake before processing in the current input file continues beyond this command.

If the `EXCLUDE_FROM_ALL` argument is provided then targets in the subdirectory
will not be included in the ALL target of the parent directory by default.

### add_library

Adds a library target called `<name>` to be built from the source files listed in the command invocation. The actual file name of the library built is constructed based on conventions of the native platform (such as `lib<name>.a` or `<name>.lib`).

```
add_library(<name> [STATIC | SHARED | MODULE]
            [EXCLUDE_FROM_ALL]
            [source1] [source2 ...])
```

`STATIC`, `SHARED`, or `MODULE` may be given to specify the type of library 
to be created.

- `STATIC` 
   libraries are archives of object files for use when linking other targets. 
- `SHARED` 
   libraries are linked dynamically and loaded at runtime. 
- `MODULE` 
   libraries are plugins that are not linked into other targets but may be
   loaded dynamically at runtime using dlopen-like functionality. 

If no type is given explicitly the type is STATIC or SHARED based on whether 
the current value of the variable `BUILD_SHARED_LIBS` is `ON` (basically, by default
it will be the static library).

By default the library file will be created in the build tree directory corresponding
to the source tree directory in which the command was invoked. But you can specify the 
output directory using the following target properties:

- `ARCHIVE_OUTPUT_DIRECTORY`
- `LIBRARY_OUTPUT_DIRECTORY`
- `RUNTIME_OUTPUT_DIRECTORY`

```
set_target_properties(<name>
    PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY <path>
    LIBRARY_OUTPUT_DIRECTORY <path>
    RUNTIME_OUTPUT_DIRECTORY <path>
)
```

### target_link_libraries

```
target_link_libraries(<target> ... <item>... ...)
```

The named `<target>` must have been created in the current directory by a command
such as `add_executable()` or `add_library()`.

Each `<item>` may be:

- a library target name
- a full path to a library file
- a plain library name
- a link flag (can ignore so far)

## How to Build both STATIC and DYNAMIC Library

In the example above, we only build the `STATIC` lib which end up with the name "XXX.a".
But in most of the library we used today, they both provide static and dynamic lib, the
user can use them basic on their demand.

Let's see how can we both them in one shot. Since cmake by default doesn't allow a target
have the same `<name>`. So we cannot just simply do `add_library()` twice, instead we have
to give them different name first then after the build rename them to be the same (since
the same library should have the same name even if they are different type)

Still use the example given at the beginning of this post. We need to modify the
`src/CMakeLists.txt` file:

```
aux_source_directory(. SRC_FILES)

add_library(JashAdd_static STATIC ${SRC_FILES})
SET_TARGET_PROPERTIES(JashAdd_static 
    PROPERTIES 
        OUTPUT_NAME "JashAdd"
        CLEAN_DIRECT_OUTPUT 1
)

add_library(JashAdd_dynamic SHARED ${SRC_FILES})
SET_TARGET_PROPERTIES(JashAdd_dynamic 
    PROPERTIES 
        OUTPUT_NAME "JashAdd"
        CLEAN_DIRECT_OUTPUT 1
)
```

Since we change the target name here, in the root "CMakeLists.txt" file, we have to
change `target_link_libraries()` command, give the unique name of the library you want
to link, in this case, static or dynamic is not the problem. We already seen the static
one, this time let's try the dynamic one:

```
cmake_minimum_required(VERSION 3.4)
project(how_to_publish_lib)
add_subdirectory(src/)
add_executable(use_lib_demo main.cpp)
target_link_libraries(use_lib_demo JashAdd_dynamic)
```

Again, a full version of code can be found the under 
`cmake_tutorial/code/how_to_publish_lib/static_and_dynamic` folder. `cd` into that 
folder and do an out-of-place build, should be able to see both the static and 
dynamic library and the `use_lib_demo` executable.
