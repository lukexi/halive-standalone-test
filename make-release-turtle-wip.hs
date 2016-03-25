#!/usr/bin/env stack
-- stack runghc --package turtle
{-# LANGUAGE OverloadedStrings #-}

import Turtle

main = sh $ do
    mktree "standalone/snapshotlibs"
    snapshotInstallRoot <- inshell "stack path --snapshot-install-root" empty
    liftIO $ print snapshotInstallRoot
    sh $ do
        file <- find (ends ".conf") ("standalone" </> "snapshotlibs")
        echo (format fp file) 
        inplace (text snapshotInstallRoot *> return "${pkgroot}") file
    echo "Done!"