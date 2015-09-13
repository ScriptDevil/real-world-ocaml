open Core.Std;;

print_string (TimestampLogger.log_with_timestamp None "hello");
print_string (TimestampLogger.log_with_timestamp (Some Time.epoch) "goodbye");
