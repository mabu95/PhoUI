local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Statusbar")

function Module:OnEnable()
    local DB = PhoUI.db.profile.actionbar
    if not DB.enable then return end

    local Actionbar = PhoUIActionbar

    -- @todo: add honor bar

    -- Disable Default Statusbars
	if StatusTrackingBarManager then
		StatusTrackingBarManager:UnregisterAllEvents()
		StatusTrackingBarManager:Hide()
	end

    local function UpdateActionbar()
        local XP = PhoUIXP
        local Rep = PhoUIRep
        local Count = 0

        if not UnitAffectingCombat("player") then
            if XP ~= nil and XP:IsShown() then
                Count = Count + 1
            end

            if Rep ~= nil and Rep:IsShown() then
                Count = Count + 1
            end

            Actionbar:SetPosition(Count)
        end
    end

    local Width = Actionbar:GetWidth() - 15
    local Atlas = "widgetstatusbar-fill-white"

    local function CreateBarTexture()
        local Frame = CreateFrame("Frame")
        local Texture = Frame:CreateTexture()
        Texture:SetAtlas(Atlas)

        return Texture
    end

    local function CreateBarBorder(Bar)
        local Frame = CreateFrame("Frame", P .. Bar, UIParent)
        Frame:SetSize(Width, 12)
        Frame:EnableMouse(true)
        Frame:SetFrameLevel(100)
        Frame:SetScale(DB.size)

        Frame.Bg = Frame:CreateTexture()
        Frame.Bg:SetPoint("TOPLEFT", 2, -2)
        Frame.Bg:SetPoint("BOTTOMRIGHT", -2, 2)
        Frame.Bg:SetColorTexture(0, 0, 0, .5)

        Frame.Border = CreateFrame("Frame", "Border", Frame, "BackdropTemplate")
        Frame.Border:SetAllPoints()
        Frame.Border:SetPoint("TOPLEFT", 0, 0)
        Frame.Border:SetFrameLevel(Frame:GetFrameLevel() + 10)
    
        Frame.Backdrop = CreateFrame("Frame", nil, Frame, "BackdropTemplate")
        Frame.Backdrop:SetPoint("TOPLEFT", -2, 2)
        Frame.Backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
        Frame.Backdrop:SetBackdrop({
            bgFile = "",
            edgeFile = PhoUI.TEXTURE_PATH .. "Backdrop",
            tile = false, tileSize = 0,
            edgeSize = 5,
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        })
        Frame.Backdrop:SetBackdropBorderColor(0, 0, 0, 0.4)

        Frame.Border.LEFT = Frame.Border:CreateTexture(nil, "BORDER")
        Frame.Border.LEFT:SetAtlas("!UI-HUD-ActionBar-Frame-NineSlice-EdgeLeft", true)
        Frame.Border.LEFT:SetSize(14, 11)
        Frame.Border.LEFT:SetPoint("LEFT", 0, 0)

        Frame.Border.RIGHT = Frame.Border:CreateTexture(nil, "BACKGROUND")
        Frame.Border.RIGHT:SetAtlas("!UI-HUD-ActionBar-Frame-NineSlice-EdgeLeft", true)
        Frame.Border.RIGHT:SetTexCoord(1, 0, 0, 1)
        Frame.Border.RIGHT:SetSize(14, 11)
        Frame.Border.RIGHT:SetPoint("RIGHT", 0, 0)

        Frame.Border.TOP = Frame.Border:CreateTexture()
        Frame.Border.TOP:SetAtlas("_UI-HUD-ActionBar-Frame-NineSlice-EdgeTop", true)
        Frame.Border.TOP:SetSize(16, 14)
        Frame.Border.TOP:SetPoint("TOPLEFT", 2, 0)
        Frame.Border.TOP:SetPoint("TOPRIGHT", -2, 0)
    
        Frame.Border.BOTTOM = Frame.Border:CreateTexture()
        Frame.Border.BOTTOM:SetAtlas("_UI-HUD-ActionBar-Frame-NineSlice-EdgeTop", true)
        Frame.Border.BOTTOM:SetSize(16, 14)
        Frame.Border.BOTTOM:SetTexCoord(0, 1, 1, 0)
        Frame.Border.BOTTOM:SetPoint("BOTTOMLEFT", 2, 0)
        Frame.Border.BOTTOM:SetPoint("BOTTOMRIGHT", -2, 0)

        if PhoUI.DARK_MODE then
            local F = { Frame.Border:GetRegions() }
            for i, v in ipairs(F) do
                v:SetVertexColor(0.2, 0.2, 0.2)
            end
        end

        local StatusBarTexture = CreateBarTexture()
        Frame.Bar = CreateFrame("StatusBar", nil, Frame)
        Frame.Bar:SetFrameLevel(Frame.Border:GetFrameLevel() - 1)
        --Frame.Bar:SetStatusBarTexture(StatusBarTexture)
        Frame.Bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        Frame.Bar:SetPoint("TOPLEFT", 3, -2)
        Frame.Bar:SetPoint("BOTTOMRIGHT", -3, 2)

        local StatusBar2Texture = CreateBarTexture()
        Frame.Bar2 = CreateFrame("StatusBar", nil, Frame)
        Frame.Bar2:SetFrameLevel(Frame.Border:GetFrameLevel() - 2)
        --Frame.Bar2:SetStatusBarTexture(StatusBar2Texture)
        Frame.Bar2:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        Frame.Bar2:SetPoint("TOPLEFT", 3, -2)
        Frame.Bar2:SetPoint("BOTTOMRIGHT", -3, 2)
        Frame.Bar2:Hide()

        local TextFrame = CreateFrame("Frame", nil, UIParent)
        TextFrame:SetPoint("CENTER", Frame, "CENTER", 0, 0)
        TextFrame:SetFrameLevel(Frame.Border:GetFrameLevel() + 1)
        TextFrame:SetAlpha(0)

        TextFrame.Text = TextFrame:CreateFontString(nil, "OVERLAY")
        TextFrame.Text:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
        TextFrame.Text:SetTextColor(1, 1, 1)
        TextFrame.Text:SetPoint("CENTER", Frame, "CENTER", 0, 0)

        Frame.TextFrame = TextFrame

        Frame:EnableMouse()
        Frame:SetScript('OnEnter', function() TextFrame:SetAlpha(1) end)
        Frame:SetScript('OnLeave', function() TextFrame:SetAlpha(0) end)

        for i = 1, 9 do
            local Separator = Frame.Border:CreateTexture(nil, "BORDER")
            Separator:SetAtlas("!UI-HUD-ActionBar-Frame-Divider-ThreeSlice-Center", true)
            Separator:SetSize(7, 6)

            if PhoUI.DARK_MODE then
                Separator:SetVertexColor(0.2, 0.2, 0.2)
            end

            local POS_X = (i * 10) * Width / 100
            Separator:SetPoint("LEFT", Frame, "LEFT", POS_X, 0)
        end

        return Frame
    end

    local XPFrame = CreateBarBorder("XP")
    local RepFrame = CreateBarBorder("Rep")

    XPFrame:SetPoint("BOTTOM", 0, 9)
    RepFrame:SetPoint("BOTTOM", 0, 0)

    local function UpdateBars()
        if UnitLevel("player") < MAX_PLAYER_LEVEL then
            local XP, Max, Rested = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion()
            XPFrame.Bar:SetStatusBarColor(6/255, 41/255, 1)
            XPFrame.Bar:SetMinMaxValues(0, Max)
            XPFrame.Bar:SetValue(XP)

            XPFrame.TextFrame.Text:SetText("EP: " .. XP .. "/" .. Max)

            if Rested then
                XPFrame.Bar2:SetStatusBarColor(1/255, 20/255, 150/255)
                XPFrame.Bar2:SetMinMaxValues(0, Max)
                XPFrame.Bar2:SetValue(math.min(XP + Rested, Max))
                XPFrame.Bar2:Show()

                local RestedMath = math.floor((Rested * 100) / Max)
                XPFrame.TextFrame.Text:SetText("EP: " .. XP .. "/" .. Max .. " (R: " .. RestedMath .."%)")
            else
                XPFrame.Bar2:Hide()
            end
        else
            XPFrame:Hide()
        end

        -- REP
        if GetWatchedFactionInfo() then
            RepFrame:Show()
            local name, standing, min, max, value, factionID = GetWatchedFactionInfo()
            local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = C_GossipInfo.GetFriendshipReputation(factionID)
            RepFrame.Bar:SetStatusBarColor(FACTION_BAR_COLORS[standing].r, FACTION_BAR_COLORS[standing].g, FACTION_BAR_COLORS[standing].b, 1)
            RepFrame.Bar:SetMinMaxValues(0, max)
		    RepFrame.Bar:SetValue(value)

            RepFrame.TextFrame.Text:SetText(name .. ": " .. value .. "/" .. max)

            if min <= 0 then
                RepFrame.Bar:SetMinMaxValues(0, math.abs(min))
                RepFrame.Bar:SetValue(math.abs(min) - math.abs(value))
            end
        else
            RepFrame:Hide()
        end

        UpdateActionbar()
    end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:RegisterEvent("PLAYER_XP_UPDATE")
    self.EventFrame:RegisterEvent("PLAYER_LEVEL_UP")
    self.EventFrame:RegisterEvent("UPDATE_EXHAUSTION")
    self.EventFrame:RegisterEvent("ENABLE_XP_GAIN")
    self.EventFrame:RegisterEvent("DISABLE_XP_GAIN")
    self.EventFrame:RegisterEvent("UNIT_INVENTORY_CHANGED")
    self.EventFrame:RegisterEvent("UPDATE_FACTION")

    self.EventFrame:SetScript("OnEvent", UpdateBars)
end