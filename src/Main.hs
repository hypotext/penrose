-- | Main module of the Penrose system (logic is moved to ShadowMain for testing)

module Main where
import ShadowMain

-- | `main` runs the Penrose system
main :: IO ()
main = shadowMain
