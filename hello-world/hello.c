#include <stdio.h>
#include <stdlib.h>

#ifndef ARCH
#define ARCH "Undefined"
#endif
 
int main() 
{
    printf("Hello innovation coffee, architecture from uname is %s\n", ARCH);

    switch (sizeof(void *))
    {
        case 4:
            printf("32-bit userspace\n");
            break;
        case 8:
            printf("64-bit userspace\n");
            break;
        default:
            printf("unknown userspace\n");
    }
    exit(0);
}
