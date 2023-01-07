------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Targetframe")

function Module:OnEnable()
    local db = PhoUI.db.profile.unitframes

    if db.frame_style ~= "blizzard" then
        PhoUI:CreateLevelFrame("TargetLevelFrame", TargetFrame, TargetFrame:GetFrameLevel() + 10, {"BOTTOMRIGHT", -22, 16})
        PhoUI:CreateLevelFrame("FocusLevelFrame", FocusFrame, FocusFrame:GetFrameLevel() + 10, {"BOTTOMRIGHT", -22, 16})
    end

    local function SetFrameTexture(Frame)
        --Frame.healthbar:SetStatusBarTexture(PhoUI.TEXTURE_PATH .. "Statusbar_Default_White")

        --print(Frame.healthbar.HealthBarTexture)
        --local tex = Frame.healthbar.HealthBarTexture
        --tex:SetTexture(PhoUI.TEXTURE_PATH .. "Unitframes")
        --tex:SetTexCoord( 375/512, 511/512, 40/512, 71/512 )
        --Frame.healthbar:SetStatusBarTexture(tex)
        --Frame.healthbar.HealthBarTexture:SetTexCoord( 375/512, 511/512, 40/512, 71/512 )

        if db.frame_style == "big" then
            PhoUI:SetAtlas(Frame.TargetFrameContainer.FrameTexture, "TargetFrame_Big", true)
            PhoUI:SetAtlas(Frame.TargetFrameContainer.Flash, "TargetFrame_Big_Flash", true)
            Frame.TargetFrameContainer.Flash:ClearAllPoints()
            Frame.TargetFrameContainer.Flash:SetPoint("CENTER", 0, 1)
        else
            PhoUI:SetAtlas(Frame.TargetFrameContainer.FrameTexture, "TargetFrame_Small", true)
            PhoUI:SetAtlas(Frame.TargetFrameContainer.Flash, "TargetFrame_Small_Flash", true)
            Frame.TargetFrameContainer.Flash:ClearAllPoints()
            Frame.TargetFrameContainer.Flash:SetPoint("CENTER", 1, 2)

            if Frame.NameBackground == nil then
                Frame.NameBackground = Frame:CreateTexture(nil, "BORDER", nil, -6)
                Frame.NameBackground:SetDesaturated(1)
                Frame.NameBackground:SetAtlas("UI-HUD-UnitFrame-Player-PortraitOn-Bar-Health")
                --Frame.NameBackground:SetTexture(PhoUI.TEXTURE_PATH .. "Statusbar_Default")
                Frame.NameBackground:SetSize(133, 18)
                Frame.NameBackground:SetPoint("TOPLEFT", 24, -26)
            end
        end

        if Frame.Background == nil then
            Frame.Background = Frame:CreateTexture(nil, "BORDER", nil, -7)
            Frame.Background:SetSize(134, 44)
            Frame.Background:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -75, -27)
            Frame.Background:SetColorTexture(0, 0, 0, .6)
        end
    end

    local function UpdateFrame(Frame)
        if not Frame:IsShown() then return end
        if db.frame_style == "blizzard" then return end

        Frame.healthbar.HealthBarMask:Hide()
        Frame.manabar.ManaBarMask:Hide()
        Frame.healthbar.OverAbsorbGlow:Hide()

        --Frame.healthbar:SetStatusBarTexture(PhoUI.TEXTURE_PATH .. "Statusbar_Default_White")
        --Frame.healthbar:GetStatusBarTexture():SetAtlas("UI-HUD-UnitFrame-Player-PortraitOff-Bar-Health-Status")

        if db.frame_style == "big" then
            Frame.healthbar:SetSize(134, 33)
            Frame.healthbar:ClearAllPoints()
            Frame.healthbar:SetPoint("TOPRIGHT", -74, -27)
            Frame.healthbar.LeftText:SetFont(PhoUI.DEFAULT_FONT, 10, "OUTLINE")
            Frame.healthbar.LeftText:SetPoint("LEFT", Frame.healthbar, 4, 0)
            Frame.healthbar.RightText:SetFont(PhoUI.DEFAULT_FONT, 10, "OUTLINE")
            Frame.healthbar.RightText:SetPoint("RIGHT", Frame.healthbar, -15, 0)

            Frame.manabar:SetSize(134, 12)
            Frame.manabar:ClearAllPoints()
            Frame.manabar:SetPoint("TOPRIGHT", -75, -60)
            Frame.manabar.LeftText:SetFont(PhoUI.DEFAULT_FONT, 10, "OUTLINE")
            Frame.manabar.LeftText:SetPoint("LEFT", Frame.manabar, 5, 0)
            Frame.manabar.RightText:SetFont(PhoUI.DEFAULT_FONT, 10, "OUTLINE")
        else
            Frame.healthbar:SetSize(134, 12)
            Frame.healthbar:ClearAllPoints()
            Frame.healthbar:SetPoint("TOPRIGHT", -74, -46)
            Frame.healthbar.LeftText:SetFont(PhoUI.DEFAULT_FONT, 10, "OUTLINE")
            Frame.healthbar.LeftText:SetPoint("LEFT", Frame.healthbar, 4, 0)
            Frame.healthbar.RightText:SetFont(PhoUI.DEFAULT_FONT, 10, "OUTLINE")
            Frame.healthbar.RightText:SetPoint("RIGHT", Frame.healthbar, -15, 0)

            Frame.manabar:SetSize(134, 12)
            Frame.manabar:ClearAllPoints()
            Frame.manabar:SetPoint("TOPRIGHT", -75, -60)
            Frame.manabar.LeftText:SetFont(PhoUI.DEFAULT_FONT, 10, "OUTLINE")
            Frame.manabar.LeftText:SetPoint("LEFT", Frame.manabar, 5, 0)
            Frame.manabar.RightText:SetFont(PhoUI.DEFAULT_FONT, 10, "OUTLINE")
        end
    end

    local function CheckClassification(Frame)
        if db.frame_style ~= "blizzard" then
            Frame.TargetFrameContent.TargetFrameContentMain.ReputationColor:Hide()
            Frame.TargetFrameContent.TargetFrameContentMain:SetFrameLevel(Frame.TargetFrameContainer:GetFrameLevel() - 2)
            SetFrameTexture(Frame)
        end

        if PhoUI.DARK_MODE and Frame.TargetFrameContainer.BossPortraitFrameTexture ~= nil then
            Frame.TargetFrameContainer.BossPortraitFrameTexture:SetDesaturated(1)
            Frame.TargetFrameContainer.BossPortraitFrameTexture:SetVertexColor(0.2, 0.2, 0.2)

            Frame.TargetFrameContainer.FrameTexture:SetDesaturated(1)
            Frame.TargetFrameContainer.FrameTexture:SetVertexColor(0.2, 0.2, 0.2)
        end

        Frame.TargetFrameContent.TargetFrameContentContextual.PrestigePortrait:ClearAllPoints()
        Frame.TargetFrameContent.TargetFrameContentContextual.PrestigePortrait:SetPoint("RIGHT", Frame.TargetFrameContent.TargetFrameContentContextual, 0, 0)
        Frame.TargetFrameContent.TargetFrameContentContextual.PrestigePortrait:SetScale(0.8)
        
        if not db.pvpicon then
            Frame.TargetFrameContent.TargetFrameContentContextual.PrestigePortrait:Hide()
            Frame.TargetFrameContent.TargetFrameContentContextual.PrestigeBadge:Hide()
        end

        if db.frame_style ~= "blizzard" then
            local Name = Frame.TargetFrameContent.TargetFrameContentMain.Name
            Name:ClearAllPoints()
            Name:SetJustifyH("CENTER")
            Name:SetFont(PhoUI.DEFAULT_FONT, 10, "OUTLINE")

            if db.frame_style == "big" then
                Name:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -97, -13)
            else
                Name:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -97, -29)
                Name:SetParent(Frame)
                if (not UnitPlayerControlled(Frame.unit) and UnitIsTapDenied(Frame.unit)) then
                    Frame.NameBackground:SetVertexColor(0.5, 0.5, 0.5);
                else
                    local r,g,b = UnitSelectionColor(Frame.unit)
                    Frame.NameBackground:SetVertexColor(r, g, b, 1);
                end
            end
        end
    end

    local function TargetFrame_CheckLevel(Frame)
        local LevelText = Frame.TargetFrameContent.TargetFrameContentMain.LevelText
        LevelText:ClearAllPoints();
        LevelText:SetParent(TargetLevelFrame)
        LevelText:SetPoint("CENTER", TargetLevelFrame, 0, 0)

        local HighLevelTexture = Frame.TargetFrameContent.TargetFrameContentContextual.HighLevelTexture
        HighLevelTexture:SetParent(TargetLevelFrame)
        HighLevelTexture:ClearAllPoints()
        HighLevelTexture:SetPoint("CENTER", 0, 0)
    end

    local function FocusFrame_CheckLevel(Frame)
        local LevelText = Frame.TargetFrameContent.TargetFrameContentMain.LevelText
        LevelText:ClearAllPoints();
        LevelText:SetParent(FocusLevelFrame)
        LevelText:SetPoint("CENTER", FocusLevelFrame, 0, 0)

        local HighLevelTexture = Frame.TargetFrameContent.TargetFrameContentContextual.HighLevelTexture
        HighLevelTexture:SetParent(FocusLevelFrame)
        HighLevelTexture:ClearAllPoints()
        HighLevelTexture:SetPoint("CENTER", 0, 0)
    end

    local function TargetFrameToT_Update()
        if db.frame_style == "blizzard" then
            TargetFrameToT.FrameTexture:SetDesaturated(1)
            TargetFrameToT.FrameTexture:SetVertexColor(0.2, 0.2, 0.2)
            return
        end

        if TargetFrameToT.PhoUI == nil then
            local Healthbar = TargetFrameToT.HealthBar
            local Manabar = TargetFrameToT.ManaBar
            local Name = TargetFrameToT.Name
            PhoUI:HideFrame(Healthbar.HealthBarMask)
            PhoUI:HideFrame(Manabar.ManaBarMask)
    
            PhoUI:SetAtlas(TargetFrameToT.FrameTexture, "ToTFrame", true)
            TargetFrameToT.FrameTexture:SetDrawLayer("OVERLAY")
    
            Healthbar:SetFrameLevel(TargetFrameToT:GetFrameLevel() - 1)
            Healthbar:SetSize(74, 6)
            Healthbar:ClearAllPoints()
            Healthbar:SetPoint("TOPLEFT", TargetFrameToT, "TOPLEFT", 41, -24)
    
            Manabar:SetFrameLevel(TargetFrameToT:GetFrameLevel() - 1)
            Manabar:SetSize(76, 6)
            Manabar:ClearAllPoints()
            Manabar:SetPoint("TOPLEFT", Healthbar, "BOTTOMLEFT", -2, -2)
    
            if Healthbar.BG == nil then
                Healthbar.BG = Healthbar:CreateTexture(nil, "BACKGROUND")
                Healthbar.BG:SetSize(74, 9)
                Healthbar.BG:SetPoint("CENTER", 0, 0)
                Healthbar.BG:SetColorTexture(0, 0, 0, .6)
            end
    
            if Manabar.BG == nil then
                Manabar.BG = Manabar:CreateTexture(nil, "BACKGROUND")
                Manabar.BG:SetSize(76, 9)
                Manabar.BG:SetPoint("CENTER", 0, 0)
                Manabar.BG:SetColorTexture(0, 0, 0, .6)
            end
    
            Name:ClearAllPoints()
            Name:SetPoint("TOPLEFT", 42, -10)
            Name:SetJustifyH("CENTER")
            Name:SetFont(PhoUI.DEFAULT_FONT, 9, "OUTLINE")
    
            if TargetFrameToT.NameBG == nil then
                TargetFrameToT.NameBG = TargetFrameToT:CreateTexture(nil, "BACKGROUND")
                TargetFrameToT.NameBG:SetSize(82, 15)
                TargetFrameToT.NameBG:SetPoint("TOPLEFT", 34, -8)
                TargetFrameToT.NameBG:SetColorTexture(0, 0, 0, .6)
            end

            TargetFrameToT.PhoUI = true
        end
    end

    local function FocusFrameToT_Update()
        if db.frame_style == "blizzard" then
            FocusFrameToT.FrameTexture:SetDesaturated(1)
            FocusFrameToT.FrameTexture:SetVertexColor(0.2, 0.2, 0.2)
            return
        end

        if TargetFrameToT.PhoUI == nil then
            local Healthbar = FocusFrameToT.HealthBar
            local Manabar = FocusFrameToT.ManaBar
            local Name = FocusFrameToT.Name
            PhoUI:HideFrame(Healthbar.HealthBarMask)
            PhoUI:HideFrame(Manabar.ManaBarMask)

            PhoUI:SetAtlas(FocusFrameToT.FrameTexture, "ToTFrame", true)
            FocusFrameToT.FrameTexture:SetDrawLayer("OVERLAY")

            Healthbar:SetFrameLevel(FocusFrameToT:GetFrameLevel() - 1)
            Healthbar:SetSize(74, 6)
            Healthbar:ClearAllPoints()
            Healthbar:SetPoint("TOPLEFT", FocusFrameToT, "TOPLEFT", 41, -24)

            Manabar:SetFrameLevel(FocusFrameToT:GetFrameLevel() - 1)
            Manabar:SetSize(76, 6)
            Manabar:ClearAllPoints()
            Manabar:SetPoint("TOPLEFT", Healthbar, "BOTTOMLEFT", -2, -2)

            if Healthbar.BG == nil then
                Healthbar.BG = Healthbar:CreateTexture(nil, "BACKGROUND")
                Healthbar.BG:SetSize(74, 9)
                Healthbar.BG:SetPoint("CENTER", 0, 0)
                Healthbar.BG:SetColorTexture(0, 0, 0, .6)
            end

            if Manabar.BG == nil then
                Manabar.BG = Manabar:CreateTexture(nil, "BACKGROUND")
                Manabar.BG:SetSize(76, 9)
                Manabar.BG:SetPoint("CENTER", 0, 0)
                Manabar.BG:SetColorTexture(0, 0, 0, .6)
            end

            Name:ClearAllPoints()
            Name:SetPoint("TOPLEFT", 42, -10)
            Name:SetJustifyH("CENTER")
            Name:SetFont(PhoUI.DEFAULT_FONT, 9, "OUTLINE")

            if FocusFrameToT.NameBG == nil then
                FocusFrameToT.NameBG = FocusFrameToT:CreateTexture(nil, "BACKGROUND")
                FocusFrameToT.NameBG:SetSize(82, 15)
                FocusFrameToT.NameBG:SetPoint("TOPLEFT", 34, -8)
                FocusFrameToT.NameBG:SetColorTexture(0, 0, 0, .6)
            end
            TargetFrameToT.PhoUI = true
        end
    end

    hooksecurefunc(TargetFrame, "Update", UpdateFrame)
    hooksecurefunc(TargetFrame, "CheckClassification", CheckClassification)
    hooksecurefunc(TargetFrameToT, "Update", TargetFrameToT_Update)

    if db.frame_style ~= "blizzard" then
        hooksecurefunc(TargetFrame, "CheckLevel", TargetFrame_CheckLevel)
    end

    hooksecurefunc("TargetFrame_UpdateBuffAnchor", function(_, Buff)
        Buff:SetSize(db.buffsize, db.buffsize)
    end)

    hooksecurefunc("TargetFrame_UpdateDebuffAnchor", function(_, Debuff)
        Debuff:SetSize(db.debuffsize, db.debuffsize)
        if Debuff.Border ~= nil then
            Debuff.Border:SetPoint("TOPLEFT", -1, 0)
            Debuff.Border:SetPoint("BOTTOMRIGHT", 0, 0)
        end
    end)

    hooksecurefunc(FocusFrame, "Update", UpdateFrame)
    hooksecurefunc(FocusFrame, "CheckClassification", CheckClassification)
    hooksecurefunc(FocusFrameToT, "Update", FocusFrameToT_Update)

    if db.frame_style ~= "blizzard" then
        hooksecurefunc(FocusFrame, "CheckLevel", FocusFrame_CheckLevel)
    end
end