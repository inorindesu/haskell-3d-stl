import Data.Format.Stl
import Data.Mesh
import qualified Data.Vector as V
import qualified Data.Text.Lazy as LT
import Test.QuickCheck
import Control.Applicative

main = verboseCheck prop_canParseSelf

instance Arbitrary a => Arbitrary (V.Vector a) where
  arbitrary = V.fromList <$> listOf1 arbitrary

instance Arbitrary Triangle where
  arbitrary = Triangle <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

instance Arbitrary Vector3D where
  arbitrary = Vector3D <$> arbitrary <*> arbitrary <*> arbitrary

prop_canParseSelf :: String -> Mesh -> Bool
prop_canParseSelf name m =
  let t = toStlText m name
      parseResult = parseStlText t
  in case parseResult of
       Nothing -> False
       Just a -> a == m
