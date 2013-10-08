{-# LANGUAGE OverloadedStrings #-}
module Data.Format.Stl.TextParser
       (
         pStl
       ) where

import Control.Applicative
import Data.Text.Lazy as LT
import Data.Text as T
import Data.Attoparsec.Text.Lazy
import Data.Mesh
import Data.Vector (fromList)

pStl :: Parser Mesh
pStl = pSolid <* endOfInput

pSolid :: Parser Mesh
pSolid = do
  name <- pOptSpaces *> string "solid" *> pSpaces *> manyTill anyChar endOfLine
  faces <- many pFacet
  pOptSpaces *> string "endsolid" *> string (T.pack name)
  return $ fromList faces

pFacet :: Parser Triangle
pFacet = do
  normal <- pOptSpaces *> string "facet" *> pSpaces *> string "normal" *> pSpaces *> pPoint <* endOfLine
  pOptSpaces *> string "endfacet" *> endOfLine
  [v1, v2, v3] <- pLoop
  return $ Triangle v1 v2 v3 normal

pLoop :: Parser [Vector3D]
pLoop = do
  pOptSpaces *> string "outer" *> pSpaces *> string "loop" *> endOfLine
  let vertex = pOptSpaces *> string "vertex" *> pSpaces *> pPoint <* endOfLine
  v1 <- vertex
  v2 <- vertex
  v3 <- vertex
  pOptSpaces *> string "endloop" *> endOfLine
  return [v1, v2, v3]

pPoint :: Parser Vector3D
pPoint = Vector3D <$> (double <* pSpaces) <*> (double <* pSpaces) <*> double

pSpaces :: Parser ()
pSpaces = many1 (char ' ') *> pure ()

pOptSpaces :: Parser ()
pOptSpaces = many (char ' ') *> pure ()
