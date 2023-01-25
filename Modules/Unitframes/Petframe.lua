local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Unitframes.Petframe")

function Module:OnEnable()
    local db = PhoUI.db.profile.unitframes
    local PetFrame = PetFrame
    local PetFrameTexture = PetFrameTexture
    local PetFrameHealthBarMask = PetFrameHealthBarMask
    local PetFrameManaBarMask = PetFrameManaBarMask
    local PetFrameOverAbsorbGlow = PetFrameOverAbsorbGlow
    local PetName = PetName
    local PetHitIndicator = PetHitIndicator
    local PetFrameHealthBarTextLeft = PetFrameHealthBarTextLeft
    local PetFrameManaBarTextLeft = PetFrameManaBarTextLeft
    local PetFrameManaBarTextRight = PetFrameManaBarTextRight
    local PetFrameHealthBar = PetFrameHealthBar
    local PetFrameManaBar = PetFrameManaBar
    local PetFrameHealthBarTextRight = PetFrameHealthBarTextRight
    local PetFrameFlash = PetFrameFlash
    local PetAttackModeTexture = PetAttackModeTexture

    local function PetFrame_OnEvent()
        if PetFrame.PhoUI then return end
        PhoUI:HideFrame(PetFrameHealthBarMask)
        PhoUI:HideFrame(PetFrameManaBarMask)
        PhoUI:HideFrame(PetFrameOverAbsorbGlow)

        PhoUI:SetAtlas(PetFrameTexture, "ToTFrame", true)
        PetFrameTexture:SetDrawLayer("ARTWORK", 7)

        PetFrameHealthBar:SetFrameLevel(3)
        PetFrameHealthBar:SetSize(74, 7)
        PetFrameHealthBar:ClearAllPoints()
        PetFrameHealthBar:SetPoint("TOPLEFT", PetFrame, "TOPLEFT", 42, -23)

        PetFrameManaBar:SetFrameLevel(3)
        PetFrameManaBar:SetSize(76, 7)
        PetFrameManaBar:ClearAllPoints()
        PetFrameManaBar:SetPoint("TOPLEFT", PetFrameHealthBar, "BOTTOMLEFT", -2, -1)

        PetFrameHealthBarTextLeft:ClearAllPoints()
        PetFrameHealthBarTextLeft:SetPoint("LEFT", PetFrameHealthBar, "LEFT", 3, 0)
        PetFrameHealthBarTextLeft:SetFont(PhoUI.DEFAULT_FONT, 8, "OUTLINE")

        PetFrameHealthBarTextRight:ClearAllPoints()
        PetFrameHealthBarTextRight:SetPoint("RIGHT", PetFrameHealthBar, "RIGHT", -1, 0)
        PetFrameHealthBarTextRight:SetFont(PhoUI.DEFAULT_FONT, 8, "OUTLINE")

        PetFrameManaBarTextLeft:ClearAllPoints()
        PetFrameManaBarTextLeft:SetPoint("LEFT", PetFrameManaBar, "LEFT", 3, 0)
        PetFrameManaBarTextLeft:SetFont(PhoUI.DEFAULT_FONT, 8, "OUTLINE")

        PetFrameManaBarTextRight:ClearAllPoints()
        PetFrameManaBarTextRight:SetPoint("RIGHT", PetFrameManaBar, "RIGHT", -1, 0)
        PetFrameManaBarTextRight:SetFont(PhoUI.DEFAULT_FONT, 8, "OUTLINE")
        
        PetName:ClearAllPoints()
        PetName:SetPoint("TOPLEFT", 42, -10)
        PetName:SetJustifyH("CENTER")
        PetName:SetFont(PhoUI.DEFAULT_FONT, 9, "OUTLINE")

        if PetFrame.Background == nil then
            PetFrame.Background = PetFrame:CreateTexture(nil, "BACKGROUND")
            PetFrame.Background:SetSize(79, 30)
            PetFrame.Background:SetPoint("TOPLEFT", PetFrame, "TOPLEFT", 36, -8)
            PetFrame.Background:SetColorTexture(0, 0, 0, .6)
        end

        PhoUI:SetAtlas(PetFrameFlash, "ToTFrame_Flash", true)
        PetFrameFlash:ClearAllPoints()
        PetFrameFlash:SetPoint("TOPLEFT", PetFrame, "TOPLEFT", 1, -1)

        PhoUI:SetAtlas(PetAttackModeTexture, "ToTFrame_Flash", true)
        PetAttackModeTexture:ClearAllPoints()
        PetAttackModeTexture:SetPoint("TOPLEFT", PetFrame, "TOPLEFT", 1, -1)

        PetFrame.PhoUI = true
    end

    if not db.hitindicator then
        hooksecurefunc(PetHitIndicator, "Show", PetHitIndicator.Hide)
    end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("PET_UI_UPDATE")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:RegisterUnitEvent("UNIT_PET", "player");
    self.EventFrame:SetScript("OnEvent", PetFrame_OnEvent)
end