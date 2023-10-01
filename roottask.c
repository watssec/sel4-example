/*
 * Copyright 2021, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */

#include "password.h"
#include "debug.h"
#include "sel4/sel4.h"

// init array
int array[SIZE];
int free_head = 5;
int used_head = 6;

int main(void)
{
    // initialize the array
    for (int i =0; i < SIZE; i++){
        array[i] = 0;
    }

    
    int curr_pointer = free_head;
    int curr_element = free_head;
   
    
    /*
    Initialize Free List
    - Loop to initialize
    */
    do{
        // advance to next element
        curr_element += 3;
        // advance to the next pointer
        curr_pointer += 2;
        array[curr_pointer] = curr_element;
    
    }while(curr_element < 5000*3+7);


    // Terminate free list, by setting the last next pointer to 0
    // Here curr_element = 5000*3+7
    array[curr_element] = 0;

    // Write initial free head, set the free-head to point to the first triple
    array[free_head] = used_head + 1;
    


    // Main while loop keeps taking in user input
    while(seL4_True){

        debug_puts("Hi\n");
        debug_puts("Please input password \n");
        seL4_Word userp = seL4_DebugScanf();
        
        debug_puts("Please input secret \n");
        seL4_Word users = seL4_DebugScanf();
        
        debug_puts("You inputed userp \n");
        seL4_DebugPutChar(userp);
        debug_puts("You inputed users \n");
        seL4_DebugPutChar(users);

        seL4_Bool result = CheckForNullSecret(userp, users);
        debug_puts("result \n");
        seL4_DebugPutChar(result);
        if(result == seL4_False){
            // if input has null values, enter again
            debug_puts("No null values please \n");
            continue;
        }
          
        // Otherwise check presence of P in the linked list
        /*
         For the first variable inserted, array[used_head] is 0.
        */
        CheckForPresenceOfP(userp, users);
        
        
    }
    
    return seL4_True;
}
