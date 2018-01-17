module Functions.Tests (tests) where

import Test.Tasty
import Test.Tasty.SmallCheck as SC
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

import Functions
import Shapes
import Runtime

tests :: TestTree
tests = testGroup "Functions tests" [properties, unitTests]

properties :: TestTree
properties = testGroup "Properties" [scProps, qcProps]

scProps = testGroup "(checked by SmallCheck)" 
          [ 
          ]

-- These tests could be more useful. Just an example.
sameSize_idCirc :: Circ' a -> Circ' a -> Bool
sameSize_idCirc c1 c2 = True

sameSize_idCirc_unit :: Assertion
sameSize_idCirc_unit = (sameSize [defcirc, defcirc] [] == 0) @?= True
                       where defcirc = addGrad $ defaultCirc "c"

-- This should really be on the gradient of repel evaluated at 0
repel_CS_unit_NaN :: Assertion
repel_CS_unit_NaN = (isNaN $ repel [defcirc, defsquare] []) @?= False
                       where defcirc = addGrad $ defaultCirc "c"
                             defsquare = addGrad $ defaultCirc "s"

-- Perhaps "for any two randomly initialized objects, an objective function that can be applied to them
-- does not result in NaN"? TODO derive Arbitrary
-- TODO test that repel never/seldom gives NaNs (given that its derivative has a denominator)
qcProps = testGroup "(checked by QuickCheck)" 
          [ -- QC.testProperty "constraint function: same size identity" sameSize_idCirc
            
          ]

-- Module: topic: function: property
unitTests = testGroup "Unit tests" 
          [ testCase "constraint function: same size identity" sameSize_idCirc_unit,
            testCase "objective function: repel no NaN" sameSize_idCirc_unit
          ]
