Require Import
  MathClasses.interfaces.rationals MathClasses.interfaces.integers
  MathClasses.interfaces.abstract_algebra MathClasses.theory.rationals.
Require Export
  MathClasses.implementations.field_of_fractions.

Section intfrac_rationals.
  Context `{Integers Z}.

  Global Instance: RationalsToFrac (Frac Z) := alt_to_frac id.
  Global Instance: Rationals (Frac Z) := alt_Build_Rationals id (cast Z (Frac Z)).
End intfrac_rationals.
