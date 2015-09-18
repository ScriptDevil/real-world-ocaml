open Core.Std

include List

let rec intersperse list el =
  match list with
  | [] | [ _ ] -> list
  | x :: y :: rest -> x :: el :: intersperse (y::rest) el;;


                        
