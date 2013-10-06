{-|
This module provides read / write support for STL file format.
-}
module Data.Format.Stl
       (
         parseStlText,
         toStlText
       ) where

import qualified Data.Text.Lazy as LT
import Data.Format.Stl.TextParser
import Data.TriangleList
import Data.Attoparsec.Text.Lazy

-- | Parse a stl-formated text stream into a 'Mesh'.
--   If any format error is found, this function returns
--   'Nothing'.
parseStlText :: LT.Text -> Maybe Mesh
parseStlText = maybeResult . parse pStl

toStlText :: Mesh -> LT.Text
toStlText = undefined
