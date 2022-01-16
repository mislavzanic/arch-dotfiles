module Hooks.ManageHook where

import XMonad
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat, doFocus, isDialog)
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.UrgencyHook (doAskUrgent)
import XMonad.Util.NamedScratchpad



import Custom.Vars
import Custom.Scratchpads

activateHook :: ManageHook
activateHook = mconcat
    [ isDialog --> doAskUrgent
    , className =? "mpv" --> doAskUrgent
    , className =? "help" --> doAskUrgent
    , className =? "Sxiv" --> doAskUrgent
    , className =? "discord" --> doAskUrgent
    , className =? "brave" --> doAskUrgent
    , pure True --> doFocus
    ]


myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "discord" --> doShift ( myWorkspaces !! 3 )
    , className =? "mpv"     --> doShift ( myWorkspaces !! 4 )

    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore

    , isFullscreen --> doFullFloat
    ] <+> namedScratchpadManageHook myScratchPads



myHandleEventHook = swallowEventHook (className =? "Alacritty") (return True)
