{-# LANGUAGE ConstraintKinds        #-}
{-# LANGUAGE FlexibleContexts       #-}
{-# LANGUAGE FlexibleInstances      #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses  #-}
{- |
   Module      : Path.Like
   Copyright   : Copyright (C) 2020 Daniel Firth
   Maintainer  : Daniel Firth <dan.firth@homotopic.tech>
   License     : MIT
   Stability   : experimental

Type classes for compiling down to well-typed `Path`s.
-}

module Path.Like (
  PathLike(..)
, FileLike
, DirLike
, toFile
, toDir
, (/>)
) where

import Path

-- | Class representing a type `a` that can be compiled down to a `Path b t`.
class PathLike b t a | a -> b, a -> t where
  toPath :: a -> Path b t

type FileLike b a = PathLike b File a
type DirLike b a = PathLike b Dir a

toFile :: FileLike b a => a -> Path b File
toFile = toPath

toDir :: DirLike b a  => a -> Path b Dir
toDir = toPath

-- | Like `Path.</>`, but works for any `DirLike` and relative `FileLike` to produce a concrete `Path`.
(/>) :: (DirLike b a, FileLike Rel c) => a -> c -> Path b File
(/>) x y = (toDir x) </> (toFile y)
