#include <iostream>

int addTwoInt(int a, int b);

int main() {
    int x = 1, y = 2;
    int result = addTwoInt(x, y);

    std::cout << "the result of " 
              << x << " + " << y 
              << " is -> " << result 
              << std::endl;

    return 0;
}

int addTwoInt(int a, int b) {
    return a + b;
}