------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Statusbar")

function Module:OnEnable()
    local function AddBarBorder(Frame)
        if Frame.Border == nil then
            Frame.Border = CreateFrame("Frame", "Border", Frame)
            Frame.Border:SetAllPoints()
            Frame.Border:SetPoint("TOPLEFT", 0, 0)

            Frame.Border:SetFrameLevel(Frame:GetFrameLevel() + 99)

            Frame.Border.TOPLEFT = Frame.Border:CreateTexture(nil, "ARTWORK")
            Frame.Border.TOPLEFT:SetAtlas("UI-HUD-ActionBar-Frame-NineSlice-CornerTopLeft", true)
            Frame.Border.TOPLEFT:SetSize(8, 8)
            Frame.Border.TOPLEFT:SetPoint("TOPLEFT", 0, 0)

            Frame.Border.BOTTOMLEFT = Frame.Border:CreateTexture()
            Frame.Border.BOTTOMLEFT:SetAtlas("UI-HUD-ActionBar-Frame-NineSlice-CornerTopLeft", true)
            Frame.Border.BOTTOMLEFT:SetTexCoord(0, 1, 1, 0)
            Frame.Border.BOTTOMLEFT:SetSize(8, 8)
            Frame.Border.BOTTOMLEFT:SetPoint("BOTTOMLEFT", 0, 0)

            Frame.Border.TOPRIGHT = Frame.Border:CreateTexture()
            Frame.Border.TOPRIGHT:SetAtlas("UI-HUD-ActionBar-Frame-NineSlice-CornerTopLeft", true)
            Frame.Border.TOPRIGHT:SetTexCoord(1, 0, 0, 1)
            Frame.Border.TOPRIGHT:SetSize(8, 8)
            Frame.Border.TOPRIGHT:SetPoint("TOPRIGHT", 0, 0)

            Frame.Border.BOTTOMRIGHT = Frame.Border:CreateTexture()
            Frame.Border.BOTTOMRIGHT:SetAtlas("UI-HUD-ActionBar-Frame-NineSlice-CornerTopLeft", true)
            Frame.Border.BOTTOMRIGHT:SetTexCoord(1, 0, 1, 0)
            Frame.Border.BOTTOMRIGHT:SetSize(8, 8)
            Frame.Border.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", 0, 0)

            Frame.Border.TOP = Frame.Border:CreateTexture()
            Frame.Border.TOP:SetAtlas("_UI-HUD-ActionBar-Frame-NineSlice-EdgeTop", true)
            Frame.Border.TOP:SetSize(8, 8)
            Frame.Border.TOP:SetPoint("TOPLEFT", 8, 0)
            Frame.Border.TOP:SetPoint("TOPRIGHT", -8, 0)

            Frame.Border.BOTTOM = Frame.Border:CreateTexture()
            Frame.Border.BOTTOM:SetAtlas("_UI-HUD-ActionBar-Frame-NineSlice-EdgeTop", true)
            Frame.Border.BOTTOM:SetSize(8, 8)
            Frame.Border.BOTTOM:SetTexCoord(0, 1, 1, 0)
            Frame.Border.BOTTOM:SetPoint("BOTTOMLEFT", 8, 0)
            Frame.Border.BOTTOM:SetPoint("BOTTOMRIGHT", -8, 0)

            if PhoUI.DARK_MODE then
                Frame.Border.TOPLEFT:SetVertexColor(0.2, 0.2, 0.2)
                Frame.Border.BOTTOMLEFT:SetVertexColor(0.2, 0.2, 0.2)
                Frame.Border.TOPRIGHT:SetVertexColor(0.2, 0.2, 0.2)
                Frame.Border.BOTTOMRIGHT:SetVertexColor(0.2, 0.2, 0.2)
                Frame.Border.TOP:SetVertexColor(0.2, 0.2, 0.2)
                Frame.Border.BOTTOM:SetVertexColor(0.2, 0.2, 0.2)
            end

            for i = 1, 9 do
                local Separator = Frame:CreateTexture(nil, "ARTWORK")
                Separator:SetAtlas("!UI-HUD-ActionBar-Frame-Divider-ThreeSlice-Center", true)
                Separator:SetSize(7, 10)

                if PhoUI.DARK_MODE then
                    Separator:SetVertexColor(0.2, 0.2, 0.2)
                end

                local POS_X = (i*10)*785/100
                Separator:SetPoint("LEFT", Frame, "LEFT", POS_X, 0)
            end
        end
    end

    local function UpdateStatusBar()
        local StatusTrackingBarManagerBottom = StatusTrackingBarManager.BottomBarFrameTexture
        local StatusTrackingBarManagerTop = StatusTrackingBarManager.TopBarFrameTexture
        
        StatusTrackingBarManagerTop:SetSize(772, 17)
        StatusTrackingBarManagerBottom:SetSize(772, 17)

        StatusTrackingBarManagerTop:ClearAllPoints()
        StatusTrackingBarManagerTop:SetPoint("CENTER", 0, 2)

        StatusTrackingBarManagerBottom:ClearAllPoints()
        StatusTrackingBarManagerBottom:SetPoint("CENTER", 0, -12)

        StatusTrackingBarManagerTop:SetAlpha(0)
        StatusTrackingBarManagerBottom:Hide()
    end

    function self:CreateBarFrame(Name, Pos)
        local Statusbar = CreateFrame("Frame", p .. Name, UIParent)
        Statusbar:SetSize(772, 12)
        Statusbar:SetPoint("CENTER", UIParent, "BOTTOM", -3, Pos)

        local Border = CreateFrame("Frame", "Border", Statusbar)
        Border:SetAllPoints()
        Border:SetFrameLevel(8)

        Border.TOPLEFT = Border:CreateTexture(nil, "ARTWORK")
        Border.TOPLEFT:SetAtlas("UI-HUD-ActionBar-Frame-NineSlice-CornerTopLeft", true)
        Border.TOPLEFT:SetSize(8, 8)
        Border.TOPLEFT:SetPoint("TOPLEFT", 0, 0)

        Border.BOTTOMLEFT = Border:CreateTexture()
        Border.BOTTOMLEFT:SetAtlas("UI-HUD-ActionBar-Frame-NineSlice-CornerTopLeft", true)
        Border.BOTTOMLEFT:SetTexCoord(0, 1, 1, 0)
        Border.BOTTOMLEFT:SetSize(8, 8)
        Border.BOTTOMLEFT:SetPoint("BOTTOMLEFT", 0, 0)

        Border.TOPRIGHT = Border:CreateTexture()
        Border.TOPRIGHT:SetAtlas("UI-HUD-ActionBar-Frame-NineSlice-CornerTopLeft", true)
        Border.TOPRIGHT:SetTexCoord(1, 0, 0, 1)
        Border.TOPRIGHT:SetSize(8, 8)
        Border.TOPRIGHT:SetPoint("TOPRIGHT", 0, 0)

        Border.BOTTOMRIGHT = Border:CreateTexture()
        Border.BOTTOMRIGHT:SetAtlas("UI-HUD-ActionBar-Frame-NineSlice-CornerTopLeft", true)
        Border.BOTTOMRIGHT:SetTexCoord(1, 0, 1, 0)
        Border.BOTTOMRIGHT:SetSize(8, 8)
        Border.BOTTOMRIGHT:SetPoint("BOTTOMRIGHT", 0, 0)

        Border.TOP = Border:CreateTexture()
        Border.TOP:SetAtlas("_UI-HUD-ActionBar-Frame-NineSlice-EdgeTop", true)
        Border.TOP:SetSize(8, 8)
        Border.TOP:SetPoint("TOPLEFT", 8, 0)
        Border.TOP:SetPoint("TOPRIGHT", -8, 0)

        Border.BOTTOM = Border:CreateTexture()
        Border.BOTTOM:SetAtlas("_UI-HUD-ActionBar-Frame-NineSlice-EdgeTop", true)
        Border.BOTTOM:SetSize(8, 8)
        Border.BOTTOM:SetTexCoord(0, 1, 1, 0)
        Border.BOTTOM:SetPoint("BOTTOMLEFT", 8, 0)
        Border.BOTTOM:SetPoint("BOTTOMRIGHT", -8, 0)

        if PhoUI.DARK_MODE then
            Border.TOPLEFT:SetVertexColor(0.2, 0.2, 0.2)
            Border.TOPRIGHT:SetVertexColor(0.2, 0.2, 0.2)
            Border.BOTTOMLEFT:SetVertexColor(0.2, 0.2, 0.2)
            Border.BOTTOMRIGHT:SetVertexColor(0.2, 0.2, 0.2)
            Border.TOP:SetVertexColor(0.2, 0.2, 0.2)
            Border.BOTTOM:SetVertexColor(0.2, 0.2, 0.2)
        end

        for i = 1, 9 do
            local Separator = Statusbar:CreateTexture(nil, "ARTWORK")
            Separator:SetAtlas("!UI-HUD-ActionBar-Frame-Divider-ThreeSlice-Center", true)
            Separator:SetSize(7, 10)

            if PhoUI.DARK_MODE then
                Separator:SetVertexColor(0.2, 0.2, 0.2)
            end

            local POS_X = (i*10)*785/100

            Separator:SetPoint("LEFT", Statusbar, "LEFT", POS_X, 0)
        end

        Statusbar:Hide()
    end



    function UpdatePos()end

    local function UpdatePosition(BARS)
        if BARS == 1 then
            PhoUIActionbar:SetPoint("CENTER", UIParent, "BOTTOM", 0, 35)
        elseif BARS == 2 then
            PhoUIActionbar:SetPoint("CENTER", UIParent, "BOTTOM", 0, 50)
        else
            PhoUIActionbar:SetPoint("CENTER", UIParent, "BOTTOM", 0, 20)
        end
    end


    -- # Remove default Statustrackingbars
    StatusTrackingBarManager:HookScript("OnEvent", function()
        local SHOWN_BARS = 0

        UpdateStatusBar()

        for _, StatusBar in pairs(StatusTrackingBarManager.bars) do
            StatusBar.StatusBar:SetFrameLevel(1)
            StatusBar.StatusBar.Background:SetPoint("TOPLEFT", 1.5, -1)
            StatusBar.StatusBar.Background:SetPoint("BOTTOMRIGHT", -2, 1)

            StatusBar.StatusBar.Background:SetColorTexture(0, 0, 0, .8)

            AddBarBorder(StatusBar)

            if PhoUI.DARK_MODE then
                if StatusBar.ExhaustionTick then
                    PhoUI:HideFrame(StatusBar.ExhaustionTick)
                end
            end

            if(StatusBar:ShouldBeVisible()) then
                SHOWN_BARS = SHOWN_BARS + 1
            end
        end

        if not UnitAffectingCombat("player") then
            UpdatePosition(SHOWN_BARS)
        end
    end)
end