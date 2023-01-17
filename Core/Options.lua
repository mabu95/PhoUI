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
    local Castbar = PhoUI:GetModule("Core.Configs.Castbar")
    local Minimap = PhoUI:GetModule("Core.Configs.Minimap")
    local Miscellaneous = PhoUI:GetModule("Core.Configs.Miscellaneous")

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
            actionbar = Actionbar.Config,
            castbar = Castbar.Config,
            miscellaneous = Miscellaneous.Config,
            chat = PhoUI.Configs.Chat,
            minimap = Minimap.Config,
            options = LibStub("AceDBOptions-3.0"):GetOptionsTable(PhoUI.db)
        }
    }

    LibStub("AceConfig-3.0"):RegisterOptionsTable("PhoUI", Config)

    function SlashCommand(msg)
       LibStub("AceConfigDialog-3.0"):Open("PhoUI")
    end

    PhoUI:RegisterChatCommand("pho", SlashCommand)
    PhoUI:RegisterChatCommand("Pho", SlashCommand)
    PhoUI:RegisterChatCommand("rl", function(msg)
        ReloadUI()
    end)
    LibStub("AceConfigDialog-3.0"):SetDefaultSize("PhoUI", 695, 640)

    GameMenuFrame.Header:Hide()
    local MUIButton = CreateFrame("Button", "MUIButton", GameMenuFrame, "UIPanelButtonTemplate")
    MUIButton:SetSize(145, 20)
    MUIButton:SetText("|cff8788EEPho|cffffffffUI|r")
    MUIButton:ClearAllPoints()
    MUIButton:SetPoint("TOP", 0, -11)
    MUIButton:RegisterForClicks("AnyUp")
    MUIButton:SetScript("OnClick", function()
        LibStub('AceConfigDialog-3.0'):Open('PhoUI')
        ToggleGameMenu()
    end)

end
