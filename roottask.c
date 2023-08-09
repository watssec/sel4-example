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
    
    free_head -> s = 0;
    used_head -> s = 0;

    free_head -> p = 0;
    free_head -> p = 0;

    free_head -> next = 0;
    used_head -> next = free_head;
    
    node_t * new_temp = free_head;
    // initialize the free list
    for(int i = 0; i < SIZE; i++){
        node_t * new_node = alloc_cptr();
        new_node -> s = 0;
        new_node -> p = 0;
        new_temp -> next = new_node;
        new_temp = new_node;
    }

    int userp;
    int users;
    // Main while loop keeps taking in user input
    while(seL4_True){
        printf("Hi\n");
        printf("Please input password and secret\n");
        scanf(" %d%d", &userp, &users);
        printf("You inputed userp %d \n", userp);
        printf("You inputed users %d \n", users);
        if(!CheckForNullSecret(userp, users)){
            // if input has null values, enter again
            continue;
        }
        // Otherwise check presence of P in the linked list
        CheckForPresenceOfP(used_head, free_head, userp, users);
    }
    return seL4_False;
}
