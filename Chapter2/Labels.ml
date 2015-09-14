let g ~x ~y = x + y;;

(* Very similar looking functions. Notice the swap in labels *)
let add_with_adder g y x = g ~x:y ~y:x;; 
(* -- val add_with_adder : (x:'a -> y:'b -> 'c) -> 'a -> 'b -> 'c = <fun> *)

let add_with_adder_2 g y x = g ~y:x ~x:y;;
(* val add_with_adder_2 : (y:'a -> x:'b -> 'c) -> 'b -> 'a -> 'c = <fun> *)


(* Now, g is a good candidate for add_with_adder but not for add_with_adder_2 *)

add_with_adder g 3 4;; (* Passes *)

(* add_with_adder_2 g 3 4;;  *)(* Fails:

Characters 17-18:
  add_with_adder_2 g 3 4;;
                   ^
Error: This expression has type x:int -> y:int -> int
       but an expression was expected of type y:'a -> x:'b -> 'c
*)


(* The best explanation I have read for this is that labels get erased
   in run-time and in a higher-order function, it is hard to keep
   track of the variable name so things resort to the order in which
   the arguments are passed *)

add_with_adder_2 (fun ~y ~x -> g ~y ~x) 3 4;; (* Passes:
Note the label punning in action here. This anon function is the same as:

fun ~y ~x -> g ~y:y ~x:x;; where y has the signature:

(y:int -> x:int -> int) which matches the requirement.

 *)

(* The following definition fails as expected: *)
(* let add_with_adder g y x = (g ~y:y ~x:x) + (g ~x:x ~y:y);; *)
(* Fails:
   let add_with_adder g y x = (g ~y:y ~x:x) + (g ~x:x ~y:y);;
                                               
Error: This function is applied to arguments
in an order different from other calls.
This is only allowed when the real type is known. *)
