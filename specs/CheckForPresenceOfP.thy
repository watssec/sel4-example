CheckForPresenceOfP_body ≡
TRY
  Guard ArrayBounds ⦃used_head <s 0x1388⦄ (Guard ArrayBounds ⦃0 ≤s used_head⦄ (´temp :== ´array.[unat used_head]));;
  Guard ArrayBounds ⦃´temp <s 0x1388⦄
   (Guard ArrayBounds ⦃0 ≤s ´temp⦄
     (WHILE ´array.[unat ´temp] ≠ 0 DO
        Guard ArrayBounds ⦃´temp <s 0x1388⦄
         (Guard ArrayBounds ⦃0 ≤s ´temp⦄ (IF ´array.[unat ´temp] = ´userp___int THEN
                                             CALL PwasFound_'proc(´temp);;
                                             creturn global_exn_var_'_update ret__char_'_update (λs. SCAST(32 signed → 8) 1)
                                           FI));;
        Guard SignedArithmetic ⦃- 2147483648 ≤ sint ´temp + sint 2 ∧ sint ´temp + sint 2 ≤ 2147483647⦄ (´temp :== ´temp + 2);;
        Guard ArrayBounds ⦃´temp <s 0x1388⦄ (Guard ArrayBounds ⦃0 ≤s ´temp⦄ (´temp :== ´array.[unat ´temp]));;
        Guard ArrayBounds ⦃´temp <s 0x1388⦄ (Guard ArrayBounds ⦃0 ≤s ´temp⦄ SKIP)
      OD));;
  CALL EndOfUsedListFound_'proc(´temp,´userp___int,´users___int);;
  creturn global_exn_var_'_update ret__char_'_update (λs. SCAST(32 signed → 8) 1);;
  Guard DontReach {} SKIP
CATCH SKIP
END