EndOfUsedListFound_body ≡
TRY
  Guard ArrayBounds ⦃free_head <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s free_head⦄ (IF ´array.[unat free_head] = 0 THEN
                                           creturn global_exn_var_'_update ret__char_'_update (λs. SCAST(32 signed → 8) 0)
                                         FI));;
  Guard ArrayBounds ⦃free_head <s 0x1388⦄ (Guard ArrayBounds ⦃0 ≤s free_head⦄ (´temp_var_new :== ´array.[unat free_head]));;
  Guard ArrayBounds ⦃´temp_var_new <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s ´temp_var_new⦄
     (´globals :== array_'_update (λ_. Arrays.update ´array (unat ´temp_var_new) ´userp___int)));;
  Guard ArrayBounds ⦃´temp_var_new + 1 <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s ´temp_var_new + 1⦄
     (Guard SignedArithmetic ⦃- 2147483648 ≤ sint ´temp_var_new + sint 1 ∧ sint ´temp_var_new + sint 1 ≤ 2147483647⦄
       (´globals :== array_'_update (λ_. Arrays.update ´array (unat (´temp_var_new + 1)) ´users___int))));;
  Guard ArrayBounds ⦃used_head <s 0x1388⦄ (Guard ArrayBounds ⦃0 ≤s used_head⦄ (´temp_var_used :== ´array.[unat used_head]));;
  Guard ArrayBounds ⦃used_head <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s used_head⦄ (´globals :== array_'_update (λ_. Arrays.update ´array (unat used_head) ´temp_var_new)));;
  Guard ArrayBounds ⦃´temp_var_new + 2 <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s ´temp_var_new + 2⦄
     (Guard SignedArithmetic ⦃- 2147483648 ≤ sint ´temp_var_new + sint 2 ∧ sint ´temp_var_new + sint 2 ≤ 2147483647⦄
       (´temp_var_new :== ´array.[unat (´temp_var_new + 2)])));;
  Guard ArrayBounds ⦃´temp_var_new + 2 <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s ´temp_var_new + 2⦄
     (Guard SignedArithmetic ⦃- 2147483648 ≤ sint ´temp_var_new + sint 2 ∧ sint ´temp_var_new + sint 2 ≤ 2147483647⦄
       (´globals :== array_'_update (λ_. Arrays.update ´array (unat (´temp_var_new + 2)) ´temp_var_used))));;
  Guard ArrayBounds ⦃free_head <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s free_head⦄ (´globals :== array_'_update (λ_. Arrays.update ´array (unat free_head) ´temp_var_new)));;
  creturn global_exn_var_'_update ret__char_'_update (λs. SCAST(32 signed → 8) 1);;
  Guard DontReach {} SKIP
CATCH SKIP
END