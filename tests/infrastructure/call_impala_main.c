#include <stdio.h>
#include <stdlib.h>

int main_impala(int a, int b);

void* thorin_malloc(size_t size) { 
    void* p;
    posix_memalign(&p, 64, size);
    return p;
}

void println(const char* s) {
    printf("%s\n", s);
}

int main(int argc, const char* argv[]) {
    // main_impala returns bool => 1 if everything ok, 0 if not
    int a = -1;
    int b = -1;

    if(argc > 1) {
        a = atoi(argv[1]);
	if(argc > 2) {
            b = atoi(argv[2]);
        }
	/*if(argc > 3) {
	    global = atoi(argv[3]);
	}*/
	
    }
        
    printf("-> return code was (%i)\n", main_impala(a, b));

    return 0;
}
