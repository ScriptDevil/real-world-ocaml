let plus_one_match x =
  match x with
  | 0 -> 1
  | 1 -> 2
  | 2 -> 3
  | _ -> x + 1

let plus_one_if x =
  if x = 0 then 1
  else if x = 1 then 2
  else if x = 2 then 3
  else x + 1;;

open Core.Std;;
open Core_bench.Std;;

let run_bench = Command.run(Bench.make_command [
      Bench.Test.create ~name:"plus_one_match" (fun () ->
          ignore (plus_one_match 10));
      Bench.Test.create ~name:"plus_one_if" (fun () ->
          ignore (plus_one_if 10)) ]);;
        
let () = run_bench;;
