module ShadowMain.Tests (tests) where

import Test.Tasty
import Test.Tasty.SmallCheck as SC
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

import ShadowMain

tests :: TestTree
tests = testGroup "Tests" [properties, unitTests]

properties :: TestTree
properties = testGroup "Properties" [scProps, qcProps]

scProps = testGroup "(checked by SmallCheck)" 
          []

qcProps = testGroup "(checked by QuickCheck)" 
          []

-- Module: topic: function: property
unitTests = testGroup "Unit tests" 
          [ testCase "ShadowMain" $
            True @?= False
          ]
