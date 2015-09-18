open Core.Std
open Common

(*
 * This won't work
let () = List.iter ~f:(printf "%s\n") (List.intersperse ["a";"b";"c";"d"] ~sep:"SPC");;
 *)
(* But this would! *)
let () = List.iter ~f:(printf "%s\n") (List.intersperse ["a";"b";"c";"d"] "SPC");;
