namespace Peano
  inductive ℕ where
    | Z : ℕ
    | S : ℕ -> ℕ
    deriving Repr

  def prettyPrint (x : ℕ) : Nat :=
    match x with
    | ℕ.Z => 00
    | ℕ.S x' => 1 + prettyPrint x'
end Peano

open Peano

def ℕ.add (a b : ℕ) : ℕ :=
  match a with
  | ℕ.Z => b
  | ℕ.S a' => ℕ.S (add a' b)

def ℕ.mult (α β : ℕ) : ℕ :=
  match α with
  | ℕ.Z => ℕ.Z
  | ℕ.S α' => ℕ.add β (mult α' β)

def ℕ.minus (α β : ℕ) : ℕ :=
  match α, β with
  | ℕ.Z, _ => ℕ.Z
  | ℕ.S _, ℕ.Z => α
  | ℕ.S α', ℕ.S β' => minus α' β'

def zero := ℕ.Z
def one  := ℕ.S ℕ.Z
def two  := ℕ.add one one
def three := ℕ.add two one

#eval prettyPrint (ℕ.mult two two)
#eval prettyPrint (ℕ.minus two one)
