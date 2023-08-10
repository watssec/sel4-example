/*
 * Copyright 2021, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */

#include "password.h"
#include "debug.h"

#define SIZE 5000

int main(void)
{
    // Set dummy free_hread, used_head
    node_t * free_head = alloc_cptr(); 
    node_t * used_head = alloc_cptr();
    
    free_head -> s = NULL;
    used_head -> s = NULL;

    free_head -> p = NULL;
    free_head -> p = NULL;

    free_head -> next = NULL;
    used_head -> next = free_head;
    
    node_t * new_temp = free_head;
    // initialize the free list
    for(int i = 0; i < SIZE; i++){
        node_t * new_node = alloc_cptr();
        new_node -> s = NULL;
        new_node -> p = NULL;
        new_temp -> next = new_node;
        new_temp = new_node;
    }

    int userp;
    int users;
    // Main while loop keeps taking in user input
    while(seL4_True){
        debug_puts("Hi\n");
        debug_puts("Please input password \n");
        char *userp;
        userp = debug_scanf();
        debug_puts("Please input secret \n");
        char *users;
        users = debug_scanf();
        debug_puts("You inputed userp \n");
        debug_puts(userp);
        debug_puts("You inputed users \n");
        debug_puts(users);
        if(!CheckForNullSecret(userp, users)){
            // if input has null values, enter again
            continue;
        }
        // Otherwise check presence of P in the linked list
        CheckForPresenceOfP(used_head, free_head, userp, users);
    }
    return seL4_False;
}
