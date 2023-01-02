------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local LibSharedMedia = LibStub("LibSharedMedia-3.0")

PhoUI = LibStub("AceAddon-3.0"):NewAddon("PhoUI", "AceConsole-3.0")

function PhoUI:OnInitialize()
    self.TextBorder = {
        ["OUTLINE"] = "OUTLINE",
        ["THICKOUTLINE"] = "THICKOUTLINE",
        ["MONOCHROME"] = "MONOCHROME",
        ["MONOCHROME,OUTLINE"] = "MONOCHROME OUTLINE"
    }

    self.Options = {
        profile = {
            general = {
                welcome_message = true,
                font = "Gotham-Narrow-Medium",
                theme = "blizzard"
            },
            unitframes = {
                frame_style = "big",
                chain = "none",
                classcolor = true,
                classbar = true,
                hitindicator = false,
                rested = false,
                pvpicon = false,
                buff_collapse = false,
                buffsize = 25,
                debuffsize = 20
            },
            actionbar = {
                enable = true,
                gryphons = true,
                style = "full",
                menu_enable = true,
                menu_hide = false,
                short_keybinds = true,
                text_size = 10,
                hotkey = true,
                macro = true
            }
        }
    }

    self.MEDIA_PATH = "Interface\\AddOns\\PhoUI\\Media\\"
    self.TEXTURE_PATH = "Interface\\AddOns\\PhoUI\\Media\\Textures\\"

    LibSharedMedia:Register("font", "Gotham-Narrow-Medium", [[Interface\Addons\PhoUI\Media\Fonts\Gotham-Narrow-Medium.ttf]])
    LibSharedMedia:Register("statusbar", "PhoUI", [[Interface\Addons\PhoUI\Media\Textures\Statusbar]])
    LibSharedMedia:Register("statusbar", "Dragonflight", [[Interface\Addons\PhoUI\Media\Textures\Statusbar_Default]])
    LibSharedMedia:Register("statusbar", "Dragonflight White", [[Interface\Addons\PhoUI\Media\Textures\Statusbar_Default_White]])


    self.LibSharedMedia = LibSharedMedia
    self.db = LibStub("AceDB-3.0"):New("PHOUIDB", self.Options, true)

    self.THEME = self.db.profile.general.theme
    self.DEFAULT_FONT = LibSharedMedia:Fetch("font", self.db.profile.general.font)

    if self.THEME == "dark" then
        self.DARK_MODE = true
    else
        self.DARK_MODE = false
    end

    --self.db:ResetDB()

    function self:HideFrame(Frame)
        if Frame ~= nil then
            Frame:Hide()
            hooksecurefunc(Frame, "Show", function() Frame:Hide() end)
        end
    end

    function self:SetAtlas(Frame, Texture, Size)
        local List = PhoUI.AtlasList

        if List[Texture] then
            local Info = List[Texture]
            Frame:SetTexture(Info.Texture)
            Frame:SetTexCoord(unpack(Info.TexCoord))

            if self.THEME == "dark" then
                Frame:SetDesaturated(1)
                Frame:SetVertexColor(0.2, 0.2, 0.2)
            end

            if Size then Frame:SetSize(unpack(Info.Size)) end
        end
    end

    function self:SetButtonAtlas(Button, TextureType, Texture)
        local List = PhoUI.AtlasList

        if List[Texture] then
            local Info = List[Texture]

            if TextureType == "NormalTexture" then
                Button:SetNormalTexture(Info.Texture)
                Button:GetNormalTexture():SetTexCoord(unpack(Info.TexCoord))
            elseif TextureType == "PushedTexture" then

            elseif TextureType == "HighlightTexture" then
                
            end
        end
    end

    function self:GetTexture(TextureName)
        return LibSharedMedia:Fetch("statusbar", TextureName)
    end

    function self:CreateLevelFrame(Name, Parent, FrameLevel, Point)
        if _G[Name] == nil then
            local LevelFrame = CreateFrame("Frame", Name, Parent)
            LevelFrame:SetSize(28, 28)
            LevelFrame:SetPoint(unpack(Point))
            LevelFrame:SetFrameLevel(FrameLevel)
            LevelFrame.Border = LevelFrame:CreateTexture(nil, "BORDER")
            self:SetAtlas(LevelFrame.Border, "Level", true)
            LevelFrame.Border:SetAllPoints()
        end
    end

    if self.db.profile.general.welcome_message then
        print("|cff8788EE[Welcome to PhoUI]|cffffffff You are using Version: " .. GetAddOnMetadata(p, "Version") .. ". Open Settings with /pho")
    end
end