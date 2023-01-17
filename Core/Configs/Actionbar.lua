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
                name = "General",
                type ="header",
                order = 1,
            },
            enable = {
                name = "Enable Custom Actionbar",
                desc = "Enable PhoUI Styled Actionbar",
                type = "toggle",
                width = 1.3,
                order = 2,
            },
            custom_buttons = {
                name = "Enable Custom Button",
                desc = "Enable PhoUI Actionbar Button Style",
                type = "toggle",
                width = 1.3,
                order = 3
            },
            style_header = {
                name = "Actionbar Settings",
                type = "header",
                order = 4
            },
            style = {
                name = "Actionbar Style",
                desc = "Set the Style of the Actionbar",
                type = "select",
                order = 5,
                width = 1.3,
                values = {
                    ["full"] = "Full Actionbar",
                    ["half"] = "Short Actionbar",
                    ["classic"] = "Classic Actionbar"
                }
            },
            gryphons = {
                name = "Gryphons",
                desc = "Set Gryphons for Actionbar",
                type = "select",
                order = 6,
                width = 1.3,
                values = {
                    ["Wyvern"] = "Wyvern",
                    ["Gryphon"] = "Gryphon",
                    ["Faction"] = "Faction",
                    ["Hide"] = "Hide"
                },
            },
            menu_header = {
                name = "Menu",
                type = "header",
                order = 7
            },
            menu_style = {
                name = "Menu Style",
                desc = "Select the Type of Menu",
                type = "select",
                order = 8,
                values = {
                    ["custom"] = "Custom",
                    ["blizzard"] = "Blizzard",
                    ["hide"] = "Hide"
                }
            }
        }
    }
    --[[
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
            enable_buttons = {
                name = "PhoUI Button Border",
                desc = "Enable PhoUI Actionbar Button Borders",
                type = "toggle",
                width = "full",
                order = 3,
            },
            gryphons = {
                name = "Show Gryphons",
                desc = "Show Gryphons on Actionbar",
                type = "toggle",
                width = 1.25,
                order = 4
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
                order = 6,
                width = "full"
            },
            hotkey = {
                name = "Show Hotkeys",
                desc = "Show Hotkeys on Actionbar",
                type = "toggle",
                width = 1.25,
                order = 7
            },
            macro = {
                name = "Show Macros",
                desc = "Show Macros on Actionbar",
                type = "toggle",
                width = "full",
                order = 8
            },
            text_size = {
                name = "Textsize",
                desc = "Set Text Size for Actionbar Texts",
                type = "range",
                min = 8,
                max = 20,
                step = 1,
                order = 9,
                width = "full"
            },
            spacer1 = {
                name = "",
                type = "header",
                order = 10
            },
            menu_header = {
                name = "Menu Options",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 11
            },
            menu_enable = {
                name = "PhoUI Menu",
                desc = "Enable PhoUI Custom Menu",
                type = "toggle",
                width = "full",
                order = 12
            },
            menu_hide = {
                name = "Hide Menu",
                desc = "Hide Menu",
                type = "toggle",
                width = "full",
                order = 13
            },
            statusbar = {
                name = "Hide Statusbar",
                desc = "Hide Statusbar and XP/Honor Bar",
                type = "toggle",
                width = "full",
                order = 14
            }
        }
    }]]
end