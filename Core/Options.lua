------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Options")

function Module:OnEnable()

    local function CreatePopupDialog(Title, Text)
        StaticPopupDialogs["PhoUI_" .. Title] = {
            text = Title,
            button1 = "Close",
            hasEditBox = 1,
            hideOnEscape = 1,
            timeout = 0,
            OnShow = function(self)
                local EditBox = self.editBox
                EditBox:SetText(Text)
                EditBox:HighlightText()
                EditBox:SetFocus()
            end
        }
    end

    CreatePopupDialog("Twitch", "https://www.twitch.tv/phoyk")
    CreatePopupDialog("Github", "https://github.com/mabu95/PhoUI")
    CreatePopupDialog("Curseforge", "https://www.curseforge.com/wow/addons/phoui/")
    CreatePopupDialog("Twitter", "https://twitter.com/phoykwow")
    CreatePopupDialog("Wago", "https://www.curseforge.com/wow/addons/phoui/")
    CreatePopupDialog("WoWInterface", "https://twitter.com/phoykwow")

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
            desc = {
                type = "description",
                fontSize = "medium",
                name = "I originally created the addon for myself. Any form of support is appreciated.",
                order = 1
            },
            spacer1 = {
                name = "",
                type = "description",
                fontSize = "medium",
                order = 2,
            },
            twitch = {
                name = "Twitch",
                type = "execute",
                width = 1.18,
                order = 3,
                func = function()
                    StaticPopup_Show("PhoUI_Twitch", "Twitch")
                end
            },
            Curseforge = {
                name = "Curseforge",
                type = "execute",
                width = 1.18,
                order = 4,
                func = function()
                    StaticPopup_Show("PhoUI_Curseforge", "Curseforge")
                end
            },
            Wago = {
                name = "Wago",
                type = "execute",
                width = 1.18,
                order = 5,
                func = function()
                    StaticPopup_Show("PhoUI_Wago", "Wago")
                end
            },
            WoWInterface = {
                name = "WoWInterface",
                type = "execute",
                width = 1.18,
                order = 6,
                func = function()
                    StaticPopup_Show("PhoUI_WoWInterface", "WoWInterface")
                end
            },
            twitter = {
                name = "Twitter",
                type = "execute",
                width = 1.18,
                order = 7,
                func = function()
                    StaticPopup_Show("PhoUI_Twitter", "Twitter")
                end
            },
            Github = {
                name = "Github",
                type = "execute",
                width = 1.18,
                order = 8,
                func = function()
                    StaticPopup_Show("PhoUI_Github", "Github")
                end
            },
            spacer2 = {
                name = "",
                type = "description",
                fontSize = "medium",
                order = 9,
            },
            Reload = {
                name = "Reload UI",
                type = "execute",
                width = "full",
                order = 10,
                func = function()
                    ReloadUI()
                end
            },
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
    PhoUI:RegisterChatCommand("rl", function(msg)
        ReloadUI()
    end)
end