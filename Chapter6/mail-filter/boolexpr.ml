open Core.Std

type 'a expr =
  | Base of 'a
  | Const of bool
  | And of 'a expr list
  | Or of 'a expr list
  | Not of 'a expr

type mail_field = To | From | CC | Date | Subject

type mail_predicate = { field: mail_field;
                        contains: string }

let test field contains = Base { field; contains }

let sample_expressin = And [ Or [ test To "foo"; test CC "bar" ];
                             test Subject "runtime"
                           ]

let rec eval expr base_evaluator =
  let eval' expr = eval expr base_evaluator in
  match expr with
  | Base b -> base_evaluator b
  | Const b -> b
  | And l -> List.for_all ~f:eval' l
  | Or l  -> List.exists  ~f:eval' l
  | Not e -> not (eval' expr)

(* Simplifiers *)
let and_ l =
  if List.mem l (Const false)
  then Const false
  else
    match List.filter l ~f:((<>) (Const true)) with
    | [] -> Const true
    | [ x ] -> x
    | l -> And l

let or_ l =
  if List.mem l (Const true)
  then Const true
  else
    match List.filter l ~f:((<>) (Const false)) with
    | [] -> Const false
    | [ x ] -> x
    | l -> Or l

let not_ = function
  | Const b -> Const (not b)
  | Not e -> e
  | e -> Not e

let rec simplify = function
  | Base _ | Const _ as x -> x
  | And l -> and_ (List.map ~f:simplify l)
  | Or l -> or_ (List.map ~f:simplify l)
  | Not e -> not_ (simplify e)


               
