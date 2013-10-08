{-|
This module provides read / write support for STL file format.
-}
module Data.Format.Stl
       (
         parseStlText,
         toStlText
       ) where

import Data.Monoid
import qualified Data.Text.Lazy as LT
import Data.Text.Lazy.Builder as B
import Data.Text.Lazy.Builder.RealFloat as B
import Data.Format.Stl.TextParser
import Data.Mesh
import Data.Attoparsec.Text.Lazy
import qualified Data.Vector as V

-- | Parse a stl-formated text stream into a 'Mesh'.
--   If any format error is found, this function returns
--   'Nothing'.
parseStlText :: LT.Text -> Maybe Mesh
parseStlText = maybeResult . parse pStl

toStlText :: Mesh
             -> String   -- ^ Name of the mesh
             -> LT.Text
toStlText m n = toLazyText $ V.foldl' folder (tSolidStart n) m  <> tSolidEnd n
  where
    folder builder triangle = builder <> tTriangle triangle

tSolidStart :: String -> Builder
tSolidStart s = fromString "solid " <> fromString s <> tEol

tTriangle :: Triangle -> Builder
tTriangle (Triangle a b c n) =
  fromString " facet normal " <> tVector3D n <> tEol <>
  fromString "  outer loop" <> tEol <>
  fromString "   vertex " <> tVector3D a <> tEol <>
  fromString "   vertex " <> tVector3D b <> tEol <>
  fromString "   vertex " <> tVector3D c <> tEol <>
  fromString "  endloop" <> tEol <>
  fromString " endfacet" <> tEol

tSolidEnd :: String -> Builder
tSolidEnd s = fromString "endsolid " <> fromString s <> tEol

tEol :: Builder
tEol = singleton '\n'

tVector3D :: Vector3D -> Builder
tVector3D (Vector3D x y z) = realFloat x <> singleton ' ' <> realFloat y <> singleton ' ' <> realFloat z
