#include"password.h"
#include <stdio.h>

seL4_Bool CheckForNullSecret(int userp, int users){
    if(userp == 0 || users == 0){
        return seL4_False;
    }else{
        return seL4_True;
    }
}

seL4_Bool PwasFound(node_t * free_head, node_t * temp){
    debug_puti(temp->s);
    temp->next = free_head->next;
    free_head->next = temp;
    return seL4_True;
}

seL4_Bool EndOfUsedListFound (node_t *used_head, node_t *free_head, node_t * temp, int userp, int users){

    // If no more free elements available
    // It is the same as checking if there is still free memory
    if(free_head ->next == 0){
        return seL4_False;
    }
    
    // if there are still free spaces
    // write things into the first free element
    free_head->next->p = userp;
    free_head->next->s = users;
    // cut off the element from free_head list
    free_head ->next = free_head->next->next;
    // add the newly inserted one into the used list
    temp -> next = used_head ->next;
    used_head->next = temp;
    return seL4_True;
}

seL4_Bool CheckForPresenceOfP (node_t *used_head, node_t *free_head, int userp, int users){
    node_t * temp = used_head;
    node_t * temp_next = temp->next;
    
    while(temp_next != 0){
        // if found, goto PwasFound
        if(temp_next->p == userp){
            PwasFound(free_head, temp_next);
            return seL4_True;
        }
        // if not found and it is not the end, go to the next one in list
        temp = temp->next;
        temp_next = temp_next ->next;
    }
    EndOfUsedListFound(used_head, free_head, temp, userp, users);
    return seL4_True;
}

