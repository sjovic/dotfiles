import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Prompt
import XMonad.Prompt.Pass

myManageHook = composeAll
    [
    ]

myXPConfig = 
    XPC {
          font               = ""
        , bgColor           = "#000000"
        , fgColor           = "#DDDDDD"
        , fgHLight          = "#FFFFFF"
        , bgHLight          = "#333333"
        , borderColor       = "#FFFFFF"
        , alwaysHighlight   = True
        , promptBorderWidth = 0
        , position          = Top
        , height            = 16
        , historySize       = 256
        , defaultText       = ""
        , autoComplete      = Nothing
        , historyFilter     = id
        , showCompletionOnTab = False
        , promptKeymap      = defaultXPKeymap
        , completionKey     = (0, xK_Tab)
        }

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks $ ewmh def
        {
          handleEventHook = handleEventHook def <+> fullscreenEventHook
        , manageHook = myManageHook <+> manageDocks <+> manageHook def
        , layoutHook = avoidStruts $ layoutHook def
        , modMask = mod4Mask
        , startupHook = setWMName "LG3D"
        -- , terminal = "xterm +ls"
        , terminal = "st"
        }
        `additionalKeys` [
            ((mod4Mask, xK_b), sendMessage ToggleStruts),
         -- ((mod1Mask .|. controlMask, xK_x), shellPrompt def),
            ((mod4Mask, xK_F9), spawn "systemctl suspend"),
         -- ((mod4Mask .|. shiftMask, xK_F9), spawn "systemctl poweroff"),
            ((mod1Mask .|. mod4Mask, xK_e), spawn "emacs"),
            ((mod1Mask .|. mod4Mask, xK_c), spawn "x-www-browser"),
            ((mod4Mask, xK_l), spawn "xscreensaver-command --lock"),
            ((0, 0x1008ff11), spawn "amixer -q -D pulse sset Master 5%-"),
            ((0, 0x1008ff13), spawn "amixer -q -D pulse sset Master 5%+"),
            ((0, 0x1008ff12), spawn "amixer -q -D pulse sset Master toggle"),
         --   ((mod4Mask, xK_F10), spawn "import -window root ~/shot.png"),
            ((mod4Mask, xK_F10), spawn "import ~/temp/screenshot.png"),
            ((mod1Mask .|. mod4Mask, xK_p), passPrompt def)]
         -- ((mod4Mask, xK_x), AL.launchApp defaultXPConfig ">")]
       `removeKeys` [(mod4Mask, xK_p)] -- remove dmenu launch keybinding to use projectile

workspaces' = ["1", "2", "3", "4", "5"]
