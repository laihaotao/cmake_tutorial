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

### Syntax

### Control flow

### Variables

### Lists

Want to know more, can visit the cmake offical documentation for [cmake language](https://cmake.org/cmake/help/v3.12/manual/cmake-language.7.html).

## CMake build sytem