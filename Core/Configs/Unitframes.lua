------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Configs.Unitframes")

function Module:OnEnable()
    self.Config = {
        name = "Unitframes",
        type = "group",
        order = 2,
        args = {
            header = {
                name = "Unitframes Options",
                type = "header",
                order = 1
            },
            frame_style = {
                name = "Frame Style",
                desc = "Set the Style for Unitframes",
                type = "select",
                order = 2,
                width = 1.25,
                values = {
                    ["small"] = "Small",
                    ["big"] = "Big",
                }
            },
            chain = {
                name = "Playerchain",
                desc = "Set Chain around Playerframe",
                type = "select",
                order = 3,
                width = 1.25,
                values = {
                    ["none"] = "none",
                    [1] = "Boss",
                    [2] = "Rare",
                    [3] = "Elite"
                }
            },
            misc_header = {
                name = "Miscellaneous",
                type = "header",
                order = 4
            },
            classcolor = {
                name = "Classcolor Unitframes",
                desc = "Set the Unitframes (Bars) Classcolored",
                type = "toggle",
                order = 5,
                width = 1.25
            },
            classbar = {
                name = "Classbar",
                desc = "Show Classbar under Playerframe",
                type = "toggle",
                order = 6,
                width = 1.25
            },
            hitindicator = {
                name = "Hitindicator",
                desc = "Show Hitindicator",
                type = "toggle",
                order = 7,
                width = 1.25
            },
            rested = {
                name = "Rested",
                desc = "Show Rested",
                type = "toggle",
                order = 8,
                width = 1.25
            },
            pvpicon = {
                name = "PvP Icon",
                desc = "Show PvP Icons",
                type = "toggle",
                order = 8,
                width = 1.25
            },
            buff_collapse = {
                name = "Buff Collapse Icon",
                desc = "Show Buff Collapse Icon (Buffframe on Minimap)",
                type = "toggle",
                order = 9,
                width = 1.25
            },
            buffsize = {
                name = "Buff Icon Size",
                desc = "Set the Buff Icon Size",
                type = "range",
                min = 15,
                max = 50,
                order = 10,
                width = 1.25
            },
            debuffsize = {
                name = "Debuff Icon Size",
                desc = "Set the Debuff Icon Size",
                type = "range",
                min = 15,
                max = 50,
                order = 11,
                width = 1.25
            }
        }
    }
end