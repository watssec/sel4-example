PwasFound example: 

```
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
```
```
PwasFound_body ≡
TRY
  ´temp_var :== 0;;
  Guard ArrayBounds ⦃free_head <s 0x1388⦄ (Guard ArrayBounds ⦃0 ≤s free_head⦄ (´temp_var :== ´array.[unat free_head]));;
  Guard ArrayBounds ⦃´temp + 2 <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s ´temp + 2⦄
     (Guard SignedArithmetic ⦃- 2147483648 ≤ sint ´temp + sint 2 ∧ sint ´temp + sint 2 ≤ 2147483647⦄
       (´globals :== array_'_update (λ_. Arrays.update ´array (unat (´temp + 2)) free_head))));;
  Guard ArrayBounds ⦃free_head <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s free_head⦄ (´globals :== array_'_update (λ_. Arrays.update ´array (unat free_head) ´temp)));;
  creturn global_exn_var_'_update ret__char_'_update (λs. SCAST(32 signed → 8) 1);;
  Guard DontReach {} SKIP
CATCH SKIP
END
```
