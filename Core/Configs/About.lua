------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/bzhWwWnaBc -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Configs.About")

function Module:OnEnable()
    local LinkList = {
        ["Twitch"] = "https://www.twitch.tv/phoyk",
        ["Twitter"] = "https://twitter.com/phoykwow",
        ["Discord"] = "https://discord.gg/bzhWwWnaBc",
        ["Github"] = "https://github.com/mabu95/PhoUI",
        ["Curseforge"] = "https://www.curseforge.com/wow/addons/phoui"
    }

    self.Config = {
        name = "About",
        type = "group",
        order = 1,
        args = {
            header = {
                name = "About PhoUI",
                type = "header",
                dialogControl = "SFX-Header",
                disabled = true,
                order = 1,
            },
            spacer1 = {
                name = "",
                type = "description",
                order = 2
            },
            desc = {
                name = "PhoUI is a unit frame addon, which also brings other functions with it. It makes your WoW UI cleaner and nicer to look at.",
                type = "description",
                order = 3
            },
            spacer2 = {
                name = "",
                type = "header",
                order = 4
            },
            info = {
                name = "For more Informations, Bugs or Issues, please visit one of the sites listed below.",
                type = "description",
                order = 5
            },
            spacer3 = {
                name = " ",
                type = "description",
                order = 6
            },
            version = {
                name = "Version",
                type = "input",
                dialogControl = "SFX-Info-URL",
                disabled = true,
                order = 7,
                get = function() return GetAddOnMetadata("PhoUI", "Version") end,
                set = function() end
            },
            author = {
                name = "Author",
                type = "input",
                dialogControl = "SFX-Info-URL",
                disabled = true,
                order = 8,
                get = function() return GetAddOnMetadata("PhoUI", "Author") end,
                set = function() end
            },
            spacer4 = {
                name = " ",
                type = "description",
                order = 9
            },
        }
    }

    local Order = 10

    for k, v in pairs(LinkList) do
        self.Config.args[k] = {
            type = "input",
            name = k,
            arg = v,
            dialogControl = "SFX-Info-URL",

            order = Order,
            get = function()
                return v
            end,
            set = function() end,
        }
        self.Config.args[k.. "spacer"] = {
            name = "",
            type = "description",
            order = Order
        }
        Order = Order + 1
    end
end