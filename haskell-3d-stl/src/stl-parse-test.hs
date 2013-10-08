import Data.Format.Stl
import Data.Mesh
import qualified Data.Vector as V
import qualified Data.Text.Lazy as LT
import Test.QuickCheck
import Control.Applicative

main = quickCheck prop_canParseSelf

instance Arbitrary a => Arbitrary (V.Vector a) where
  arbitrary = V.fromList <$> listOf1 arbitrary

instance Arbitrary Triangle where
  arbitrary = Triangle <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary

instance Arbitrary Vector3D where
  arbitrary = Vector3D <$> arbitraryDouble <*> arbitraryDouble <*> arbitraryDouble
    where arbitraryDouble = fromIntegral <$> chooser
          chooser = (choose (-1000, 1000)) :: Gen Int

prop_canParseSelf :: String -> Mesh -> Bool
prop_canParseSelf name m =
  let t = toStlText m (safeHead . lines $ name)
      parseResult = parseStlText t
      safeHead [] = ""
      safeHead (a:_) = a
  in case parseResult of
       Nothing -> False
       Just a -> a == m
