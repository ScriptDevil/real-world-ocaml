(* Understanding if optional functions can be passed to higher-order
   functions *)

let concat ?(sep="") x y = x ^ sep ^ y;;

let concat_with_itself concat_fn str = concat_fn ~sep:"" str str;;

(* concat_with_itself concat "foo";;  *) (*Fail: 

  concat_with_itself concat "foo";;
                     ^^^^^^
Error: This expression has type string -> string -> string
       but an expression was expected of type
         string -> string -> string -> 'a
       Type string is not compatible with type string -> 'a 
*)

(* I expected this! *)

let concat_with_itself_2 concat_fn str = concat_fn str str;;

(* This is fine, though!  *)
concat_with_itself_2 concat "foo";;
(* As is this: *)
concat_with_itself_2 (concat ~sep:"-") "foo";;
(* But not this *)
(* concat_with_itself_2 (concat "::") "foo";; *) (* Fail:
Error: This expression has type string -> string
       but an expression was expected of type string -> string -> 'a
       Type string is not compatible with type string -> 'a 
*)
