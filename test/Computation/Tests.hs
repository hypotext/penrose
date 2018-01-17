module Computation.Tests (tests) where

import Test.Tasty
import Test.Tasty.SmallCheck as SC
import Test.Tasty.QuickCheck as QC
import Test.Tasty.HUnit

import Computation
import System.Random
import Runtime

tests :: TestTree
tests = testGroup "Computation tests" [properties, unitTests]

properties :: TestTree
properties = testGroup "Properties" [scProps, qcProps]

type Point = (Float, Float)

inBbox :: Point -> Point -> Point -> Bool
inBbox (lowerx, lowery) (topx, topy) (x, y) = lowerx <= x && x <= topx && lowery <= y && y <= topy

-- TODO write as quickcheck
surjection_allInBbox_unit :: Assertion
surjection_allInBbox_unit = let (lowerLeft, topRight) = ((-10, -10), (10, 10)) in
                           let numPoints = 10 in
                           let (pts, rng') = computeSurjection initRng numPoints lowerLeft topRight in
                           let check = all (inBbox lowerLeft topRight) pts in
                           check @?= True

surjection_allInBbox :: Point -> Point -> Integer -> Bool
surjection_allInBbox lowerLeft topRight numPoints =
                       let (pts, rng') = computeSurjection initRng numPoints lowerLeft topRight in
                       -- given a valid bbox and number of points (TODO check former in computation)
                       numPoints < 2 
                       || fst lowerLeft > fst topRight
                       || snd lowerLeft > snd topRight
                       || all (inBbox lowerLeft topRight) pts

scProps = testGroup "(checked by SmallCheck)" 
          [ 
          ]

qcProps = testGroup "(checked by QuickCheck)" 
          [ QC.testProperty "surjection: all points in bounding box" surjection_allInBbox
          ]

-- Module: topic: function: property
unitTests = testGroup "Unit tests" 
          [ testCase "surjection: all points in bounding box" surjection_allInBbox_unit
          ]
