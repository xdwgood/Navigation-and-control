#include <iostream>
#include "mytime.h"

int main() {
    using std::cout;
    using std::endl;
    Time xdw1(3, 35);
    Time xdw2(2, 48);
    Time temp;

    cout << xdw1 << " and " << xdw2 << endl;
    temp = xdw1 + xdw2;
    cout << temp << endl;
    cout << xdw1 * 1.17 << endl;
    cout << 10.0 * xdw2 <<endl;

    return 0;
}