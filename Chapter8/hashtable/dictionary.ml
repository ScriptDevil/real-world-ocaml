open Core.Std

(* This is my own implementation from what I remember from reading the
   book several hours ago. It is clearly dirty. *)

type ('a, 'b) t = {
  buckets: ('a * 'b) list array;
  mutable length: int;
}

let num_buckets = 17

let create () = {
    length = 0;
    buckets = Array.create ~len:num_buckets [];
  }

let length d = d.length

let add d ~key ~data =
  let bucket_number = Hashtbl.hash key mod num_buckets in
  let bucket = d.buckets.(bucket_number) in
  let new_list = match List.find bucket ~f:(fun (k,_) -> k = key) with
    | None -> d.length <- d.length + 1; (key,data)::bucket
    | Some (_,_) -> (key, data) :: (List.filter bucket ~f:(fun (k,_) -> k <> key)) in
  d.buckets.(bucket_number) <- new_list;
  d

let remove d ~key =
  let bucket_number = Hashtbl.hash key mod num_buckets in
  let bucket = d.buckets.(bucket_number) in
  d.buckets.(bucket_number) <- match List.find bucket ~f:(fun (k,_) -> k = key) with
    | None -> bucket
    | Some (_,_) -> d.length <- d.length - 1; List.filter bucket ~f:(fun (k,_) -> k <> key)

let find d ~key =
  let bucket_number = Hashtbl.hash key mod num_buckets in
  let bucket = d.buckets.(bucket_number) in
  match List.find bucket ~f:(fun (k,_) -> k = key) with
  | None -> None
  | Some (_,v) -> Some v

let iter d ~f =
  Array.iter d.buckets ~f:(fun l ->
      List.iter l ~f)
