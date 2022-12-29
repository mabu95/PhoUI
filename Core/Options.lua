------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Options")

function Module:OnEnable()
    local General = PhoUI:GetModule("Core.Configs.General")
    local Unitframes = PhoUI:GetModule("Core.Configs.Unitframes")
    local Actionbar = PhoUI:GetModule("Core.Configs.Actionbar")

    local Config = {
        get = function(info)
            return PhoUI.db.profile[info[1]][info[#info]]
        end,
        set = function(info, value)
            PhoUI.db.profile[info[1]][info[#info]] = value
        end,
        type = "group",
        args = {
            general = General.Config,
            unitframes = Unitframes.Config,
            actionbar = Actionbar.Config
        }
    }

    LibStub("AceConfig-3.0"):RegisterOptionsTable("PhoUI", Config)
    local PhoUIOptions = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PhoUI")

    function SlashCommand(msg)
        InterfaceOptionsFrame_OpenToCategory(PhoUIOptions)
        InterfaceOptionsFrame_OpenToCategory(PhoUIOptions)
    end

    PhoUI:RegisterChatCommand("pho", SlashCommand)
    PhoUI:RegisterChatCommand("Pho", SlashCommand)
end