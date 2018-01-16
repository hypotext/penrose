-- | Main module of the Penrose system (split out for testing; Main is the real main)

module ShadowMain where
import Utils
import Graphics.Gloss
import Graphics.Gloss.Data.Vector
import Graphics.Gloss.Interface.Pure.Game
import qualified Server
import qualified Runtime as R
import qualified Substance as C
import qualified Style as S
import qualified Text.Megaparsec as MP (runParser, parseErrorPretty)
import System.Environment
import System.IO
import System.Exit
import Control.Monad (when)


-- | `main` runs the Penrose system
shadowMain :: IO ()
shadowMain = do
    -- Reading in from file
    -- Objective function is currently hard-coded
    -- Comment in (or out) this block of code to read from a file (need to fix parameter tuning!)
    args <- getArgs
    when (length args /= 3) $ die "Usage: ./Main <snap|gloss> prog1.sub prog2.sty"
    let (mode, subFile, styFile) = (head args, args !! 1, args !! 2)
    subIn <- readFile subFile
    styIn <- readFile styFile
    putStrLn "\nSubstance program:\n"
    putStrLn subIn
    divLine
    putStrLn "Style program:\n"
    putStrLn styIn
    divLine

    objs <- C.parseSubstance subFile subIn

    -- case MP.runParser C.substanceParser subFile subIn of
    --     Left err -> putStr $ MP.parseErrorPretty err
    --     Right subParsed -> do
    --         divLine
    --         putStrLn "Parsed Substance program:\n"
    --         mapM_ print subParsed
    --         -- putStrLn $ C.subPrettyPrint' subParsed
    --         divLine
    --         let e = C.check subParsed
    -- let subSep@(decls, constrs) = C.subSeparate $ C.subObjs e
    let subSep@(decls, constrs) = C.subSeparate objs
    mapM_ print decls
    divLine
    mapM_ print constrs

    case MP.runParser S.styleParser styFile styIn of
        Left err -> putStr $ MP.parseErrorPretty err
        Right styParsed -> do
            divLine
            putStrLn "Parsed Style program:\n"
            --    putStrLn $ C.styPrettyPrint styParsed
            mapM_ print styParsed
            divLine
            -- let initState = R.genInitState (C.subSeparate subParsed) styParsed
            let initState = R.genInitState subSep styParsed
            putStrLn "Synthesizing objects and objective functions"
            -- let initState = compilerToRuntimeTypes intermediateRep
            -- divLine
            -- putStrLn "Initial state, optimization representation:\n"
            -- putStrLn "TODO derive Show"
            -- putStrLn $ show initState

            divLine
            putStrLn "Visualizing notation:\n"

            if mode == "snap" then
                -- Starting serving penrose on the web
                let (domain, port) = ("127.0.0.1", 9160) in
                Server.servePenrose domain port initState

                else
                    --    Running with hardcoded parameters
                    play
                    (InWindow "optimization-based layout" -- display mode, window name
                    (picWidth, picHeight)   -- size
                    (10, 10))    -- position
                    white                   -- background color
                    stepsPerSecond         -- number of simulation steps to take for each second of real time
                    initState               -- the initial world, defined as a type below
                    R.picOf                   -- fn to convert world to a pic
                    R.handler                 -- fn to handle input events
                    R.step                    -- step the world one iteration; passed period of time (in secs) to be advanced

                    -- picWidth, picHeight :: Int
                    -- picWidth = 800
                    -- picHeight = 700
                    --
                    -- stepsPerSecond :: Int
                    -- stepsPerSecond = 10000
