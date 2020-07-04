# path-like - Type classes for the Path library.

This library exports two type classes `FileLike` and `DirLike` to allow you
build common interfaces for compiling down to `Path b File` and `Path b Dir`.
The only contract that should be respected is that your type should be at least
as strict as the `Path` type itself, i.e no String/FilePath instances. This is
the case with the [within](https://hackage.haskell.org/hackage/within) type.
