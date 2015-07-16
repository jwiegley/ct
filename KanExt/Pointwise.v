Require Import Category.Main.
Require Import Functor.Functor Functor.Functor_Ops
        Functor.Representable.Hom_Func
        Functor.Representable.Representable.
Require Import Ext_Cons.Prod_Cat.Prod_Cat Ext_Cons.Prod_Cat.Operations.
Require Import Coq_Cats.Type_Cat.Type_Cat.
Require Import NatTrans.NatTrans NatTrans.Operations NatTrans.Func_Cat.
Require Import KanExt.Local.

(** A local kan extension is pointwise if it is preserved by representable functors.
In other words, in the following diagram,

#
<pre>
           F            G
     C ———————–> D ——————–> Set
     |          ↗          ↗
     |        /          /
   p |      / R       /
     |    /        /   G ∘ R
     ↓  /       /
     C' ———–———
</pre>
#
where R is the left/right local kan extension of F along p, and G is a representable
functor and we have (G ∘ R) is the left/right kan extension of (G ∘ F) along p.
 *)

(** Pointwise-ness for local left kan extensions. *)
Section Pointwise_LRKE.
  Context {C C' : Category}
          {p : Functor C C'}
          {D: Category}
          {F : Functor C D}
          (lrke : Local_Right_KanExt p F)
  .

  Definition Pointwise_LRKE :=
    ∀ (G : Functor D Type_Cat) (GR : Representable G),
    is_Local_Right_KanExt p (G ∘ F) (G ∘ lrke)
  .
  
End Pointwise_LRKE.

(** Pointwiseness for local right kan extensions. *)
Section Pointwise_LLKE.
  Context {C C' : Category}
          {p : Functor C C'}
          {D: Category}
          {F : Functor C D}
          (llke : Local_Left_KanExt p F)
  .
  
  Definition Pointwise_LLKE :=
    ∀ (G : Functor D^op Type_Cat) (GR : CoRepresentable G),
    is_Local_Right_KanExt p (G^op ∘ F) (G ∘ llke)^op
  .
  
End Pointwise_LLKE.