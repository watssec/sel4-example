theory example
imports "HOL-Library.Monad_Syntax"
begin

text ‹ The nondeterministic state monad with failure ›

type_synonym ('s,'a) nondet_monad = "'s ⇒ (('a × 's) set × bool)"

definition
  return :: "'a ⇒ ('s,'a) nondet_monad"
where
  "return x ≡ λs. ({(x,s)},False)"

definition
  bind :: "('s,'a) nondet_monad ⇒ ('a ⇒ ('s,'b) nondet_monad) ⇒ ('s,'b) nondet_monad"
where
  "bind a b ≡ λs. ({(r'',s''). ∃ (r',s') ∈ fst (a s). (r'',s'') ∈ fst (b r' s')},
                     snd (a s) ∨ (∃(r', s') ∈ fst (a s). snd (b r' s')))" 

(* Use standard monad syntax for our new "bind" *)
adhoc_overloading
  Monad_Syntax.bind bind 

(* Always use do-notation *)
translations
  "CONST bind_do" == "CONST Monad_Syntax.bind"  

  
lemma
  "return x >>= f = f x"
  apply(unfold bind_def return_def)
  apply simp
  done

lemma
  "m >>= return = m"
  apply(rule ext)
  apply(simp add: bind_def return_def)
  apply(rule prod_eqI)
  apply auto
  done
 
lemma
  "(a >>= b) >>= c = (a >>= (λs. b s >>= c) :: ('s,'a) nondet_monad)"
  apply(rule ext)
  apply(fastforce simp: bind_def split: prod.splits)
  done

definition
  get :: "('s,'s) nondet_monad"
where
  "get ≡ λs. ({(s,s)},False)"

definition
  put :: "'s ⇒ ('s,unit) nondet_monad"
where
  "put s ≡ λ_. ({((),s)},False)"

definition
  gets :: "('s ⇒ 'a) ⇒ ('s,'a) nondet_monad"
where
  "gets f ≡ get >>= (λs. return (f s))"

definition
  modify :: "('s ⇒ 's) ⇒ ('s,unit) nondet_monad"
where
  "modify f ≡ get >>= (λs. put (f s))"

definition
  fail :: "('s,'a) nondet_monad"
where
  "fail ≡ λ_. ({},True)"

definition
  assert :: "bool ⇒ ('s,unit) nondet_monad"
where
  "assert P ≡ if P then return () else fail"

definition
  guard :: "('s ⇒ bool) ⇒ ('s,unit) nondet_monad"
where
  "guard P ≡ get >>= (λs. assert (P s))"

definition
  select :: "'a set ⇒ ('s,'a) nondet_monad"
where
  "select A ≡ λs. ((A × {s}),False)"

definition 
  alternative :: "('s,'a) nondet_monad ⇒ ('s,'a) nondet_monad ⇒ ('s,'a) nondet_monad"
  (infixl "OR" 20)
where
  "alternative a b ≡ (λs. (fst (a s) ∪ (fst (b s)),snd (a s) ∨ snd (b s)))"


  

text ‹
  We use an abstract type for pointers. 
  Later we talk more about how to faithfully model pointers.
›
typedecl ptr

record state =
  hp :: "ptr ⇒ int"
  pvalid :: "ptr ⇒ bool"

definition
  func :: "ptr ⇒ (state,unit) nondet_monad"
where
  "func p ≡ do {
     y ← guard (λs. pvalid s p);
     x ← gets (λs. hp s p);
     if x < 10 then
       modify (hp_update (λh. (h(p := x + 1))))
     else
       return ()
   }" 

  
  

inductive_set
  whileLoop_results :: "('r ⇒ 's ⇒ bool) ⇒ ('r ⇒ ('s, 'r) nondet_monad) ⇒ ((('r × 's) option) × (('r × 's) option)) set"
  for C B
where
    "⟦ ¬ C r s ⟧ ⟹ (Some (r, s), Some (r, s)) ∈ whileLoop_results C B"
  | "⟦ C r s; snd (B r s) ⟧ ⟹ (Some (r, s), None) ∈ whileLoop_results C B"
  | "⟦ C r s; (r', s') ∈ fst (B r s); (Some (r', s'), z) ∈ whileLoop_results C B  ⟧
       ⟹ (Some (r, s), z) ∈ whileLoop_results C B"

inductive_cases whileLoop_results_cases_valid: "(Some x, Some y) ∈ whileLoop_results C B"
inductive_cases whileLoop_results_cases_fail: "(Some x, None) ∈ whileLoop_results C B"
inductive_simps whileLoop_results_simps: "(Some x, y) ∈ whileLoop_results C B"
inductive_simps whileLoop_results_simps_valid: "(Some x, Some y) ∈ whileLoop_results C B"
inductive_simps whileLoop_results_simps_start_fail [simp]: "(None, x) ∈ whileLoop_results C B"

inductive
  whileLoop_terminates :: "('r ⇒ 's ⇒ bool) ⇒ ('r ⇒ ('s, 'r) nondet_monad) ⇒ 'r ⇒ 's ⇒ bool"
  for C B
where
    "¬ C r s ⟹ whileLoop_terminates C B r s"
  | "⟦ C r s; ∀(r', s') ∈ fst (B r s). whileLoop_terminates C B r' s' ⟧
        ⟹ whileLoop_terminates C B r s"

