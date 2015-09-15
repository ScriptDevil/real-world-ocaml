open Core.Std;;

let max_widths headers table =
  let lengths row = List.map ~f:String.length row in
  List.fold table ~init:(lengths headers)
    ~f:(fun acc row -> List.map2_exn acc (lengths row) ~f:Int.max)
;;

let headers =  ["language";"architect";"first release"];;
let body =  [ ["Lisp" ;"John McCarthy" ;"1958"] ;
              ["C"    ;"Dennis Ritchie";"1969"] ;
              ["ML"   ;"Robin Milner"  ;"1973"] ;
              ["OCaml";"Xavier Leroy"  ;"1996"] ;
            ];;


let pad s length = " " ^ s ^ (String.make (length - String.length s + 1) ' ') ;;

let render_separators widths =
  let bits = List.map ~f:(fun w -> String.make (w+2) '-') widths in
  "|" ^ String.concat ~sep:"+" bits ^ "|";;

let render_row row w =  "|" ^ (String.concat ~sep:"|" (List.map2_exn ~f:pad row w)) ^ "|"

let render_table headers table =
  let w = max_widths headers table in
  render_row headers w
  :: render_separators w 
  :: List.map ~f:(fun row -> render_row row w) table |> String.concat ~sep:"\n";;

let () = render_table headers body |> print_endline;;
