{-
   __   _____  ___                      _
   \ \ / /|  \/  |                     | |
    \ V / | .  . | ___  _ __   __ _  __| |
    /   \ | |\/| |/ _ \| '_ \ / _` |/ _` |
   / /^\ \| |  | | (_) | | | | (_| | (_| |
   \/   \/\_|  |_/\___/|_| |_|\__,_|\__,_|

Available at: https://github.com/mislavzanic/Dotfiles

GLHF
-}

-- custom modules
import Custom.Vars
import Custom.Keys
import Custom.Layouts
import Hooks.StartupHook
import Hooks.ManageHook
import Hooks.StatusBar


import XMonad hiding ( (|||) ) -- jump to layout

import XMonad.Config.Desktop

-- actions
import XMonad.Actions.TopicSpace (workspaceHistoryHookExclude)
import XMonad.Actions.SwapPromote (masterHistoryHook)
import XMonad.Actions.UpdatePointer (updatePointer)

-- util
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad

-- hooks
import XMonad.Hooks.ManageDocks (manageDocks)
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhFullscreen, setEwmhActivateHook)
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.StatusBar (dynamicEasySBs)

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

main :: IO ()
main = xmonad
     . setEwmhActivateHook activateHook
     . ewmhFullscreen
     . ewmh
     . withUrgencyHook NoUrgencyHook
     . dynamicEasySBs (pure . barSpawner)
     $ myConfig where
        myConfig = desktopConfig
          { manageHook         = ( isFullscreen --> doFullFloat ) <+> manageDocks <+> myManageHook <+> manageHook desktopConfig
          , startupHook        = myStartupHook
          , layoutHook         = myLayout
          , handleEventHook    = handleEventHook desktopConfig <+> myHandleEventHook
          , workspaces         = myWorkspaces
          , borderWidth        = myBorderWidth
          , terminal           = myTerminal
          , modMask            = myModMask
          , normalBorderColor  = myNormalBorderColor
          , focusedBorderColor = myFocusedBorderColor
          , logHook            = workspaceHistoryHookExclude [scratchpadWorkspaceTag]
                                 -- Remember where we've been.
                                 <> masterHistoryHook -- Remember where we've been² (for 'swapPromote').
                                 <> updatePointer (0.5, 0.5) (0, 0)
                                 -- When focusing a new window with the keyboard,
                                 -- move pointer to exact center of that window.
          }
          `additionalKeysP` myKeys