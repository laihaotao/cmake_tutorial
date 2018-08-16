# Introduction to CMake

## What is CMake ?

According to Wikipedia, we can have the following overview of `CMake`.

> CMake is a cross-platform free and open-source software application
>  for managing the build process of software using a compiler-independent 
> method. It is used in conjunction with native build environments such as
>  make, Apple's Xcode, and Microsoft Visual Studio. It has minimal 
> dependencies, requiring only a C++ compiler on its own build system. 

## What CMake can do ?

As we already saw from the previous example, in order to get the executable
we do the following command:

```
cmake .. 
make
```

Obviously, `CMake` is the first step in the compilation process, the 
`make` command is the one really instruct the compiler to build the
binary from source code.

To be more clear, we can think in the way that, `CMake` is the tool
we can use to get platform-dependent `makefile`. We write only one
`CMake` file (CMakeLists.txt) and then do the `cmake` command, it 
will produce us the make file according the platform. In the other 
words, it is a make file generator.

## Two ways to build

There are two type of build way,:

- in-place build
- out-of-place build

Both these two way can get the same result, but one key feature of 
cmake is the second one, out-of-place build. The ability to build a
directory tree outside the source tree ensurign that if the build 
folder is removed, it will not affect the source files (the source
files remain unaffected during the build process).

In the following tutorials, I will always use the out-of-place build
to do the demon, you are also encouraged to use that type of build when
you write you own code, especially when you are working with a large
project which contains lots of files and subfolders. How to manage 
subdirectories will come in the later tutorial.

## CMake language

CMake input files, such as `CMakeLists.txt` or `*.cmake`, are written 
in "CMake Language". 

### organization

CMake language source files in a project are organized into:

- directories
- scripts
- modules

In the top level (project root directory), we can use the cmake command
`add_subdirectory()` to add a subdirectory into the build. But there must
be a corresponding `CMakeLists.txt` file in that folder to tell cmake how
to deal with the content in this directory. Each subdirectory will get a
folder with the same name (unless you specific a new name for it) under the 
build root folder.

An individual "XXX.cmake" can be processed in script mode. Assume you have a
file name "hello.cmake" with the following content:

```cmake
message("hello world")
```

You can run this file with the following command:

```shell
cmake -P hello.cmake
```

In the script mode, you are not able to generate the build system, which means
that you cannot really complete a build process (make any executable or library).
People often use it to find some specific packages, download some necessary
dependencies and check whether some required libraries exist or not.

Modules means that any "XXX.cmake" can be loaded as a module and add into the source 
file in both directories and scripts. The command to load is `include(file_path_and_name)`.

### Control flow

Just like a normal programming language, cmake also has its own flow control keyword.

```
# condition
if() / elseif() / else() / endif()

# loop and break
foreach() / endforeach()
while() / endwhile()
break()

# record command for future reuse
macro()/endmacro()
function()/endfunction() 
```

### Variables

In cmake all the user-defined variables have to use the `set()` command to define.
If you want to create a variable name "src_file" you can do the following:

```
set(src_file a.cpp)
```

In some other place, you may want to refer to this variable, you have to use the `$`.

```
# in this example, the output will be the same but
# actually has a little bit different, will be 
# explained later

message("src_file -> " ${src_file})
message("src_file -> " "${src_file}")
```

### Lists

When we use the command `set()` to define a variable, we actually define a "list". We
can also use this command as follow:

```
set(file_list a.cpp b.cpp c.cpp)
message("file_list -> " ${file_list})    # ref.1
message("file_list -> " "${file_list}")  # ref.2
```

Obviously, this kind of situation always happens when you need to build an executable
which dependent on a set of source files. First of all, we need to have all the
files' name. In the above example, the variable `file_list` contains three elements we
can think it a a list.

In "ref.1", we refer to the variable using the name directly. It will like a `foreach`
statement, while the "ref.2", refer the variable with quotation， it means treat it as
a list. So the output will be a little bit different.

```
# output three file names right after the previous one
file_list -> a.cppb.cppc.cpp

# output as a list, separated by ";"
file_list -> a.cpp;b.cpp;c.cpp
```

Want to know more, can visit the cmake offical documentation for [cmake language](https://cmake.org/cmake/help/v3.12/manual/cmake-language.7.html).

## CMake build system

