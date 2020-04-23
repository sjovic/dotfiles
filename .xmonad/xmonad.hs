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
    [
    className =? "Zathura" --> doShift "4"
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
        , terminal = "uxterm"
        }
        `additionalKeys` [
            ((mod4Mask, xK_b), sendMessage ToggleStruts),
         -- ((mod1Mask .|. controlMask, xK_x), shellPrompt def),
         -- ((mod4Mask, xK_F9), spawn "systemctl suspend"),
         -- ((mod4Mask .|. shiftMask, xK_F9), spawn "systemctl poweroff"),
            ((mod1Mask .|. mod4Mask, xK_e), spawn "emacs"),
            ((mod1Mask .|. mod4Mask, xK_c), spawn "chromium-browser"),
            ((mod4Mask, xK_l), spawn "xscreensaver-command --lock"),
            ((0, 0x1008ff11), spawn "amixer -q -D pulse sset Master 5%-"),
            ((0, 0x1008ff13), spawn "amixer -q -D pulse sset Master 5%+"),
            ((0, 0x1008ff12), spawn "amixer -q -D pulse sset Master toggle")]
         -- ((mod4Mask, xK_x), AL.launchApp defaultXPConfig ">")]
       `removeKeys` [(mod4Mask, xK_p)] -- remove dmenu launch keybinding to use projectile

workspaces' = ["1", "2", "3", "4", "5"]