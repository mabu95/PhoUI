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
                dialogControl = "SFX-Header",
                disabled = true,
                order = 1
            },
            spacer1 = {
                name = " ",
                type = "description",
                order = 2,
            },
            welcome_message = {
                name = "PhoUI Welcome Message",
                desc = "Show Welcome Message in Chat",
                type = "toggle",
                width = "full",
                order = 3
            },
            spacer2 = {
                name = "",
                type = "header",
                order = 4,
            },
            header_theme = {
                name = "Theme Options",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 5
            },
            theme = {
                name = "Theme",
                desc = "Set the Theme for UI",
                type = "select",
                order = 6,
                width = "full",
                values = {
                    ["dark"] = "Dark",
                    ["blizzard"] = "Blizzard"
                }
            },
            font = {
                name = "Font",
                desc = "Set Global Font (Restart your Game after)",
                type = "select",
                order = 7,
                width = "full",
                values = PhoUI.LibSharedMedia:HashTable("font"),
                dialogControl = "LSM30_Font",
            },
            disable_font = {
                name = "Disable Font",
                desc = "Disable Custom Font and set it to Default",
                type = "toggle",
                width = "full",
                order = 8
            }
        }
    }
end