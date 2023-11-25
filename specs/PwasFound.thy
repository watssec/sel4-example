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