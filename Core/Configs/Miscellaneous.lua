------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Configs.Miscellaneous")

function Module:OnEnable()
    self.Config = {
        name = "Miscellaneous",
        type = "group",
        order = 6,
        args = {
            header = {
                name = "Miscellaneous",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 1
            },
            -- General
            auto_sell = {
                name = "Auto Sell Trash",
                desc = "Auto Sell Trash Items",
                type = "toggle",
                width = "full",
                order = 2,
            },
            auto_repair = {
                name = "Auto Repair",
                desc = "Auto Repair your Items",
                type = "select",
                width = "full",
                values = {
                    ["no"] = "No auto Repair",
                    ["default"] = "Default",
                    ["guild"] = "Guildbank"
                },
                order = 3
            },
            auto_invite = {
                name = "Auto Invite",
                desc = "Let People Auto Invite you by Message",
                type = "toggle",
                width = "full",
                order = 4,
            },
            auto_invite_message = {
                name = "Auto Invite Message",
                desc = "Set your Keyword to accept Auto Invites",
                type = "input",
                width = "full",
                order = 5
            },
            spacer1 = {
                name = "",
                type = "header",
                order = 6
            },
            -- PVP
            header_pvp = {
                name = "PvP Miscellaneous",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 7
            },
            pvp_surrender = {
                name = "PvP Surrender Text",
                desc = "Set your PvP Keyword to to Surrender Arena Matches",
                type = "input",
                width = "full",
                order = 8
            },
            pvp_tabbinder = {
                name = "PvP Tabbinder",
                desc = "On press Shift only target Arena Players",
                type = "toggle",
                width = "full",
                order = 9
            }
        }
    }
end