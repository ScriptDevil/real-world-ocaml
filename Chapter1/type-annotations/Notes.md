# Type annotations in OCaml

While one can annotate a function by annotating its arguments with
types in-place in OCaml, there wasn't a way to cleanly have a separate
line with type-annotations.

From a quick search online, I figured that one way you could do this
was by placing a separate .mli file in the same directory as the .ml
file with the same name as the .ml file (caveat: the file name should
be a valid module name).

What is interesting is that if there is no .mli file with the same
name, ocamlc happily goes ahead and compiles the .ml file. It
autogenerates both a .cmo and a .cmi file for the module. However, if
a .mli file of the same name exists and it hasn't been compiled yet,
ocamlc on the ml file complains that it couldn't find the .cmi file
corresponding to the .mli file.

Further still, I have verified that if I changed the type signature to
something else in the .mli file, ocamlc quite correctly throws a type
error saying the implementation does not match the interface
