module Shapes.Tests (tests) where

import Test.Tasty
import Test.Tasty.SmallCheck as SC
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

import Shapes
import Runtime

tests :: TestTree
tests = testGroup "Shapes tests" [properties, unitTests]

properties :: TestTree
properties = testGroup "Properties" [scProps, qcProps]

circ_get_set_id :: Assertion
circ_get_set_id = let cir = defaultCirc "c" in
                  let x = (10 :: Float) in
                  let res = getX $ setX x cir in
                  (res == x) @?= True
        
scProps = testGroup "(checked by SmallCheck)" 
          [ 
          ]

qcProps = testGroup "(checked by QuickCheck)" 
          [ 
          ]

-- Module: topic: function: property
unitTests = testGroup "Unit tests" 
          [ testCase "one kind of object, get/set identity" circ_get_set_id
          ]
