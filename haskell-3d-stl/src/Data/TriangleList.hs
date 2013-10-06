{-# LANGUAGE BangPatterns #-}
{- |
This module contains some basic data structures which can
desrcibe a single 3D mesh.
-}
module Data.TriangleList
       (
         -- * Data format
         Vector (..),
         Triangle (..),
         Normal (..)
       ) where

-- | A vector is consist of x y and z coordinates in space.
data Vector = Vector {-# UNPACK #-} !Double
                     {-# UNPACK #-} !Double
                     {-# UNPACK #-} !Double deriving Eq

instance Show Vector where
  show (Vector x y z) = "(" ++ show x ++ ", " ++ show y ++ ", " ++ show z ++ ")"

-- | A triangle is consist of 3 'Vectors' and a 'Normal'
data Triangle = Triangle Vector Vector Vector Normal deriving Eq

instance Show Triangle where
  show (Triangle a b c n) = show a ++ " - " ++ show b ++ " - " ++ show c ++ " normal " ++ show n

-- | A normal is actuall a vector.
type Normal = Vector

