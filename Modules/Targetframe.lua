------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Targetframe")

function Module:OnEnable()
    local db = PhoUI.db.profile.unitframes

    PhoUI:CreateLevelFrame("TargetLevelFrame", TargetFrame, TargetFrame:GetFrameLevel() + 10, {"BOTTOMRIGHT", -22, 16})
    PhoUI:CreateLevelFrame("FocusLevelFrame", FocusFrame, FocusFrame:GetFrameLevel() + 10, {"BOTTOMRIGHT", -22, 16})

    local function CheckToTFrame(Frame)
        
    end

    local function UpdateFrame(Frame)
        --CheckToTFrame(Frame)

        Frame.TargetFrameContent.TargetFrameContentMain:SetFrameLevel(Frame.TargetFrameContainer:GetFrameLevel() - 2)

        PhoUI:HideFrame(Frame.healthbar.HealthBarMask)
        PhoUI:HideFrame(Frame.manabar.ManaBarMask)
        PhoUI:HideFrame(Frame.healthbar.OverAbsorbGlow)

        if db.frame_style == "big" then
            PhoUI:SetAtlas(Frame.TargetFrameContainer.FrameTexture, "TargetFrame_Big", true)
            PhoUI:SetAtlas(Frame.TargetFrameContainer.Flash, "TargetFrame_Big_Flash", true)
            Frame.TargetFrameContainer.Flash:ClearAllPoints()
            Frame.TargetFrameContainer.Flash:SetPoint("CENTER", 0, 1)

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
            PhoUI:SetAtlas(Frame.TargetFrameContainer.FrameTexture, "TargetFrame_Small", true)
            PhoUI:SetAtlas(Frame.TargetFrameContainer.Flash, "TargetFrame_Small_Flash", true)
            Frame.TargetFrameContainer.Flash:ClearAllPoints()
            Frame.TargetFrameContainer.Flash:SetPoint("CENTER", 1, 2)

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

        if Frame.Background == nil then
            Frame.Background = Frame:CreateTexture(nil, "BORDER")
            Frame.Background:SetSize(134, 44)
            Frame.Background:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -75, -27)
            Frame.Background:SetColorTexture(0, 0, 0, .6)
        end
    end

    local function CheckClassification(Frame)
        PhoUI:HideFrame(Frame.TargetFrameContent.TargetFrameContentMain.ReputationColor)
        
        Frame.TargetFrameContent.TargetFrameContentContextual.PrestigePortrait:ClearAllPoints()
        Frame.TargetFrameContent.TargetFrameContentContextual.PrestigePortrait:SetPoint("LEFT", PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual, 0, 0)
        Frame.TargetFrameContent.TargetFrameContentContextual.PrestigePortrait:SetScale(0.8)
        if not db.pvpicon then
            PhoUI:HideFrame(Frame.TargetFrameContent.TargetFrameContentContextual.PrestigePortrait)
            PhoUI:HideFrame(Frame.TargetFrameContent.TargetFrameContentContextual.PrestigeBadge)
        end

        local Name = Frame.TargetFrameContent.TargetFrameContentMain.Name
        Name:ClearAllPoints()
        Name:SetJustifyH("CENTER")
        Name:SetFont(PhoUI.DEFAULT_FONT, 10, "OUTLINE")

        if db.frame_style == "big" then
            Name:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -97, -13)
        else
            Name:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -97, -29)
            Name:SetParent(Frame)
        end
    end

    local function TargetFrame_CheckLevel(Frame)
        local LevelText = Frame.TargetFrameContent.TargetFrameContentMain.LevelText
        LevelText:ClearAllPoints();
        LevelText:SetParent(TargetLevelFrame)
        LevelText:SetPoint("CENTER", TargetLevelFrame, 0, 0)
    end

    local function FocusFrame_CheckLevel(Frame)
        local LevelText = Frame.TargetFrameContent.TargetFrameContentMain.LevelText
        LevelText:ClearAllPoints();
        LevelText:SetParent(FocusLevelFrame)
        LevelText:SetPoint("CENTER", FocusLevelFrame, 0, 0)
    end

    local function TargetFrameToT_Update()
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
    end

    local function FocusFrameToT_Update()
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
    end

    hooksecurefunc(TargetFrame, "Update", UpdateFrame)
    hooksecurefunc(TargetFrame, "CheckClassification", CheckClassification)
    hooksecurefunc(TargetFrame, "CheckLevel", TargetFrame_CheckLevel)
    hooksecurefunc(TargetFrameToT, "Update", TargetFrameToT_Update)

    hooksecurefunc(FocusFrame, "Update", UpdateFrame)
    hooksecurefunc(FocusFrame, "CheckClassification", CheckClassification)
    hooksecurefunc(FocusFrame, "CheckLevel", FocusFrame_CheckLevel)
    hooksecurefunc(FocusFrameToT, "Update", FocusFrameToT_Update)
end