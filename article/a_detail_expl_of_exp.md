# A Detailed Explanation of the Example

As promised before, in this section, I am going to give detailed explanation
of the first example we saw in the [A Simple Example](./a_simple_example.md).

## Explanation of the Example

Let's recall what we have in that example:

```
cmake_minimum_required(VERSION 3.4)
project(a_simple_example)

aux_source_directory(. SRC_FILES)
add_executable(a_simple_example ${SRC_FILES})
```

There are total 4 lines of code which is wrote in "CMake Language". 
Each line of code here represents one command in "CMake Command". Let's 
go through them one by one.

- `cmake_minimum_required`: 
   this command specify that in order to build this target you at least 
   need to have CMake version 3.4
- `project`: 
   this command define the name of the project
-  `aux_source_directory`:
   this command will scan the directory where the "CMakeLists.txt" file
   locate (because the first argument is `.`, means current folder) and 
   add all the found source code file into the variable name specified in
   the second argument (in this case is "SRC_FILES")
- `add_executable`:
  this command will build the executable with the name you set in the first 
  argument using the files whose name were stored in the second argument

Link them together, in the first example. What we ask the build system to do
can be described as follow: 

> we need to build a project with the name "a_simple_example". This build
> can only happen when the installed cmake version higher than 3.4. Scan current 
> directory found all source files and then use all these files to build an 
> executable name "a_simple_example"

## More detailed of the CMake Command

The following content will try to dig further into the three commands mentioned
above, except the `cmake_minimum_required` since it is not really useful to the
really build process.

### project

According to the cmake documentation, this command full definition:

```
project(<PROJECT-NAME> [LANGUAGES] [<language-name>...])
project(<PROJECT-NAME>
        [VERSION <major>[.<minor>[.<patch>[.<tweak>]]]]
        [DESCRIPTION <project-description-string>]
        [HOMEPAGE_URL <url-string>]
        [LANGUAGES <language-name>...])
```

Once use this command, several variables will be defined implicitly.

- PROJECT_SOURCE_DIR, <PROJECT-NAME>_SOURCE_DIR
- PROJECT_BINARY_DIR, <PROJECT-NAME>_BINARY_DIR

If you have the following structure:

```
+ cake_example/
++++ main.cpp
++++ CMakeLists.txt
++++ build/
```

And you call `cmake ..` inside the build folder. Then the above variables will
be defined as following:

```
PROJECT_SOURCE_DIR = <PROJECT-NAME>_SOURCE_DIR = <abs_path>/cmake_example/
PROJECT_BINARY_DIR = <PROJECT-NAME>_BINARY_DIR = <abs_path>/cmake_example/build/
```

Full documentation of this command can be found 
[here](https://cmake.org/cmake/help/v3.12/command/project.html).

### aux_source_directory

According to the cmake documentation, this command full definition:

```
# Collects the names of all the source files in the specified 
# directory and stores the list in the variable provided. 

aux_source_directory(<dir> <variable>)
```

Need to note that, the cmake cannot no when a new file is added into the project. So
when you add some new source files, you have to manually rerun cmake command to generate
new makefile.

### add_executable

According to the cmake documentation, this command full definition:

```
add_executable(<name> [WIN32] [MACOSX_BUNDLE]
               [EXCLUDE_FROM_ALL]
               [source1] [source2 ...])
add_executable(<name> IMPORTED [GLOBAL])
add_executable(<name> ALIAS <target>)
```

Adds an executable target called `<name>` to be built from the source files
listed in the command invocation. (The source files can be omitted here if 
they are added later using target_sources().) The `<name>` corresponds to the 
logical target name and must be globally unique within a project. The actual 
file name of the executable built is constructed based on conventions of the 
native platform.

So far we only need to know the first usage of the command and 
the "[WIN32] [MACOSX_BUNDLE] [EXCLUDE_FROM_ALL]" option can be ignored.
