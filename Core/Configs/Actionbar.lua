local P, H, O, U, I = ...
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

            hotkey = {
                name = "Show Hotkeys",
                desc = "Show Hotkeys on Actionbars",
                type = "toggle",
                order = 7,
                width = 1.3
            },
            macro = {
                name = "Show Macro Texts",
                desc = "Show Macro Texts on Actionbars",
                type = "toggle",
                order = 8,
                width = 1.3
            },
            text_size = {
                name = "Hotkey & Macro Text Size",
                desc = "Set the Size for Hotkeys and Macros",
                type = "range",
                order = 9,
                min = 2,
                max = 30,
                step = 1,
                width = 1.3
            },
            short_hotkey = {
                name = "Short Hotkeys",
                desc = "Set the Hotkeys Text shorter",
                type = "toggle",
                order = 9,
                width = 1.3
            },
            actionbar_size = {
                name = "Actionbar Size",
                desc = "Set the Size for Actionbar",
                type = "range",
                order = 11,
                min = 1,
                max = 2,
                step = 0.25,
                width = "full",
                get = function()
                    return PhoUI.db.profile.actionbar.size
                end,
                set = function(info, value)
                    local Actionbar = _G[P .. "Actionbar"]
                    Actionbar:SetScale(value)
                    PhoUI.db.profile.actionbar.size = value
                    print(value)
                end
            },
            menu_header = {
                name = "Menu",
                type = "header",
                order = 12
            },
            menu_style = {
                name = "Menu Style",
                desc = "Select the Type of Menu",
                type = "select",
                order = 13,
                values = {
                    ["custom"] = "Custom",
                    ["blizzard"] = "Blizzard",
                    ["hide"] = "Hide"
                }
            }
        }
    }
end