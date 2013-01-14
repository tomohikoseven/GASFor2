#include<stdio.h>
#include<stdlib.h>

int
main( int argc, char** argv )
{
    int i = 1;
    int loopNum = 0;

    if( 2 != argc )
    {
        printf("usage : ./main loopNum.\n");
        exit(1);
    }
    loopNum = atoi(argv[1]);

    for( i = 0; i < loopNum; i++ )
    {
        printf("i = %d\n", i);
    }
    return 0;
}
