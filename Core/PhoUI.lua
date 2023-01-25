------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local P, H, O, U, I = ...
local LibSharedMedia = LibStub("LibSharedMedia-3.0")
PhoUI = LibStub("AceAddon-3.0"):NewAddon("PhoUI", "AceConsole-3.0", "AceHook-3.0")

PhoUI.Configs = {}

function PhoUI:OnInitialize()
    self.TextBorder = {
        ["OUTLINE"] = "OUTLINE",
        ["THICKOUTLINE"] = "THICKOUTLINE",
        ["MONOCHROME"] = "MONOCHROME",
        ["MONOCHROME,OUTLINE"] = "MONOCHROME OUTLINE"
    }

    _G.PhoUICharDB = _G.PhoUICharDB or {}
    _G.PhoUICharChatDB = _G.PhoUICharChatDB or {}
    _G.PhoUICharChatCMDDB = _G.PhoUICharChatCMDDB or {}

    self.Options = {
        profile = {
            minimap_icon = {
                hide = false
            },
            general = {
                welcome_message = true,
                font = "Gotham-Narrow-Medium",
                disable_font = true,
                theme = "blizzard",
                minimap_icon = false,
            },
            unitframes = {
                frame_style = "small",
                chain = "none",
                texture = "default",
                raid_texture = "default",
                classcolor = true,
                classbar = true,
                classportraits = false,
                hitindicator = false,
                rested = false,
                pvpicon = false,
                buff_collapse = true,
                buffsize = 25,
                debuffsize = 20
            },
            chat = {
                style = "custom",
                enable_history = true,
                hide_buttons = true
            },
            actionbar = {
                enable = true,
                style = "full",
                size = 1,
                gryphons = "Faction",
                custom_buttons = true,
                hotkey = true,
                macro = true,
                text_size = 10,
                short_hotkey = true,
                menu_style = "custom",
                menu_enable = true,
                menu_hide = true,
                statusbar = true
            },
            castbar = {
                enable = true,
                icon = true,
                timer = true,
                hide_anim = true
            },
            miscellaneous = {
                auto_sell = true,
                auto_repair = "default",
                auto_invite = true,
                auto_invite_message = "inv",
                pvp_surrender = "gg",
                pvp_tabbinder = true
                --auto
            },
            minimap = {
                enable = true,
                shape = "round",
                show_header = true,
                header_style = "default",
                hide_icons = true
            },
            editmode = {
                durability = {
                    point = "CENTER",
                    x = 0,
                    y = 0,
                },
                vehicle = {
                    point = "CENTER",
                    x = 0,
                    y = 0,
                },
                statustracking = {
                    point = "BOTTOM",
                    x = 0,
                    y = 0,
                }
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
    if not self.db.profile.general.disable_font then
        self.FONT = LibSharedMedia:Fetch("font", self.db.profile.general.font)
    end

    if self.THEME == "dark" then
        self.DARK_MODE = true
    else
        self.DARK_MODE = false
    end

    -- Manipulate Minimap Icon State
    self.db.profile.minimap_icon.hide = self.db.profile.general.minimap_icon

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

    local function PurgeVarKey(t, k)
        t[k] = nil
        local c = 42
        repeat
            if t[c] == nil then t[c] = nil end
            c = c + 1

        until issecurevariable(t, k)
    end

    if self.db.profile.general.welcome_message then
        print("|cff8788EE[Welcome to PhoUI]|cffffffff You are using Version: " .. GetAddOnMetadata(p, "Version") .. ". Open Settings with /pho")
    end
end

function PhoUI:OnEnable()
    local LibDBIcon = LibStub("LibDBIcon-1.0")
    local LibDataBroker = LibStub("LibDataBroker-1.1")

    local MinimapIcon = LibDataBroker:NewDataObject("PhoUI", {
        type = "launcher",
		icon = "Interface\\AddOns\\PhoUI\\Media\\Textures\\Logo",
		OnTooltipShow = function(tooltip) tooltip:AddLine("PhoUI") end,
		OnClick = function()
			local config = LibStub("AceConfigDialog-3.0")

			if config.OpenFrames["PhoUI"] then
				config:Close("PhoUI")
			else
				config:Open("PhoUI")
			end
		end,
    })
    LibDBIcon:Register("PhoUI", MinimapIcon, self.db.profile.minimap_icon)

end