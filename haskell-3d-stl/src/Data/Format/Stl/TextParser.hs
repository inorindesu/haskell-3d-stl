module Data.Format.Stl.TextParser
       (
         pStl
       ) where

import Data.Text.Lazy as LT
import Data.Attoparsec.Text.Lazy
import Data.TriangleList

pStl :: Parser Mesh
pStl = undefined
