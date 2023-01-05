------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Configs.Actionbar")

function Module:OnEnable()
    self.Config = {
        name = "Actionbar",
        type = "group",
        order = 3,
        args = {
            header = {
                name = "Actionbar Options",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 1
            },
            enable = {
                name = "PhoUI Actionbar",
                desc = "Enable PhoUI Custom Actionbar",
                type = "toggle",
                width = 1.25,
                order = 2
            },
            gryphons = {
                name = "Show Gryphons",
                desc = "Show Gryphons on Actionbar",
                type = "toggle",
                width = 1.25,
                order = 3
            },
            style = {
                name = "Style",
                desc = "Set the Style of Actionbar",
                type = "select",
                width = "full",
                order = 4,
                values = {
                    ["big"] = "Half",
                    ["full"] = "Full",
                }
            },

            short_keybinds = {
                name = "Short Keybinds",
                desc = "Use short Keybinds like SWU (Shift-Wheelup)",
                type = "toggle",
                order = 5,
                width = "full"
            },
            hotkey = {
                name = "Show Hotkeys",
                desc = "Show Hotkeys on Actionbar",
                type = "toggle",
                width = 1.25,
                order = 6
            },
            macro = {
                name = "Show Macros",
                desc = "Show Macros on Actionbar",
                type = "toggle",
                width = 1.25,
                order = 7
            },
            text_size = {
                name = "Textsize",
                desc = "Set Text Size for Actionbar Texts",
                type = "range",
                min = 8,
                max = 20,
                step = 1,
                order = 8,
                width = "full"
            },
            spacer1 = {
                name = "",
                type = "header",
                order = 9
            },
            menu_header = {
                name = "Menu Options",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 10
            },
            menu_enable = {
                name = "PhoUI Menu",
                desc = "Enable PhoUI Custom Menu",
                type = "toggle",
                width = 1.25,
                order = 11
            },
            menu_hide = {
                name = "Hide Menu",
                desc = "Hide Menu",
                type = "toggle",
                width = 1.25,
                order = 12
            },
        }
    }
end