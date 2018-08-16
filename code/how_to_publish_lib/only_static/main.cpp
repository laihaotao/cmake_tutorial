#include <iostream>
#include "add.h"

int main(int argc, char const *argv[]) {
    
    int x = 1;
    int y = 2;
    Math math;

    int z = math.add(x, y);
    std::cout << "the result of x + y -> " << z << std::endl;

    return 0;
}
