(* Coq是一个辅助定理证明工具，本身也是个函数式编程语言 *)

零.基础
0.数据&函数
(* define a Type using Inductive *)
Inductive color : Type :=
  | red
  | blue
  | green
  | yellow.   (* 无参构造子，则为字面字符串本身 *)

(* Compute a Type returns it's type, here is Set *)
Compute color.

(* define a Function using Definition *)*
Definition opposite_color (c: color) : color :=
  match c with
  | red  => blue
  | blue => green
  | green => yellow
  | yellow => red
  end.

(* Compute a Function just calls it and returns retval *)
Compute (opposite_color green).

(* define a named Assertion using Example *)
Example test_opposite_color:
  (opposite_color (opposite_color (opposite_color green))) = blue.
Proof.
  simpl.
  reflexivity.
Qed.


Definition mix (c1: color) (c2: color) : color :=
  match c1, c2 with
  | red, blue => green
  end.

(* define interfix notation for binary Function *)
Notation "x | y" := (mix x y).

Example test_mix:
  red | blue | green = black.
Proof.
  simpl.
  reflexivity.
Qed.

(* Check an atomic returns its Type *)
Check red.
(* Check a Function call returns its retval Type *)
Check (opposite_color red).
(* Check a Function returns its Types in signature *)
Check opposite_color.

1.含参构造子
Inductive rgb : Type :=
  | red
  | green
  | blue.

Inductive color : Type :=
  | black
  | white
  | primary (p : rgb).

Definition monochrome (c : color) : bool :=
  match c with
  | black => true
  | white => true
  | primary q => false
  end.

Definition isred (c : color) : bool :=
  match c with
  | black => false
  | white => false
  | primary red => true
  | primary _ => false
  end.

2.Tuple
Inductive bit : Type :=
  | B0
  | B1.

Inductive nybble : Type :=		(* 类型名称：nybble *)
  | bits (b0 b1 b2 b3 : bit).   (* 构造器名称：bits *)

Check (bits B1 B0 B1 B0).
(* ==> bits B1 B0 B1 B0 : nybble *)

Definition all_zero (nb : nybble) : bool :=
  match nb with
    | (bits B0 B0 B0 B0) => true
    | (bits _ _ _ _) => false  (* wildcard *)

3.模块
Module NatPlayground.

Inductive nat : Type :=
  | O
  | S (n : nat).

Definition pred (n : nat) : nat :=
  match n with
    | O => O
    | S n' => n'
  end.

Definition succ (n : nat) : nat :=
  match n with
    | O => S O
    | S _ => S n
  end.

Definition minustwo (n : nat) : nat :=
  pred (pred n).

(* recursive Function is defined using Fixpoint *)
Fixpoint evenb (n:nat) : bool :=
  match n with
  | O        => true
  | S O      => false
  | S (S n') => evenb n'
  end.

Fixpoint minus (n m:nat) : nat :=
  match n, m with
  | O   , _    => O
  | S _ , O    => n
  | S n', S m' => minus n' m'
  end.

(* params with same Type could be marged up *)
Fixpoint exp (base power : nat) : nat :=
  match power with
    | O => S O
    | S p => mult base (exp base p)
  end.


Fixpoint plus (n : nat) (m : nat) : nat :=
  match n with
    | O => m
    | S n' => S (plus n' m)
  end.

Fixpoint mult (n m : nat) : nat :=
  match n with
    | O => O
    | S n' => plus m (mult n' m)
  end.

Fixpoint eqb (n m : nat) : bool :=
  match n with
  | O => match m with
         | O => true
         | S m' => false
         end
  | S n' => match m with
            | O => false
            | S m' => eqb n' m'
            end
  end.

Fixpoint leb (n m : nat) : bool :=
  match n with
  | O => true
  | S n' =>
      match m with
      | O => false
      | S m' => leb n' m'
      end
  end.

End NatPlayground.


一.证明
0.化简证明
(* start a idea using Theorem/Example/Lemma/Fact/Remark *)
Theorem plus_O_n :
  forall n : nat, 
    0 + n = n.
Proof.
  intros n.		(* evidence that we have, to feed that 'forall' *) 
  simpl.        (* to see intermediate state/results *)
  reflexivity.  (* automatically simplify and assert *)
Qed.

Theorem plus_id_example :
  forall n m:nat,
    n = m ->	(* -> means hypothesis, i.e. logical implication operator *)
      n + n = m + m.
Proof.
  (* move both quantifiers into the context: *)
  intros n m.
  (* move the hypothesis into the context: *)
  intros H.
  (* rewrite the goal using the hypothesis: *)
  rewrite -> H.
  reflexivity.
Qed.

1.分情况讨论证明
