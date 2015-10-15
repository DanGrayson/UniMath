Require Export UniMath.Foundations.Algebra.Associativity.
Require Export UniMath.Foundations.FunctionalExtensionality.
Unset Automatic Introduction.
Local Notation "●" := (idpath _).
Local Notation "s □ x" := (append s x) (at level 65, left associativity).

Theorem commutativityOfProducts {M:abmonoid} {n} (x:stn n->M) (f:stn n ≃ stn n) :
  sequenceProduct (n,,x) = sequenceProduct (n,,x∘f).
Proof.
  intros.
  induction n as [|n IH].
  - reflexivity.
  - assert (specialcase : ∀ (y:stn _->M) (g : stn _ ≃ stn _), g (lastelement n) = lastelement n ->
        sequenceProduct (S n,, y) = sequenceProduct (S n,, y ∘ g)).
    { intros ? ? a. rewrite 2? sequenceProductStep. change ((_ ∘ _) _) with (y (g (lastelement n))).
      rewrite a. apply (maponpaths (λ m, m * _)). change (_ ∘ _ ∘ _) with (y ∘ (g ∘ dni_allButLast n)).
      set (h := eqweqmap (maponpaths (compl (stn (S n))) a)).
      assert (pr1_h : ∀ i, pr1 (pr1 (h i)) = pr1 (pr1 i)). { intros. induction a. reflexivity. }
      set (wc := weqdnicompl n (lastelement n)).
      set (g' := (wc⁻¹ ∘ (h ∘ (weqoncompl g (lastelement n) ∘ wc))) %weq).
      intermediate_path (sequenceProduct (n,, y ∘ dni_allButLast n ∘ g')).
      { apply IH. }
      { change ((_ ∘ _) ∘ _) with (y ∘ (dni_allButLast n ∘ g')).
        apply maponpaths; apply maponpaths; apply (maponpaths (λ g, _ ∘ g)).
        apply funextfun; intros i.
        change ((g ∘ _) _) with (g (dni_allButLast n i)). change ((_ ∘ g') _) with (dni_allButLast n (g' i)).
        apply isinjstntonat. rewrite pr1_dni_allButLast. unfold g'.
        rewrite 3? weqcomp_to_funcomp_app. rewrite inv_weqdnicompl_compute_last. rewrite pr1_h.
        rewrite weqoncompl_compute. apply maponpaths. apply maponpaths. apply isinjstntonat.
        unfold wc. rewrite weqdnicompl_compute_last. rewrite pr1_dni_allButLast. reflexivity. }}
    set (j := f (lastelement n)).
    induction j as [j jlt].
    assert (jle := natlthsntoleh _ _ jlt).
    Open Scope nat.
    set (m := nil □ j □ 1 □ n-j).
    assert (B : stnsum m = S n). 
    { unfold stnsum; simpl. rewrite natplusassoc. rewrite (natpluscomm 1). rewrite <- natplusassoc.
      rewrite natpluscomm. apply (maponpaths S). rewrite natpluscomm. now apply minusplusnmm. }                                 
    set (m' := nil □ j □ n-j □ 1).
    assert (B' : stnsum m' = S n). 
    { unfold stnsum; simpl. rewrite natplusassoc. rewrite (natpluscomm _ 1). rewrite <- natplusassoc. apply B. }
    set (w := weqstnsum_idweq m). rewrite B in w. change (pr1 m) with 3 in w.
    set (w' := weqstnsum_idweq m'). rewrite B' in w'. change (pr1 m') with 3 in w'.



(*
    induction (isdeceqstn (S n) (f (lastelement n)) (lastelement n)) as [p|p].
    + now apply specialcase.
    + 
*)

Abort.



    
    
    
    