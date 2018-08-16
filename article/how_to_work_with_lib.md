# How to Work with Existing Libraries

Most of time when we develop a software, we will not write everything
from scratch. We usually will use other programmers' libraries or frameworks
which is more reliable and can speed up our development process.

Basic on this scenario, it is important to learn how to work with other people's
libraries (existing libraries).

Let's follow up the story we used in the previous section. I am a newbird programmer
and my labmate Jash is an expert in C++ programming. Last time he already gave me an
example to teach me how to use his `JashAdd` library. But this time, I need to use,
let says, the `OpenCV` library which is not provided by Jash. And without any example
I don't know how to use it in my code.

Even though I am a newbird programmer, but at least I know if I want to use `OpenCV` I
have to install it locally or compile it from source code. So when Jash asked me do you
have it installed. I quickly answer yes. (If you are new to cmake, it will be a challance
to compile it from source, the best option will be get the pre-compiled version. This
tutorial will be tell you how to install `OpenCV`.)

## Find the Library

The first step to use an existing library is to locate them in your machine. Of course,
you can give the absolute path directly. But please keep in mind that `CMake` is a
cross-platform build tool. If you just give the abs path directly, it will break the
cross-platform feature. So the proper way to do it is tell cmake to search the targeted
library in some lib paths (like environment variable, /usr/local/lib, /usr/lib/, etc).

You should also remember that in cmake, there are something called scripts, one of their
main job is to detect whether a local machine contains the needed lib or not, if not try
to download them, if contains, return the necessary paths of the lib.

### find_package

```
find_package(<package> [version] [EXACT] [QUIET] [MODULE]
             [REQUIRED] [[COMPONENTS] [components...]]
             [OPTIONAL_COMPONENTS components...]
             [NO_POLICY_SCOPE])

find_package(<package> [version] [EXACT] [QUIET]
             [REQUIRED] [[COMPONENTS] [components...]]
             [CONFIG|NO_MODULE]
             [NO_POLICY_SCOPE]
             [NAMES name1 [name2 ...]]
             [CONFIGS config1 [config2 ...]]
             [HINTS path1 [path2 ... ]]
             [PATHS path1 [path2 ... ]]
             [PATH_SUFFIXES suffix1 [suffix2 ...]]
             [NO_DEFAULT_PATH]
             [NO_PACKAGE_ROOT_PATH]
             [NO_CMAKE_PATH]
             [NO_CMAKE_ENVIRONMENT_PATH]
             [NO_SYSTEM_ENVIRONMENT_PATH]
             [NO_CMAKE_PACKAGE_REGISTRY]
             [NO_CMAKE_BUILDS_PATH] # Deprecated; does nothing.
             [NO_CMAKE_SYSTEM_PATH]
             [NO_CMAKE_SYSTEM_PACKAGE_REGISTRY]
             [CMAKE_FIND_ROOT_PATH_BOTH |
              ONLY_CMAKE_FIND_ROOT_PATH |
              NO_CMAKE_FIND_ROOT_PATH])

```

