------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("BuffsDebuffs")

function Module:OnEnable()
    local BuffCollapse = PhoUI.db.profile.unitframes.buff_collapse

    local DebuffTypeColor       = {};
    DebuffTypeColor["none"]     = { r = 0.80, g = 0, b = 0 };
    DebuffTypeColor["Magic"]	= { r = 0.20, g = 0.60, b = 1.00 };
    DebuffTypeColor["Curse"]	= { r = 0.60, g = 0.00, b = 1.00 };
    DebuffTypeColor["Disease"]	= { r = 0.60, g = 0.40, b = 0 };
    DebuffTypeColor["Poison"]	= { r = 0.00, g = 0.60, b = 0 };
    DebuffTypeColor[""]	        = DebuffTypeColor["none"];

    local HOOKED_BUFFS = {}
    local function UpdateBuffs(self)
        for Frame, _ in pairs(self.activeObjects) do
            if not HOOKED_BUFFS[Frame] then
                HOOKED_BUFFS[Frame] = true

                Frame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

                if not Frame.PhoUIBorder then
                    local PhoUIBorder =  Frame.PhoUIBorder or Frame:CreateTexture("Border")
                    PhoUI:SetAtlas(PhoUIBorder, "Button_Border")
                    PhoUIBorder:SetPoint("TOPLEFT", Frame, "TOPLEFT", -1.2, 1.2)
                    PhoUIBorder:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", 1.2, -1.2)

                    local Backdrop = CreateFrame("Frame", "Backdrop", Frame, "BackdropTemplate")
                    Backdrop:SetBackdrop({
                        bgFile = "",
                        edgeFile = PhoUI.TEXTURE_PATH .. "Backdrop",
                        tile = false, tileSize = 0,
                        edgeSize = 3,
                        insets = { left = 3, right = 3, top = 3, bottom = 3 }
                    })
                    Backdrop:SetBackdropBorderColor(0, 0, 0, 1)
                    Backdrop:SetPoint("TOPLEFT", Frame, "TOPLEFT", -3, 3)
                    Backdrop:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", 3, -3)
                    Backdrop:SetFrameLevel(Frame:GetFrameLevel() - 1)

                    if Frame.Border then

                    end
                end
            end
        end
    end

    local function StyleBuffAndDebuff(Frame, Type)
        if IsAddOnLoaded("BlizzBuffsFacade") then return end

        local Duration = Frame.duration
        local Count = Frame.count
        local Icon = Frame.Icon

        Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

        if Duration then
            Duration:SetFont(PhoUI.DEFAULT_FONT, 11, "OUTLINE")
            Duration:ClearAllPoints()
            Duration:SetDrawLayer("OVERLAY")
            Duration:SetPoint("CENTER", Frame, "BOTTOM", 0, 16)
        end

        if Count then
            Count:SetFont(PhoUI.DEFAULT_FONT, 11, "OUTLINE")
        end

        if not Frame.PhoUI then
            local Border = Frame:CreateTexture()
            PhoUI:SetAtlas(Border, "Button_Border")
            Border:SetPoint("TOPLEFT", Icon, "TOPLEFT", -1.5, 1.5)
            Border:SetPoint("BOTTOMRIGHT", Icon, "BOTTOMRIGHT", 1.5, -1.5)

            local Backdrop = CreateFrame("Frame", "Backdrop", Frame, "BackdropTemplate")
            Backdrop:SetBackdrop({
                bgFile = "",
                edgeFile = PhoUI.TEXTURE_PATH .. "Backdrop",
                tile = false, tileSize = 0,
                edgeSize = 3,
                insets = { left = 3, right = 3, top = 3, bottom = 3 }
            })
            Backdrop:SetBackdropBorderColor(0, 0, 0, 1)
            Backdrop:SetPoint("TOPLEFT", Icon, "TOPLEFT", -3, 3)
            Backdrop:SetPoint("BOTTOMRIGHT", Icon, "BOTTOMRIGHT", 3, -3)
            Backdrop:SetFrameLevel(Frame:GetFrameLevel() - 1)

            if Type == "Debuff" then
                if Frame.buttonInfo then
                    local DebuffType = Frame.buttonInfo.DebuffType ~= nil and Frame.buttonInfo.DebuffType or "none"
                    local Color = DebuffTypeColor[DebuffType]
                    Border:SetVertexColor(Color.r, Color.g, Color.b)
                    Frame.Border:Hide()
                end
            end
            
            Frame.PhoUI = true
        end
    end

    local function UpdateAuras()
        local Buffs = { BuffFrame.AuraContainer:GetChildren() }
        local Debuffs = { DebuffFrame.AuraContainer:GetChildren() }

        for index, buff in pairs(Buffs) do
            local Frame = select(index, BuffFrame.AuraContainer:GetChildren())
            StyleBuffAndDebuff(Frame, "Buff")
        end

        for index, debuff in pairs(Debuffs) do
            local Frame = select(index, DebuffFrame.AuraContainer:GetChildren())
            StyleBuffAndDebuff(Frame, "Debuff")
        end
    end

    if PhoUI.DARK_MODE then
        for _, p in pairs(TargetFrame.auraPools.pools) do
            hooksecurefunc(p, "Acquire", UpdateBuffs)
        end
        for _, p in pairs(FocusFrame.auraPools.pools) do
            hooksecurefunc(p, "Acquire", UpdateBuffs)
        end
    end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:RegisterUnitEvent("UNIT_AURA", "player")
    self.EventFrame:RegisterEvent("WEAPON_ENCHANT_CHANGED")
    self.EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")

    self.EventFrame:SetScript("OnEvent", function(s, e, ...)
        if BuffCollapse then
            BuffFrame.CollapseAndExpandButton:Hide()
        end
        if PhoUI.DARK_MODE then
            UpdateAuras()
        end
    end)
end