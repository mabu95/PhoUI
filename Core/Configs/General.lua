------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Configs.General")

function Module:OnEnable()
    self.Config = {
        name = "General",
        type = "group",
        order = 1,
        args = {
            header = {
                name = "General Options",
                type = "header",
                order = 1
            },
            welcome_message = {
                name = "PhoUI Welcome Message",
                desc = "Show Welcome Message in Chat",
                type = "toggle",
                width = "full",
                order = 2
            },
            header_theme = {
                name = "Theme Options",
                type = "header",
                order = 3
            },
            theme = {
                name = "Theme",
                desc = "Set the Theme for UI",
                type = "select",
                order = 4,
                width = 1.25,
                values = {
                    ["dark"] = "Dark",
                    ["blizzard"] = "Blizzard"
                }
            },
            font = {
                name = "Font",
                desc = "Set Global Font (Restart your Game after)",
                type = "select",
                order = 5,
                width = 1.25,
                values = PhoUI.LibSharedMedia:HashTable("font"),
                dialogControl = "LSM30_Font",
            }
        }
    }
end