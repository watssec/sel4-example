/*
 * Copyright 2021, Data61, CSIRO (ABN 41 687 119 230)
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */


#define SIZE 5000
// init array
int array[SIZE];
int free_head = 5;
int used_head = 6;
int p_placeholder = 1000;
int s_placeholder = 2000;

char CheckForNullSecret(long int userp, long int users){
    
    if((userp == '0') || (users == '0')){
        return 0;
    }else{
        
        return 1;
    }
}

char PwasFound(int temp){
    // push forward to get the secret

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

    return 1;
}

char EndOfUsedListFound (int temp, int userp, int users){

    // If no more free elements available
    // It is the same as checking if there is still free memory
    if(array[free_head] == 0){
        return 0;
    }
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

    // DCOPY r3, r2; free_head -> next element
    array[free_head] = temp_var_new;

    
    return 1;
}

char CheckForPresenceOfP ( int userp, int users){
    // Check whether the used head point to 0
    int temp = array[used_head];

    while(array[temp] != 0){
        // if found, goto PwasFound
    
        if(array[temp] == userp){
           
            PwasFound(temp);
            return 1;
        }
        // if not found and it is not the end, go to the next one in list

        temp += 2;
        temp = array[temp];
    }
   
    // if used_head point to 0, jump to 
    EndOfUsedListFound(temp, userp, users);

    return 1;
}



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
    while(1){

        // intput password
        long int userp = p_placeholder;
        // intput secret
        long int users = s_placeholder;
        

        char result = CheckForNullSecret(userp, users);
        
        if(result == 0){
            // if input has null values, enter again
         
            continue;
        }
          
        // Otherwise check presence of P in the linked list
        /*
         For the first variable inserted, array[used_head] is 0.
        */
        CheckForPresenceOfP(userp, users);
        
        
    }
    
    return 1;
}
