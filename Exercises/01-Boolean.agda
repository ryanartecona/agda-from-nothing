{-# OPTIONS --exact-split #-}

module 01-Boolean where

-- Precedences

infixl 6 _or_ _xor_ _iff_
infixl 7 _and_
infixl 4 _≡_

-- Data Types

data Boolean : Set where
  false true : Boolean

data Unit : Set where
  unit : Unit

data Empty : Set where

data _≡_ (x : Boolean) : Boolean → Set where
  equal : x ≡ x

-- Practice for identity

identity : {X : Set} → X → X
identity {X} x = x

-- Functions

not : Boolean → Boolean
not false = true
not true = false

dblnot : Boolean → Boolean
dblnot false = not (not false)
dblnot true = not (not true)

_and_ : Boolean → Boolean → Boolean
false and _ = false
true and y = y

_or_ : Boolean → Boolean → Boolean
false or y = y
true or _ = true

_nand_ : Boolean → Boolean → Boolean
false nand y = true
true nand y = not y

_nor_ : Boolean → Boolean → Boolean
x nor y = (not x) and (not y)

_iff_ : Boolean → Boolean → Boolean
false iff false = true
false iff true = false
true iff false = false
true iff true = true

_xor_ : Boolean → Boolean → Boolean
false xor y = y
true xor y = not y

if_then_else_ : {X : Set} → Boolean → X → X → X
if false then _ else y = y
if true then x else _ = x

not′ : Boolean → Boolean
not′ b = if b then false else true

-- Sanity checks

not-true-eq-false : not true ≡ false
not-true-eq-false = equal

not-false-eq-true : not false ≡ true
not-false-eq-true = equal

true-and-true-eq-true : true and true ≡ true
true-and-true-eq-true = equal

false-or-false-eq-false : false or false ≡ false
false-or-false-eq-false = equal

if-true-then-false-eq-false : if true then false else true ≡ false
if-true-then-false-eq-false = equal

-- Trivial Properties

false-and-x-eq-false : (x : Boolean) → false and x ≡ false
false-and-x-eq-false _ = equal

true-or-x-eq-true : (x : Boolean) → true or x ≡ true
true-or-x-eq-true x = equal

-- Properties requiring proof

not-eq-not′ : (x : Boolean) → not x ≡ not′ x
not-eq-not′ false = equal -- Goal: not false ≡ not′ false
not-eq-not′ true = equal -- Goal: not true ≡ not′ true

x-and-false-eq-false : (x : Boolean) → x and false ≡ false
x-and-false-eq-false false = equal -- Goal: false and false ≡ false
x-and-false-eq-false true = equal -- Goal: true and false ≡ false

true-eq-true-or-x : (x : Boolean) → x or true ≡ true
true-eq-true-or-x false = equal
true-eq-true-or-x true = equal

nand-eq-not-and : (x y : Boolean) → x nand y ≡ not (x and y)
nand-eq-not-and false y = equal
nand-eq-not-and true y = equal

nor-eq-not-or : (x y : Boolean) → x nor y ≡ not (x or y)
nor-eq-not-or false y = equal
nor-eq-not-or true y = equal

xor-eq-not-iff : (x y : Boolean) → x xor y ≡ not (x iff y)
xor-eq-not-iff false false = equal
xor-eq-not-iff false true = equal
xor-eq-not-iff true false = equal
xor-eq-not-iff true true = equal

-- Properties using other proofs

iff-same-true : (x y : Boolean) → x ≡ y → x iff y ≡ true
iff-same-true false .false equal = equal
iff-same-true true .true equal = equal

xor-same-false : (x y : Boolean) → x ≡ y → x xor y ≡ false
xor-same-false false .false equal = equal
xor-same-false true .true equal = equal

-- Simple properties involving negation

true-and-true-not-false : true and true ≡ false → Empty
true-and-true-not-false ()

false-or-false-not-true : false or false ≡ true → Empty
false-or-false-not-true ()

false-and-x-not-true : (x : Boolean) → false and x ≡ true → Empty
false-and-x-not-true x ()

true-or-x-not-false : (x : Boolean) → true or x ≡ false → Empty
true-or-x-not-false x ()

x-and-false-not-true : (x : Boolean) → x and false ≡ true → Empty
x-and-false-not-true false ()
x-and-false-not-true true ()

x-or-true-not-false : (x : Boolean) → x or true ≡ false → Empty
x-or-true-not-false false ()
x-or-true-not-false true ()

-- Properties using other negations

empty-to-anything : {A : Set} → Empty → A
empty-to-anything ()

iff-different-false : (x y : Boolean) → (x ≡ y → Empty) → x iff y ≡ false
iff-different-false false false p = empty-to-anything (p equal)
iff-different-false false true p = equal
iff-different-false true false p = equal
iff-different-false true true p = empty-to-anything (p equal)

xor-different-true : (x y : Boolean) → (x ≡ y → Empty) → x xor y ≡ true
xor-different-true false false p = empty-to-anything (p equal)
xor-different-true false true p = equal
xor-different-true true false p = equal
xor-different-true true true p = empty-to-anything (p equal)
