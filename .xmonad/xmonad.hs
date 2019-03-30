import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.AppLauncher as AL

myManageHook = composeAll
    [ className =? "Skype" --> doShift "4"
    , className =? "Firefox" --> doShift "3"
    , className =? "Zathura" --> doShift "4"
    ]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks $ ewmh def
        {
          handleEventHook = handleEventHook def <+> fullscreenEventHook
        , manageHook = myManageHook <+> manageDocks <+> manageHook def
        , layoutHook = avoidStruts $ layoutHook def
        , modMask = mod4Mask
        , startupHook = setWMName "LG3D"
        }
        `additionalKeys`
        [((mod4Mask, xK_b), sendMessage ToggleStruts),
                     ((mod1Mask .|. controlMask, xK_x), shellPrompt def),
                     ((mod4Mask, xK_F4), spawn "systemctl suspend"),
                     ((mod4Mask .|. shiftMask, xK_F4), spawn "systemctl poweroff"),
                     ((mod1Mask .|. controlMask, xK_e), spawn "emacs"),
                     ((mod1Mask .|. controlMask, xK_b), spawn "firefox"),
                     ((mod1Mask .|. controlMask, xK_c), spawn "google-chrome-stable"),
                     -- ((mod1Mask .|. controlMask, xK_s), spawn "skypeforlinux"),
                     ((mod1Mask .|. controlMask, xK_l), spawn "slock"),
                     ((0, 0x1008ff11), spawn "amixer sset Master 5%-"),
                     ((0, 0x1008ff13), spawn "amixer sset Master 5%+"),
                     ((0, 0x1008ff12), spawn "amixer sset Master toggle")] --,
                  -- ((mod4Mask, xK_x), AL.launchApp defaultXPConfig ">")]
       `removeKeys` [(mod4Mask, xK_p)] -- remove dmenu launch keybinding to use projectile

workspaces' = ["1", "2", "3", "4", "5"]