Detailed documentation provided by `CMake` can be found 
[here](https://cmake.org/cmake/help/latest/command/find_file.html).

### find_file

This command will try to find the **full path of the file** with `<name>` among the 
given paths. If it is found, the full path will be stored in the `<VAR>`, the search will
not be repeated. If nothing is found, the result will be `<VAR>-NOTFOUND`, next time if
the same command is invoked, will perform the search again.

```
# short hand version
find_file (<VAR> name [path1 path2 ...])

# full signature
find_file (
          <VAR>
          name | NAMES name1 [name2 ...]
          [HINTS path1 [path2 ... ENV var]]
          [PATHS path1 [path2 ... ENV var]]
          [PATH_SUFFIXES suffix1 [suffix2 ...]]
          [DOC "cache documentation string"]
          [NO_DEFAULT_PATH]
          [NO_PACKAGE_ROOT_PATH]
          [NO_CMAKE_PATH]
          [NO_CMAKE_ENVIRONMENT_PATH]
          [NO_SYSTEM_ENVIRONMENT_PATH]
          [NO_CMAKE_SYSTEM_PATH]
          [CMAKE_FIND_ROOT_PATH_BOTH |
           ONLY_CMAKE_FIND_ROOT_PATH |
           NO_CMAKE_FIND_ROOT_PATH]
         )
```

Detailed documentation provided by `CMake` can be found 
[here](https://cmake.org/cmake/help/latest/command/find_file.html).

### find_path

This command is used to find the **directory** contains the specific file. Other
almost the same as the `find_file()` command.

```
# short hand version
find_path (<VAR> name [path1 path2 ...])

# full signature
find_path (
        <VAR>
          name | NAMES name1 [name2 ...]
          [HINTS path1 [path2 ... ENV var]]
          [PATHS path1 [path2 ... ENV var]]
          [PATH_SUFFIXES suffix1 [suffix2 ...]]
          [DOC "cache documentation string"]
          [NO_DEFAULT_PATH]
          [NO_PACKAGE_ROOT_PATH]
          [NO_CMAKE_PATH]
          [NO_CMAKE_ENVIRONMENT_PATH]
          [NO_SYSTEM_ENVIRONMENT_PATH]
          [NO_CMAKE_SYSTEM_PATH]
          [CMAKE_FIND_ROOT_PATH_BOTH |
           ONLY_CMAKE_FIND_ROOT_PATH |
           NO_CMAKE_FIND_ROOT_PATH]
         )
```

Detailed documentation provided by `CMake` can be found 
[here](https://cmake.org/cmake/help/latest/command/find_path.html).

### find_library

This command is used to find a library. Library means it can be a static or dynamic library.

```
# short hand version
find_library (<VAR> name [path1 path2 ...])

# full signature
find_library (
          <VAR>
          name | NAMES name1 [name2 ...] [NAMES_PER_DIR]
          [HINTS path1 [path2 ... ENV var]]
          [PATHS path1 [path2 ... ENV var]]
          [PATH_SUFFIXES suffix1 [suffix2 ...]]
          [DOC "cache documentation string"]
          [NO_DEFAULT_PATH]
          [NO_PACKAGE_ROOT_PATH]
          [NO_CMAKE_PATH]
          [NO_CMAKE_ENVIRONMENT_PATH]
          [NO_SYSTEM_ENVIRONMENT_PATH]
          [NO_CMAKE_SYSTEM_PATH]
          [CMAKE_FIND_ROOT_PATH_BOTH |
           ONLY_CMAKE_FIND_ROOT_PATH |
           NO_CMAKE_FIND_ROOT_PATH]
         )
```

Detailed documentation provided by `CMake` can be found 
[here](https://cmake.org/cmake/help/latest/command/find_library.html).

### find_program

This command is used to find a program. Program means it is an executable file.

```
# short hand version
find_program (<VAR> name1 [path1 path2 ...])

# full signature
find_program (
          <VAR>
          name | NAMES name1 [name2 ...] [NAMES_PER_DIR]
          [HINTS path1 [path2 ... ENV var]]
          [PATHS path1 [path2 ... ENV var]]
          [PATH_SUFFIXES suffix1 [suffix2 ...]]
          [DOC "cache documentation string"]
          [NO_DEFAULT_PATH]
          [NO_PACKAGE_ROOT_PATH]
          [NO_CMAKE_PATH]
          [NO_CMAKE_ENVIRONMENT_PATH]
          [NO_SYSTEM_ENVIRONMENT_PATH]
          [NO_CMAKE_SYSTEM_PATH]
          [CMAKE_FIND_ROOT_PATH_BOTH |
           ONLY_CMAKE_FIND_ROOT_PATH |
           NO_CMAKE_FIND_ROOT_PATH]
         )
```

Detailed documentation provided by `CMake` can be found 
[here](https://cmake.org/cmake/help/latest/command/find_program.html).
