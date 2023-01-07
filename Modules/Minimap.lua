------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Minimap")
local LibDBIcon = LibStub("LibDBIcon-1.0")

function Module:OnEnable()
    print("NOT LOADED")
    
    MinimapCluster:SetSize(230, 230)

    MinimapCompassTexture:SetTexture(PhoUI.TEXTURE_PATH .. "Minimap")
    MinimapCompassTexture:SetSize(205, 205)
    MinimapCompassTexture:ClearAllPoints()
    MinimapCompassTexture:SetPoint("CENTER", Minimap, "CENTER", 0, 1)
    
    if PhoUI.THEME == "dark" then
        MinimapCompassTexture:SetDesaturated(1)
        MinimapCompassTexture:SetVertexColor(0.1, 0.1, 0.1)
    end
    
    local C_WIDTH, C_HEIGHT = 70, 30
    
    local MinimapClockFrame = CreateFrame("Frame", p .. "MinimapClock", MinimapCluster)
    MinimapClockFrame:SetSize(C_WIDTH, C_HEIGHT)
    MinimapClockFrame:SetPoint("CENTER", MinimapCluster, "BOTTOM", 0, 22)
    
    MinimapClockFrame.Border = MinimapClockFrame:CreateTexture()
    MinimapClockFrame.Border:SetTexture(PhoUI.TEXTURE_PATH .. "Clock")
    MinimapClockFrame.Border:SetSize(C_WIDTH, C_HEIGHT)
    MinimapClockFrame.Border:SetPoint("CENTER", 0, 0)
    MinimapClockFrame.Border:SetDrawLayer("OVERLAY", 7)

    if PhoUI.THEME == "dark" then
        MinimapClockFrame.Border:SetDesaturated(1)
        MinimapClockFrame.Border:SetVertexColor(0.1, 0.1, 0.1)
    end
    
    MinimapCluster.BorderTop:Hide()
    MinimapCluster.ZoneTextButton:SetWidth(150)
    MinimapCluster.ZoneTextButton:ClearAllPoints()
    MinimapCluster.ZoneTextButton:SetPoint("CENTER", MinimapCluster, "TOP", 0, -10)
    
    MinimapZoneText:SetJustifyH("CENTER")
    MinimapZoneText:SetJustifyV("CENTER")
    MinimapZoneText:SetFont(PhoUI.DEFAULT_FONT, 12, "OUTLINE")

    PhoUI:HideFrame(Minimap.ZoomIn)
    PhoUI:HideFrame(Minimap.ZoomOut)

    
    local MinimapEventFrame = CreateFrame("Frame")
    MinimapEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    MinimapEventFrame:SetScript("OnEvent", function ()

        local buttons = LibDBIcon:GetButtonList()
          for i = 1, #buttons do
            if buttons[i] ~= "PhoUI" then
                LibDBIcon:ShowOnEnter(buttons[i], true)
            end
        end
    
        TimeManagerClockButton:ClearAllPoints()
        TimeManagerClockButton:SetPoint("CENTER", MinimapClockFrame, "CENTER", -3, -2)
        TimeManagerClockButton:SetSize(75, 30)
    
        TimeManagerClockTicker:ClearAllPoints()
        TimeManagerClockTicker:SetPoint("CENTER", 4, 1.5)
        TimeManagerClockTicker:SetFont(PhoUI.DEFAULT_FONT, 11, "OUTLINE")
      
    
        --CreateMinimapCalendar()
        --GameTimeFrame:ClearAllPoints()
        --GameTimeFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -5, -5)
        GameTimeFrame:Hide()

        MinimapCluster.MailFrame:ClearAllPoints()
        MinimapCluster.MailFrame:SetPoint("CENTER", Minimap, "TOPRIGHT", -8, -55)
        CreateMinimapButtonBorder(MinimapCluster.MailFrame, "Mailbox")
        MiniMapMailIcon:Hide()
    
        MinimapCluster.Tracking:Hide()
    
        Minimap:ClearAllPoints()
        Minimap:SetPoint("CENTER", MinimapCluster, "CENTER", 0, 0)
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
    
    
    function CreateMinimapCalendar()
        local Obj = GameTimeFrame

        Obj:SetSize(21, 19)
        Obj.Overlay = Obj:CreateTexture(nil, "BORDER")
        Obj.Overlay:SetTexture(PhoUI.TEXTURE_PATH .. "Minimap-Button")
        Obj.Overlay:SetSize(25, 25)
        Obj.Overlay:SetPoint("CENTER", -2, 1)

    end

    
    --[[function CreateMinimapCalendar()
        local Obj = GameTimeFrame
    
        Obj.Overlay = Obj:CreateTexture(nil, "OVERLAY")
        Obj.Overlay:SetSize(50, 50)
        Obj.Overlay:SetTexture(136430)
        Obj.Overlay:SetPoint("CENTER", 8, -8)
    
        Obj.Background = Obj:CreateTexture(nil, "BACKGROUND")
        Obj.Background:SetSize(24, 24)
        Obj.Background:SetTexture(136467)
        Obj.Background:SetPoint("CENTER", -1.5, 1)
    end
    ]]
    
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

    QueueStatusButton:SetParent(UIParent)
    QueueStatusButton:SetFrameLevel(1)
    QueueStatusButton:SetScale(0.8, 0.8)
    QueueStatusButton:ClearAllPoints()
    QueueStatusButton:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 0, 0)

    hooksecurefunc("QueueStatusDropDown_Show", function(button, relativeTo)
          DropDownList1:ClearAllPoints()
          DropDownList1:SetPoint("BOTTOMLEFT", QueueStatusButton, "BOTTOMLEFT", -70, -60)
    end)
end