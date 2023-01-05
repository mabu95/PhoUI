------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Configs.Minimap")

function Module:OnEnable()
    self.Config = {
        name = "Minimap",
        type = "group",
        order = 6,
        args = {
            header = {
                name = "Minimap Options",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 1
            },
            size = {
                name = "Minimap Size",
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