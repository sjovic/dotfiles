import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Prompt
import XMonad.Prompt.Pass
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Shell

myManageHook = composeAll
    [
    ]

myXPConfig = def { position = Top
                 , promptBorderWidth = 1
                 , bgColor = "Black"
                 , fgColor = "White"
                 , defaultText = []
                 , alwaysHighlight = True
                 , promptKeymap = emacsLikeXPKeymap
                 , font = "xft:Monoid-8"
                 , height = 32
                 , searchPredicate = fuzzyMatch
                 }

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks $ ewmh def
        {
          -- handleEventHook = handleEventHook def <+> fullscreenEventHook
          -- handleEventHook = handleEventHook def <+> ewmhFullscreen
        manageHook = myManageHook <+> manageDocks <+> manageHook def
        , layoutHook = avoidStruts $ layoutHook def
        , modMask = mod4Mask
        , startupHook = setWMName "LG3D"
        , terminal = "alacritty"
        }
        `additionalKeys` [
            ((mod4Mask, xK_b), sendMessage ToggleStruts),
         -- ((mod1Mask .|. controlMask, xK_x), shellPrompt def),
            ((mod4Mask, xK_F9), spawn "systemctl suspend"),
         -- ((mod4Mask .|. shiftMask, xK_F9), spawn "systemctl poweroff"),
            ((mod1Mask .|. mod4Mask, xK_e), spawn "emacs"),
            ((mod1Mask .|. mod4Mask, xK_b), spawn "x-www-browser"),
            ((mod1Mask .|. mod4Mask, xK_c), spawn "google-chrome-stable"),
            ((mod1Mask .|. mod4Mask, xK_s), spawn "skypeforlinux"),
            ((mod1Mask .|. mod4Mask, xK_t), spawn "teams"),
            ((mod4Mask, xK_l), spawn "xscreensaver-command --lock"),
            ((controlMask .|. mod4Mask, xK_k), kill),
            ((mod1Mask .|. mod4Mask, xK_l), spawn "xscreensaver-command --lock"),
            ((0, 0x1008ff11), spawn "amixer -q -D pulse sset Master 5%-"),
            ((0, 0x1008ff13), spawn "amixer -q -D pulse sset Master 5%+"),
            ((0, 0x1008ff12), spawn "amixer -q -D pulse sset Master toggle"),
            ((mod4Mask, xK_F10), spawn "import ~/temp/screenshot.png"),
            ((mod1Mask .|. mod4Mask, xK_p), passPrompt myXPConfig),
            ((mod1Mask .|. mod4Mask, xK_s), shellPrompt myXPConfig)]
         -- ((mod4Mask, xK_x), AL.launchApp defaultXPConfig ">")]
       `removeKeys` [(mod4Mask, xK_p)] -- remove dmenu launch keybinding to use projectile

workspaces' = ["1", "2", "3", "4", "5"]
