main_body ≡
TRY
  ´i :== 0;;
  WHILE ´i <s 0x1388 DO
    Guard ArrayBounds ⦃´i <s 0x1388⦄
     (Guard ArrayBounds ⦃0 ≤s ´i⦄ (´globals :== array_'_update (λ_. Arrays.update ´array (unat ´i) 0)));;
    Guard SignedArithmetic ⦃- 2147483648 ≤ sint ´i + sint 1 ∧ sint ´i + sint 1 ≤ 2147483647⦄ (´i :== ´i + 1)
  OD;;
  ´curr_pointer :== free_head;;
  ´curr_element :== free_head;;
  Guard SignedArithmetic ⦃- 2147483648 ≤ sint ´curr_element + sint 3 ∧ sint ´curr_element + sint 3 ≤ 2147483647⦄
   (´curr_element :== ´curr_element + 3);;
  Guard SignedArithmetic ⦃- 2147483648 ≤ sint ´curr_pointer + sint 2 ∧ sint ´curr_pointer + sint 2 ≤ 2147483647⦄
   (´curr_pointer :== ´curr_pointer + 2);;
  Guard ArrayBounds ⦃´curr_pointer <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s ´curr_pointer⦄
     (´globals :== array_'_update (λ_. Arrays.update ´array (unat ´curr_pointer) ´curr_element)));;
  Guard SignedArithmetic ⦃- 2147483648 ≤ sint (0x1388 * 3) + sint 7 ∧ sint (0x1388 * 3) + sint 7 ≤ 2147483647⦄
   (Guard SignedArithmetic ⦃- 2147483648 ≤ sint 0x1388 * sint 3 ∧ sint 0x1388 * sint 3 ≤ 2147483647⦄
     (WHILE ´curr_element <s 0x1388 * 3 + 7 DO
        Guard SignedArithmetic ⦃- 2147483648 ≤ sint ´curr_element + sint 3 ∧ sint ´curr_element + sint 3 ≤ 2147483647⦄
         (´curr_element :== ´curr_element + 3);;
        Guard SignedArithmetic ⦃- 2147483648 ≤ sint ´curr_pointer + sint 2 ∧ sint ´curr_pointer + sint 2 ≤ 2147483647⦄
         (´curr_pointer :== ´curr_pointer + 2);;
        Guard ArrayBounds ⦃´curr_pointer <s 0x1388⦄
         (Guard ArrayBounds ⦃0 ≤s ´curr_pointer⦄
           (´globals :== array_'_update (λ_. Arrays.update ´array (unat ´curr_pointer) ´curr_element)));;
        Guard SignedArithmetic ⦃- 2147483648 ≤ sint (0x1388 * 3) + sint 7 ∧ sint (0x1388 * 3) + sint 7 ≤ 2147483647⦄
         (Guard SignedArithmetic ⦃- 2147483648 ≤ sint 0x1388 * sint 3 ∧ sint 0x1388 * sint 3 ≤ 2147483647⦄ SKIP)
      OD));;
  Guard ArrayBounds ⦃´curr_element <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s ´curr_element⦄ (´globals :== array_'_update (λ_. Arrays.update ´array (unat ´curr_element) 0)));;
  Guard ArrayBounds ⦃free_head <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s free_head⦄
     (Guard SignedArithmetic ⦃- 2147483648 ≤ sint used_head + sint 1 ∧ sint used_head + sint 1 ≤ 2147483647⦄
       (´globals :== array_'_update (λ_. Arrays.update ´array (unat free_head) (used_head + 1)))));;
  WHILE 1 ≠ 0 DO
    TRY
      ´userp :== SCAST(32 signed → 32 signed) p_placeholder;;
      ´users :== SCAST(32 signed → 32 signed) s_placeholder;;
      ´result :== CALL CheckForNullSecret_'proc(´userp,´users);;
      IF UCAST(8 → 32 signed) ´result = 0 THEN
        ´global_exn_var :== Continue;;
        THROW
      FI;;
      CALL CheckForPresenceOfP_'proc(SCAST(32 signed → 32 signed) ´userp,SCAST(32 signed → 32 signed) ´users)
    CATCH IF ´global_exn_var = Continue THEN
            SKIP
          ELSE
            THROW
          FI
    END
  OD;;
  creturn global_exn_var_'_update ret__int_'_update (λs. 1);;
  Guard DontReach {} SKIP
CATCH SKIP
END