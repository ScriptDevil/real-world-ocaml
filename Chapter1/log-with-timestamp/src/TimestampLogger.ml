open Core.Std

let log_with_timestamp maybe_time message =
  let timestamp = match maybe_time with
    | (Some t) -> t
    | None     -> Time.now ()
  in Time.to_sec_string ~zone:(Core.Zone.of_string "Asia/Kolkata") timestamp ^
     " -- " ^
     message ^
     "\n" 
;;


