#include "password.h"
#include "sel4/sel4.h"
#include "debug.h"



seL4_Bool CheckForNullSecret(seL4_Word userp, seL4_Word users){
    
    if((userp == '0') || (users == '0')){
        return seL4_False;
    }else{
        
        return seL4_True;
    }
}

seL4_Bool PwasFound(int temp){
    // push forward to get the secret
    seL4_DebugPutChar(array[temp+1]);

    /*
    temp-> p temp+1 -> s temp +2 -> next
    */
    // I am not detaching it from used_list for now,
    // since that requires me to rememeber the previous element in used_list as well

    // create a temparary varaible (r0)
    int temp_var = 0;
    // ICOPY r1, r0, read free_head into temp
    temp_var = array[free_head];
    // DCOPY r2, r1, make temp's next to be free_head
    array[temp+2] = free_head;
    // DCOPY r1, r3, make free_head to be temp
    array[free_head] = temp;

    return seL4_True;
}

seL4_Bool EndOfUsedListFound (int temp, int userp, int users){

    // If no more free elements available
    // It is the same as checking if there is still free memory
    if(array[free_head] == 0){
        return seL4_False;
    }
    debug_puts("pwasnotfound, but there is space available! \n");
    // ICOPY r3,r2, get the first element from the free list to a temp var (r2)
    
    // temp_var_new is 7 the first time entering this function
    int temp_var_new = array[free_head];
  
    // write p into free_head
   
    /*
    array[7] = p
    array[8] = s
    */

    array[temp_var_new] = userp;
    array[temp_var_new+1] = users;
    
    // Deal with used_head
    
    // ICOPY r0,r1 ->; r1(temp_var_used)
    // Load used_head value 
    int temp_var_used = array[used_head];
    // DCOPY r0, r2 <-; r2(temp_var_new)
    array[used_head] = temp_var_new;
    // ICOPY (r2+2), r2 (r2 is )
    temp_var_new = array[temp_var_new+2];
    // DCOPY r4, r1
    array[temp_var_new+2] = temp_var_used;
    if(temp_var_used == 0){
        debug_puts("used_head has been put in to the list, it is 0!!! \n");
    }
    // DCOPY r3, r2; free_head -> next element
    array[free_head] = temp_var_new;
    if(array[used_head] ==7){
        debug_puts("used_head contains 7 now \n");
    }
    
    return seL4_True;
}

seL4_Bool CheckForPresenceOfP ( int userp, int users){
    // Check whether the used head point to 0
    int temp = array[used_head];

    while(array[temp] != 0){
        // if found, goto PwasFound
        if(array[temp] ==1 ){
            debug_puts("the inserted value is 1!!! \n");
        }
        if(array[temp] == userp){
            debug_puts("pwasfound!!! \n");
            PwasFound(temp);
            return seL4_True;
        }
        // if not found and it is not the end, go to the next one in list

        temp += 2;
        temp = array[temp];
    }
    debug_puts("pwasnotfound \n");
    // if used_head point to 0, jump to 
    EndOfUsedListFound(temp, userp, users);

    return seL4_True;
}

