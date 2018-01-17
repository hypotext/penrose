module Utils.Tests (tests) where

import Test.Tasty
import Test.Tasty.SmallCheck as SC
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

import Utils

tests :: TestTree
tests = testGroup "Utils tests" [properties, unitTests]

properties :: TestTree
properties = testGroup "Properties" [scProps, qcProps]

distNonnegative :: Float -> Float -> Float -> Float -> Bool
distNonnegative x1 y1 x2 y2 = dist (x1, y1) (x2, y2) >= 0

-- this is actually 1e-5
distNonNaN_atZero :: Assertion
distNonNaN_atZero = isNaN (dist (0, 0) (0, 0)) @?= False

scProps = testGroup "(checked by SmallCheck)" -- use SC.testProperty
          [ 
          ]

qcProps = testGroup "(checked by QuickCheck)" 
          [ QC.testProperty "dist: distance always non-negative" distNonnegative
          ]

-- Module: topic: function: property
unitTests = testGroup "Unit tests" 
          [ testCase "autodiff: dist: no NaN" distNonNaN_atZero
          ] 
