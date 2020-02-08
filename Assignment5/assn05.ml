(* Prabhat Bhootra *)
(* Assignment 5 CPSC 316 *)

(* definition of cycle() *)

fun cycle(L, 0) = L
|	cycle([], i) = (nil : int list)
|	cycle (L, i) =	if i = 1 then tl L @ [hd L]
			else cycle((tl L) @ [hd L], i-1);
 
(* testing cycle() *)

cycle([], 0);
cycle([], 5);
cycle([1,2,3,4], 1);
cycle([1,2,3,4], 3);

(* definition of dup() *)

fun dup [] = (nil : int list)
|	dup L = [hd L] @ [hd L] @ dup(tl L);

(* testing dup() *)

dup([]);
dup([4]);
dup([1,2,3]);

(* definition of removei() *)

fun removei([], 0) = (nil : int list)
|	removei(L, 0) = L
| 	removei(L, i) = if i > length L then L
		        else List.take (L, i-1) @ List.drop(L, i);

(* testing removei() *)

removei([], 0);
removei([], 5);
removei([1,2], 0);
removei([1,2], 2);
removei([1,2,3,4,5], 4);

(* definition of dot() *)

fun dot(L1, L2) = if length L1 = 0 andalso length L2 = 0 then 0.0
                  else (hd L1 * hd L2) + dot(tl L1, tl L2);

(* testing dot() *)

dot([1.0, 2.0, 3.0], [4.0, 5.0, 6.0]);

(* definition of istri *)

fun istri(A : real, B : real, C : real) = if (A + B > C orelse B + C > A orelse A + C > B) andalso (A > 0.0 andalso B > 0.0 andalso C > 0.0) then true
		     			  else false;

(* testing istri() *)

istri(7.0, ~1.0, 4.0);
istri(0.0, 1.0, 2.0);
istri(5.0, 5.0, 1.0);
