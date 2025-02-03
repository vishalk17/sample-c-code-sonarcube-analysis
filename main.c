#include <stdio.h>
#include "circle.h"

double calculate_area(double radius) {
    return 3.14159 * radius * radius;
}

int main() {
    double radius = 5.0;
    double area = calculate_area(radius);
    printf("The area of the circle with radius %.2lf is %.2lf\n", radius, area);
    return 0;
}

