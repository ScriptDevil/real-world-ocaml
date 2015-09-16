(* Any non-function binding in the top level will be executed. Nothing
is holy about the 

let () = ...;; 

pattern. The following is as good as a main and will print Hello on
the screen. *)

let a = print_string "Hello\n"; 3;;

(* As is this, even though OCaml will complain of non-exhaustive
patterns *)

let 3 = print_string "Goodbye\n"; 3;;
