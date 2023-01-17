------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Configs.Castbar")

function Module:OnEnable()
    self.Config = {
        name = "Castbar",
        type = "group",
        order = 4,
        args = {
            header = {
                name = "Castbar Options",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 1
            },
            enable = {
                name = "PhoUI Castbar",
                desc = "Enable PhoUI Custom Castbars",
                type = "toggle",
                width = "full",
                order = 2
            },
            icon = {
                name = "Show Icon",
                desc = "Show Spell Icon on Castbars",
                type = "toggle",
                width = "full",
                order = 3
            },
            timer = {
                name = "Show Timer",
                desc = "Show Timer on Castbars",
                type = "toggle",
                width = "full",
                order = 4
            },
            hide_anim = {
                name = "Hide Castbar Animations",
                desc = "Hide the Castbar ending Animations",
                type = "toggle",
                width = "full",
                order = 5
            }
        }
    }
end