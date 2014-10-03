(**
  This file contains the basic definition of a natrual transformation. It defines their equality, composition and identity natrual transformation. It furthermore, constructs the category "Func_Cat" whose objects are functors and arrows are natrual transformations.

*)

Require Import Category.Core.
Require Import Functor.Core.

Class NatTrans `{C : Category Obj} `{C' : Category Obj' Hom'} (F F' : Functor C C') :=
{
  Trans (c : Obj) : Hom' (F _o c) (F' _o c);
  Trans_com {c c' : Obj} (h : Hom c c') : (Trans c') ∘ F _a _ _ h = F' _a _ _ h ∘ (Trans c)
}.

Arguments Trans {_ _ _ _ _ _} [_ _] _ _.

(* NatTrans_Setoid defined *)

Lemma NatTrans_eq_simplify `{C : Category Obj Hom} `{C' : Category Obj' Hom'} {F F' : Functor C C'} (N N' : NatTrans F F') : (@Trans _ _ _ _ _ _ _ _ N) = (@Trans _ _ _ _ _ _ _ _ N') -> N = N'.
Proof.
  intros H1.
  destruct N as [NT NC]; destruct N' as [NT' NC']; simpl in *.
  destruct H1.
  destruct (proof_irrelevance _ NC NC').
  trivial.
Qed.

Program Instance NatTrans_compose `{C : Category Obj Hom} `{C' : Category Obj' Hom'} {F F' F'' : Functor C C'} (tr : NatTrans F F') (tr' : NatTrans F' F'') : NatTrans F F'' :=
{
  Trans := fun c : Obj => (Trans tr' c) ∘ (Trans tr c)
}.

Next Obligation. (* Trans_com*)
Proof.
  rewrite assoc.
  destruct tr as [trt trc]; destruct tr' as [trt' trc'].
  unfold Trans.
  assert(H := trc _ _ h).
  rewrite H.
  match goal with [|- ?A ∘ ?B ∘ ?C = ?D] => reveal_comp A B end.
  assert (H' := trc' _ _ h).
  rewrite H'.
  rewrite assoc.
  trivial.
Qed.

(* NatTrans_compose defined *)

Theorem NatTrans_compose_assoc `{C : Category Obj Hom} `{C' : Category Obj' Hom'} {F1 F2 F3 F4 : Functor C C'} (trf : NatTrans F1 F2) (trg : NatTrans F2 F3) (trh : NatTrans F3 F4) : (NatTrans_compose trf (NatTrans_compose trg trh)) = (NatTrans_compose (NatTrans_compose trf trg) trh).
Proof.
  apply NatTrans_eq_simplify; simpl.
  extensionality x.
  rewrite assoc; trivial.
Qed.

Program Instance NatTrans_id `{C : Category Obj Hom} `{C' : Category Obj'} {F : Functor C C'} : NatTrans F F :=
{
  Trans := fun x : Obj => F _a _ _ id
}.

(* NatTrans_id defined *)

Theorem NatTrans_id_unit_left `{C : Category Obj Hom} `{C' : Category Obj'} {F F' : Functor C C'} (tr : NatTrans F F') : (NatTrans_compose tr NatTrans_id) = tr.
Proof.
  apply NatTrans_eq_simplify; simpl.
  extensionality x; auto.
Qed.

Theorem NatTrans_id_unit_right `{C : Category Obj Hom} `{C' : Category Obj'} {F F' : Functor C C'} (tr : NatTrans F F') : (NatTrans_compose NatTrans_id tr) = tr.
Proof.
  apply NatTrans_eq_simplify; simpl.
  extensionality x; auto.
Qed.

Instance Func_Cat `(C : Category Obj) `(C' : Category Obj') : Category (Functor C C') (λ F G, NatTrans F G) :=
{
  compose := @NatTrans_compose _ _ _ _ _ _;

  assoc := @NatTrans_compose_assoc _ _ _ _ _ _;

  assoc_sym := fun _ _ _ _ _ _ _ => eq_sym (@NatTrans_compose_assoc _ _ _ _ _ _ _ _ _ _ _ _ _);

  id := @NatTrans_id _ _ _ _ _ _;

  id_unit_left := @NatTrans_id_unit_left _ _ _ _ _ _;

  id_unit_right := @NatTrans_id_unit_right _ _ _ _ _ _
               
}.

Theorem NatIso `{C : Category Obj} `{C' : Category Obj'} (F G : Functor C C') (n : NatTrans F G) (n' : NatTrans G F) : (∀ (c : Obj), (Trans n c) ∘ (Trans n' c) = G _a _ _ (@id _ _ _ c)) -> (∀ (c : Obj), (Trans n' c) ∘ (Trans n c) = F _a _ _ (@id _ _ _ c))  -> F ≡ G.
Proof.
  intros H1 H2.
  exists n; exists n'; apply NatTrans_eq_simplify; extensionality c; simpl; auto.
Qed.















