# Log with timestamp

## Errata in RWO

The `Time.to_sec_string` function now also takes a `zone:Core.Zone.t`
argument which was added since the book was written. I use the
`Core.Zone.of_string zone_name` function to get the zone. to use UTC
zone, one could simply use `Core.Zone.utc`

## Referring to functions in other modules

You don't need to open or import anything. Just use
ModuleName.function_name in the other file.

## Merlin

Merlin doesn't seem to recognize functions defined in other modules
unless the .cmo file for it has already been generated. In this
commit, I have also added a .merlin file to help merlin locate the
compiled/source files in the project.

## Building

`corebuild` simplifies the build process. For now, just corebuild
${path_to_main}.native builds a native binary.
