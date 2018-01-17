module Runtime.Tests (tests) where

import Test.Tasty
import Test.Tasty.SmallCheck as SC
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

import Runtime

tests :: TestTree
tests = testGroup "Runtime tests" [properties, unitTests]

properties :: TestTree
properties = testGroup "Properties" [scProps, qcProps]

scProps = testGroup "(checked by SmallCheck)" 
          []

qcProps = testGroup "(checked by QuickCheck)" 
          []

-- Module: topic: function: property
unitTests = testGroup "Unit tests" 
          [ testCase "Packing: yoink: list length" $
            yoink [Fix, Vary, Fix] [1, 2, 3] [4, 5] @?= ([1, 4, 2], [3], [5])
          ]
