import Halive.SubHalive
import System.FilePath
import Control.Monad.Trans
import Control.Monad
import Standalone
import Control.Concurrent

main :: IO ()
main = do
    let ghcSessionConfig = defaultGHCSessionConfig 
            { gscPackageDBs = 
                [ "packages" </> "local" </> "pkgdb"
                , "packages" </> "snapshot" </> "pkgdb"
                ]
            , gscLibDir = "packages" </> "ghc" </> "lib"
            }
    withGHCSession ghcSessionConfig $ do
        
        result <- recompileExpressionInFile "Foo.hs" "foo"
        liftIO $ case result of
            Left errz -> putStrLn (concat errz)
            Right value -> do
                let myThing = show (getCompiledValue value :: MyThing)
                replicateM_ 10 $ do
                    threadDelay (100*1000)
                    putStrLn myThing
