------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Configs.Unitframes")

function Module:OnEnable()
    --[[self.Config = {
        name = "Unitframes",
        type = "group",
        childGroups = "tree",
        args = {
            test = {
                type = "group",
                name = "group",

                args = {
                    testarg = {
                        name = "name",
                        type ="header"
                    }
                }

            }
        }]]
    self.Config = {
        name = "Unitframes",
        type = "group",
        order = 2,
        args = {
            header = {
                name = "Unitframes Options",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 1
            },
            frame_style = {
                name = "Frame Style",
                desc = "Set the Style for Unitframes",
                type = "select",
                order = 3,
                width = "full",
                values = {
                    ["small"] = "Small",
                    ["big"] = "Big",
                    ["blizzard"] = "Blizzard"
                }
            },
            chain = {
                name = "Playerchain",
                desc = "Set Chain around Playerframe",
                type = "select",
                order = 4,
                width = "full",
                values = {
                    ["none"] = "none",
                    [1] = "Boss",
                    [2] = "Rare",
                    [3] = "Elite"
                }
            },
            spacer2 = {
                name = "",
                type = "header",
                order = 5,
            },
            misc_header = {
                name = "Miscellaneous",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 6
            },
            classcolor = {
                name = "Classcolor Unitframes",
                desc = "Set the Unitframes (Bars) Classcolored",
                type = "toggle",
                order = 7,
                width = "full"
            },
            classbar = {
                name = "Classbar",
                desc = "Show Classbar under Playerframe",
                type = "toggle",
                order = 8,
                width = "full"
            },
            hitindicator = {
                name = "Hitindicator",
                desc = "Show Hitindicator",
                type = "toggle",
                order = 9,
                width = "full"
            },
            rested = {
                name = "Rested",
                desc = "Show Rested",
                type = "toggle",
                order = 10,
                width = "full"
            },
            pvpicon = {
                name = "PvP Icon",
                desc = "Show PvP Icons",
                type = "toggle",
                order = 11,
                width = "full"
            },
            buff_collapse = {
                name = "Buff Collapse Icon",
                desc = "Show Buff Collapse Icon (Buffframe on Minimap)",
                type = "toggle",
                order = 12,
                width = "full"
            },
            buffsize = {
                name = "Buff Icon Size",
                desc = "Set the Buff Icon Size",
                type = "range",
                min = 15,
                max = 50,
                step = 1,
                order = 13,
                width = "full"
            },
            debuffsize = {
                name = "Debuff Icon Size",
                desc = "Set the Debuff Icon Size",
                type = "range",
                min = 15,
                max = 50,
                step = 1,
                order = 12,
                width = "full"
            }
        }
    }
end