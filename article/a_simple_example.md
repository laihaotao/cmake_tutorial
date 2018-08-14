# A Simple Example

Before we really dig into `CMake`, let's quickly see an example 
to have a basic understanding of how it works.

Assume we have the following program and want to obtain the executable 
of this program.

```c++
// main.cpp

#include <iostream>

int addTwoInt(int a, int b);

int main() {
    int x = 1, y = 2;
    int result = addTwoInt(x, y);

    std::cout << "the result of " 
              << x << " + " << y 
              << " is ->" << result 
              << std::endl;

    return 0;
}

int addTwoInt(int a, int b) {
    return a + b;
}
```

The most easiest way for this one file, of course, is compilling directly
with the following command:

```
g++ -o main main.cpp
```

But unfortunately, that is not our case, we are going to compile them with
`CMake` as when the project becomes more and more complicated we cannot just
use the command to do that, we need some automatic tool to help us and solve
the cross-platform problem as well.

In order to use `CMake`, we need to create a file with the name "CMakeLists.txt"
in the same folder with the source file, in this case, the `main.cpp`.

```
# CMakeLists.txt
# put this file in the same folder with the source code file

project(a_simple_example)
cmake_minimum_required(VERSION 3.4)

aux_source_directory(. SRC_FILES)
add_executable(a_simple_example ${SRC_FILES})
```

Since it is just an example, I am not going to give the explanation, just follows
the instruction and see the result first. Open a terminal, do the following:

```shell
mkdir build && cd build
cmake .. && make
./a_simple_example
```

You should be able to see the result:

```
the result of 1 + 2 is -> 3
```

In the section after the next one, I will give the detailed explanation.
