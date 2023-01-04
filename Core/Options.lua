------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Options")

function Module:OnEnable()

    local About = PhoUI:GetModule("Core.Configs.About")
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
            logo = {
                name = "|cff8788EEPho|cffffffffUI" .. " v" .. GetAddOnMetadata("PhoUI", "Version"),
                order = 1,
                type = "description",
                fontSize = "large",
                image = "Interface\\AddOns\\PhoUI\\Media\\Textures\\Logo"
            },
            break1 = {
                name = "",
                type = "header",
                order = 2
            },
            desc = {
                name = "I responded to my needs and created a perfect UI for me. You can use the options to customize it as you like. Only used blizzard elements to stay as close as possible to the original UI.",
                type = "description",
                order = 3,
            },
            break2 = {
                name = "",
                type = "header",
                order = 4
            },
            Reload = {
                name = "Reload UI",
                type = "execute",
                order = 5,
                func = function()
                    ReloadUI()
                end
            },
            about = About.Config,
            general = General.Config,
            unitframes = Unitframes.Config,
            actionbar = Actionbar.Config
        }
    }

    LibStub("AceConfig-3.0"):RegisterOptionsTable("PhoUI", Config)
    local PhoUIOptions = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PhoUI")

    function SlashCommand(msg)
        --InterfaceOptionsFrame_OpenToCategory(PhoUIOptions)
       -- InterfaceOptionsFrame_OpenToCategory(PhoUIOptions)
       LibStub("AceConfigDialog-3.0"):Open("PhoUI")
    end

    PhoUI:RegisterChatCommand("pho", SlashCommand)
    PhoUI:RegisterChatCommand("Pho", SlashCommand)
    PhoUI:RegisterChatCommand("rl", function(msg)
        ReloadUI()
    end)
    LibStub("AceConfigDialog-3.0"):SetDefaultSize("PhoUI", 550, 640)

    local config = LibStub("AceConfigDialog-3.0")
    
end