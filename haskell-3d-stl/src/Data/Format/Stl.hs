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

parseStlText :: LT.Text -> Maybe Mesh
parseStlText = undefined

toStlText :: Mesh -> LT.Text
toStlText = undefined
