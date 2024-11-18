// clang++ examples/sampling.cpp -o _demos/sampling -I./public/tracy public/TracyClient.cpp -DTRACY_ENABLE -g

#include "Tracy.hpp"
#include "TracyC.h"

static TracyCZoneCtx zone;

namespace
{
void func0()
{
    sleep( 1 );
    printf( "func0\n" );
}

void func1() { printf( "func1\n" ); }

void func2()
{
    sleep( 1 );
    printf( "func2\n" );
    for( int i = 0; i < 10; ++i )
    {
        func1();
    }
}
}

int main()
{
    func0();
    func2();
    return 0;
}
