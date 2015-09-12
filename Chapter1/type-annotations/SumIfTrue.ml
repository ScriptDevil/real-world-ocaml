let sum_if_true test first second =
  (if test first
   then first
   else 0)
  +
  (if test second
   then second
   else 0)
