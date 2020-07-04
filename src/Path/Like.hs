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
  FileLike(..)
, DirLike(..)
, (/>)
) where

import Path

-- | Class representing a type `a` that can be compiled down to a `Path b File`.
class FileLike b a | a -> b where
  toFile :: a -> Path b File

-- | Class representing a type `a` that can be compiled down to a `Path b Dir`.
class DirLike b a | a -> b where
  toDir :: a -> Path b Dir

instance FileLike b (Path b File) where
  toFile = id

instance DirLike b (Path b Dir) where
  toDir = id

-- | Like `Path.</>`, but works for any `DirLike` and relative `FileLike` to produce a concrete `Path`.
(/>) :: (DirLike b a, FileLike Rel c) => a -> c -> Path b File
(/>) x y = (toDir x) </> (toFile y)