inductive_cases whileLoop_terminates_cases: "whileLoop_terminates C B r s"
inductive_simps whileLoop_terminates_simps: "whileLoop_terminates C B r s"

definition
  "whileLoop C B ≡ (λr s.
     ({(r',s'). (Some (r, s), Some (r', s')) ∈ whileLoop_results C B},
        (Some (r, s), None) ∈ whileLoop_results C B ∨ (¬ whileLoop_terminates C B r s)))"

notation (output)
  whileLoop  ("(whileLoop (_)//  (_))" [1000, 1000] 1000)

consts 
  ptrAdd :: "ptr ⇒ nat ⇒ ptr"

term "whileLoop (λp s. hp s p = 0) (λp. return (ptrAdd p 1)) p"

definition
  valid :: "('s ⇒ bool) ⇒ ('s,'a) nondet_monad ⇒ ('a ⇒ 's ⇒ bool) ⇒ bool" 
  ("⦃_⦄/ _ /⦃_⦄")
where
  "⦃P⦄ f ⦃Q⦄ ≡ ∀s. P s ⟶ (∀(r,s') ∈ fst (f s). Q r s')"


lemma return_wp:
  "⦃P x⦄ return x ⦃P⦄"
  by(simp add: valid_def return_def)

lemma get_wp:
  "⦃λs. P s s⦄ get ⦃P⦄"
  by(simp add: valid_def get_def)

lemma gets_wp:
  "⦃λs. P (f s) s⦄ gets f ⦃P⦄"
  apply(simp add:valid_def split_def gets_def return_def get_def bind_def)
  done

lemma modify_wp:
  "⦃λs. P () (f s)⦄ modify f ⦃P⦄"
  apply(simp add:valid_def split_def modify_def get_def put_def bind_def)
  done

lemma put_wp:
  "⦃λs. P () x⦄ put x ⦃P⦄"
  apply(simp add:valid_def put_def)
  done

lemma hoare_weaken_pre:
  "⟦⦃Q⦄ a ⦃R⦄; ⋀s. P s ⟹ Q s⟧ ⟹ ⦃P⦄ a ⦃R⦄"
  apply(auto simp: valid_def)
  done
  
lemma fail_wp:  "⦃λ_. True⦄ fail ⦃Q⦄"
  apply(simp add: fail_def valid_def)
  done

lemma if_wp:
 "⟦ P ⟹ ⦃Q⦄ f ⦃S⦄; ¬P ⟹ ⦃R⦄ g ⦃S⦄ ⟧ ⟹
  ⦃λs. (P ⟶ Q s) ∧ (¬P ⟶ R s)⦄ if P then f else g ⦃S⦄"
  by simp

(* do this proof using wp rules above *)
lemma assert_wp: "⦃λs. P ⟶ Q () s⦄ assert P ⦃Q⦄"
  apply(unfold assert_def)
  apply(rule hoare_weaken_pre)
   apply(rule if_wp)
    apply(rule return_wp)
   apply(rule fail_wp)
  apply simp
  done
  
lemma bind_wp:
  "⟦ ⋀x. ⦃B x⦄ g x ⦃C⦄; ⦃A⦄ f ⦃B⦄ ⟧ ⟹
   ⦃A⦄ do { x ← f; g x } ⦃C⦄"
  apply(force simp: valid_def bind_def split: prod.splits)
  done

lemma select_wp: "⦃λs. ∀x ∈ S. Q x s⦄ select S ⦃Q⦄"
  by (simp add: select_def valid_def)

lemma guard_wp:
  "⦃λs. P s ⟶ Q () s⦄ guard P ⦃Q⦄"
  apply(simp add: guard_def)
  apply(rule hoare_weaken_pre)
   apply(rule bind_wp)
    apply(rule assert_wp)
   apply(rule get_wp)
  apply assumption
  done

lemma func_lemma:
  "⦃λs. hp s p ≥ 10 ∧ Q () s⦄ func p ⦃Q⦄"
  apply(unfold func_def)
  apply(rule bind_wp)
   apply(rule bind_wp)
    apply(rule if_wp)
     apply(rule modify_wp)
    apply(rule return_wp)
   apply(rule gets_wp)
  apply(rule hoare_weaken_pre)
   apply(rule guard_wp)
  apply simp
  done


definition "SIZE ≡ 5000 :: nat"
definition "free_head ≡ 5 :: nat"
definition "used_head ≡ 6 :: nat"
definition "my_list ≡  replicate SIZE 0 "

record PWasFoundState = 
  mylist :: "nat list ⇒ nat list"
  tempval :: "nat ⇒ nat"
fun update_list :: "nat ⇒ 'a ⇒ 'a list ⇒ 'a list" 
  where
  "update_list 0 x (y # ys) = x # ys" |
  "update_list (Suc i) x (y # ys) = y # (update_list i x ys)" |
  "update_list _ _ [] = []"

definition
  PWasFound :: "nat ⇒ (PWasFoundState, unit) nondet_monad"
where
  "PWasFound temp ≡ do {
     index_value ← gets (λs. tempval s temp);
     let temp_var = (my_list ! free_head);
     let new_list = update_list index_value free_head my_list;
     
modify (mylist_update (λs. s(my_list := new_list)))
   }"



end

