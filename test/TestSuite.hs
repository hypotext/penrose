-- Modeled after Snap: https://github.com/snapframework/snap-core/blob/master/test/TestSuite.hs
module Main where

import Test.Tasty
import Test.Tasty.SmallCheck as SC
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

-- TODO more tests; check/track test coverage
-- TODO figure out how to test ShadowMain and optimization intermediate stages
-- TODO factor out test into functions, and use template haskell / test discovery
-- TODO we might want inline assertions in code too, to enforce invariants

-- import Main hiding (main)
import qualified ShadowMain.Tests
import qualified Runtime.Tests
-- import qualified Functions.Tests
-- import qualified Shapes.Tests
-- import qualified Utils.Tests
-- import qualified Substance.Tests
-- import qualified Style.Tests
-- import qualified Server.Tests

main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" 
      [ Runtime.Tests.tests,
        ShadowMain.Tests.tests
      ]

-- properties :: TestTree
-- properties = testGroup "Properties" [scProps, qcProps]

-- scProps = testGroup "(checked by SmallCheck)" []
          -- [ QC.testProperty "Utils: dist: distance always non-negative" $
          --   \x1 y1 x2 y2 -> dist (x1 :: Float, y1 :: Float) (x2, y2) >= 0
          -- ]

-- qcProps = testGroup "(checked by QuickCheck)" []
          -- [ QC.testProperty "Utils: dist: distance always non-negative" $
          --   \x1 y1 x2 y2 -> dist (x1 :: Float, y1 :: Float) (x2, y2) >= 0
          -- ]

-- Module: topic: function: property
-- unitTests = testGroup "Unit tests" []
          -- [ testCase "Runtime: packing: yoink: list length" $
          --   yoink [Fix, Vary, Fix] [1, 2, 3] [4, 5] @?= ([1, 4, 2], [3], [5]),

          --   testCase "Utils: autodiff: dist: no NaN" $ -- this is actually 1e-5
          --   isNaN (dist (0, 0) (0, 0)) @?= False
          -- ] 
