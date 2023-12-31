/*
 * Copyright 2021, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */

#include "debug.h"

/* Display a string via the debug output */
void debug_puts(const char *text)
{
    while (text && *text != '\0') {
        seL4_DebugPutChar(*text);
        text++;
    }
}

/* Print an integer */
void debug_puti(int i)
{
    unsigned n = 1;

    if (i < 0) {
        seL4_DebugPutChar('-');
        i *= -1;
    }

    while (n < i) {
        n *= 10;
    }

    while (n > 1) {
        seL4_DebugPutChar('0' + i / n);
        i -= i / n;
        n /= 10;
    }

    seL4_DebugPutChar('0' + i);
}

/* Scan a string */
char* debug_scanf(){
    
    seL4_MessageInfo_t temp;
    char result[256];
    seL4_CPtr result_ptr  = alloc_cptr();
   
    debug_puts('a');
    int cnt = 0; 
    /*
    do{
        temp = seL4_DebugScanf(result_ptr);

        result[cnt] = result_ptr;
        cnt ++;
        debug_puts('a');
    }while(temp!='\n');
    */
    return result;
}