# Changelog for path-like

## (v0.1.0.0)

* Add `FileLike` and `DirLike` type class for using stricter types as `Path b File` and `Path b Dir` respectively.
* Add `(/>)` combinator for producing a `Path` from a `DirLike` and a `FileLike Rel`.
