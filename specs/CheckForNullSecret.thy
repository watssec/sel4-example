CheckForNullSecret_body ≡ TRY
                             IF ´userp = SCAST(32 signed → 32 signed) 0x30 ∨ ´users = SCAST(32 signed → 32 signed) 0x30 THEN
                               creturn global_exn_var_'_update ret__char_'_update (λs. SCAST(32 signed → 8) 0)
                             ELSE
                               creturn global_exn_var_'_update ret__char_'_update (λs. SCAST(32 signed → 8) 1)
                             FI;;
                             Guard DontReach {} SKIP
                           CATCH SKIP
                           END