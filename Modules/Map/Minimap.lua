local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Map.Minimap")
local LibDBIcon = LibStub("LibDBIcon-1.0")

function Module:OnEnable()
    local DB = PhoUI.db.profile.minimap
    local MinimapCluster = MinimapCluster
    local MinimapCompassTexture = MinimapCompassTexture
    local ZoomIn = Minimap.ZoomIn
    local ZoomOut = Minimap.ZoomOut
    local MinimapButtons = LibDBIcon:GetButtonList()

    PhoUI:HideFrame(ZoomIn)
    PhoUI:HideFrame(ZoomOut)

    local function UpdateMinimap()
        MinimapCluster:SetSize(195, 200)
        Minimap:SetSize(183, 183)

        Minimap:ClearAllPoints()
        Minimap:SetPoint("CENTER", MinimapCluster, "CENTER", 0, -12)

        -- Clock Frame
        local ClockWidth, ClockHeight = 50, 22.5
        local ClockFrame = CreateFrame("Frame", P .. "Clock", MinimapCluster)
        ClockFrame:SetSize(ClockWidth, ClockHeight)
        ClockFrame:SetPoint("CENTER", Minimap, "BOTTOM", 0, 2)

        ClockFrame.Border = ClockFrame:CreateTexture(nil, "BORDER")
        PhoUI:SetAtlas(ClockFrame.Border, "Minimap_Clock")
        ClockFrame.Border:SetAllPoints()
        ClockFrame.Border:SetDrawLayer("OVERLAY", 7)

        if PhoUI.DARK_MODE then
            ClockFrame.Border:SetVertexColor(0.1, 0.1, 0.1)
        end

        TimeManagerClockTicker:ClearAllPoints()
        TimeManagerClockTicker:SetPoint("CENTER", ClockFrame, "CENTER", 0, 1)
        TimeManagerClockTicker:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
    end

    local function Minimap_Shape_Round()
        PhoUI:SetAtlas(MinimapCompassTexture, "Minimap_Round")
        MinimapCompassTexture:SetSize(200, 200)
        MinimapCompassTexture:ClearAllPoints()
        MinimapCompassTexture:SetPoint("CENTER", Minimap, "CENTER", 0, -2.5)
        if PhoUI.DARK_MODE then
            MinimapCompassTexture:SetVertexColor(0.2, 0.2, 0.2)
        end
    end

    local function Minimap_Shape_Square()
        Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')
        PhoUI:SetAtlas(MinimapCompassTexture, "Minimap_Square")
        MinimapCompassTexture:SetSize(206, 206)
        MinimapCompassTexture:ClearAllPoints()
        MinimapCompassTexture:SetPoint("CENTER", Minimap, "CENTER", 0, -2.5)
    end

    local function Minimap_Default_Header()
        MinimapCluster.BorderTop:Hide()
        MinimapCluster.ZoneTextButton:SetWidth(190)
        MinimapCluster.ZoneTextButton:ClearAllPoints()
        MinimapCluster.ZoneTextButton:SetPoint("CENTER", MinimapCluster, "TOP", 0, -10)

        MinimapZoneText:SetJustifyH("CENTER")
        MinimapZoneText:SetJustifyV("CENTER")
        MinimapZoneText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")
    end

    local function Minimap_Inside_Header()
        MinimapCluster.BorderTop:Hide()
        MinimapCluster.ZoneTextButton:SetWidth(190)
        MinimapCluster.ZoneTextButton:ClearAllPoints()
        MinimapCluster.ZoneTextButton:SetPoint("CENTER", MinimapCluster, "TOP", 0, -20)
        MinimapCluster.ZoneTextButton:SetFrameLevel(MinimapCluster:GetFrameLevel() + 10)

        MinimapZoneText:SetJustifyH("CENTER")
        MinimapZoneText:SetJustifyV("CENTER")
        MinimapZoneText:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE")

        Minimap:SetPoint("CENTER", MinimapCluster, "CENTER", 0, 0)
    end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:SetScript("OnEvent", function ()
        GameTimeFrame:Hide()
        MinimapCluster.Tracking:Hide()

        MinimapCluster.MailFrame:ClearAllPoints()
        MinimapCluster.MailFrame:SetPoint("CENTER", Minimap, "TOPRIGHT", -8, -55)
        CreateMinimapButtonBorder(MinimapCluster.MailFrame, "Mailbox")
        MiniMapMailIcon:Hide()

        -- Hide Minimap Icons
        if DB.hide_icons then
            MinimapButtons = LibDBIcon:GetButtonList()
            for i = 1, #MinimapButtons do
                if MinimapButtons[i] ~= "PhoUI" then
                    LibDBIcon:ShowOnEnter(MinimapButtons[i], true)
                end
            end
        end
    end)

    Minimap:SetScript("OnMouseUp", function(self, button)
        if button=="RightButton" then
            ToggleDropDownMenu(1, nil, MinimapCluster.Tracking.DropDown, Minimap, 8, 5);
        elseif button=="MiddleButton" then
            ToggleCalendar();
        else
           Minimap:OnClick(self)
        end
    end)

    if DB.enable then
        UpdateMinimap()

        if DB.shape == "round" then
            Minimap_Shape_Round()
        else
            Minimap_Shape_Square()
        end

        if DB.header_style == "default" then
            -- Default
            Minimap_Default_Header()
        else
            Minimap_Inside_Header()
            -- Clean
        end
    end



    

    function CreateMinimapButtonBorder(Obj, Icon)
        Obj:SetSize(31, 31)
    
        if Obj.Overlay == nil then
            Obj.Overlay = Obj:CreateTexture(nil, "OVERLAY")
            Obj.Overlay:SetSize(50, 50)
            Obj.Overlay:SetTexture(136430)
            Obj.Overlay:SetPoint("TOPLEFT", Obj, "TOPLEFT", 0, 0)
        end
    
        if Obj.Background == nil then
            Obj.Background = Obj:CreateTexture(nil, "BACKGROUND")
            Obj.Background:SetSize(24, 24)
            Obj.Background:SetTexture(136467)
            Obj.Background:SetPoint("CENTER", Obj, "CENTER", 0, 1)
        end

        if Obj.Icon == nil then
            Obj.Icon = Obj:CreateTexture(nil, "ARTWORK")
            Obj.Icon:SetSize(18, 18)
            Obj.Icon:SetAtlas(Icon)
            Obj.Icon:SetPoint("CENTER", Obj, "CENTER", 0, 0)
        end

        if PhoUI.DARK_MODE then
            Obj.Overlay:SetDesaturated(1)
            Obj.Overlay:SetVertexColor(0.1, 0.1, 0.1)
        end
    end

    -- Hide Minimap Icon
    for i = 1, #MinimapButtons do
        local Button = LibDBIcon:GetMinimapButton(MinimapButtons[i])
        local ButtonChilds = { Button:GetRegions() }

        for j, v in ipairs(ButtonChilds) do
            if j < 3 and PhoUI.DARK_MODE then
                v:SetDesaturated(1)
                v:SetVertexColor(0.1, 0.1, 0.1)
            end
        end
    end
end