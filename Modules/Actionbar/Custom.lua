local P, H, O, Y, K = ...
local Module = PhoUI:NewModule("Actionbar.Custom")

function Module:OnEnable()
    local DB = PhoUI.db.profile.actionbar
    
    QueueStatusButton:SetParent(UIParent)
    QueueStatusButton:SetFrameLevel(1)
    QueueStatusButton:SetScale(0.8, 0.8)
    QueueStatusButton:ClearAllPoints()
    QueueStatusButton:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 0, 0)

    hooksecurefunc("QueueStatusDropDown_Show", function(button, relativeTo)
          DropDownList1:ClearAllPoints()
          DropDownList1:SetPoint("BOTTOMLEFT", QueueStatusButton, "BOTTOMLEFT", -70, -60)
    end)

    local Width = 785
    local Height = 50
    local PlaceHolderButtonSize = 38
    local ActionbarPageFramePos = 0
    local Actionbar = CreateFrame("Frame", P .. "Actionbar", UIParent)
    local MainMenuBar = MainMenuBar
    local BorderObj = {
        TOP = {
            Atlas = "_UI-HUD-ActionBar-Frame-NineSlice-EdgeTop",
            Point = {
                {"TOPLEFT", 17 , 0},
                {"TOPRIGHT", -22, 0}
            }
        },
        BOTTOM = {
            Atlas = "_UI-HUD-ActionBar-Frame-NineSlice-EdgeBottom",
            Point = { 
                {"BOTTOMLEFT", 17 , 0},
                {"BOTTOMRIGHT", -22, 0}
            }
        },
        LEFT = {
            Atlas = "!UI-HUD-ActionBar-Frame-NineSlice-EdgeLeft",
            Point = { 
                {"TOPLEFT", 0, -16},
                {"BOTTOMLEFT", 0, 23}
            }
        },
        RIGHT = {
            Atlas = "!UI-HUD-ActionBar-Frame-NineSlice-EdgeRight",
            Point = { 
                {"TOPRIGHT", 0, -16},
                {"BOTTOMRIGHT", 0, 23}
            }
        },
        TOPLEFT = {
            Atlas = "UI-HUD-ActionBar-Frame-NineSlice-CornerTopLeft",
            Point = { 
                {"TOPLEFT", 0, 0}
            }
        },
        TOPRIGHT = {
            Atlas = "UI-HUD-ActionBar-Frame-NineSlice-CornerTopRight",
            Point = { 
                {"TOPRIGHT", 0, 0}
            }
        },
        BOTTOMLEFT = {
            Atlas = "UI-HUD-ActionBar-Frame-NineSlice-CornerBottomLeft",
            Point = { 
                {"BOTTOMLEFT", 0, 0}
            }
        },
        BOTTOMRIGHT = {
            Atlas = "UI-HUD-ActionBar-Frame-NineSlice-CornerBottomRight",
            Point = { 
                {"BOTTOMRIGHT", 0, 0}
            }
        },
    }

    if DB.style == "half" then
        Width = 540
    elseif DB.style == "classic" then
        Width = 993
    end

    function Actionbar:SetPosition(StatusbarCount)
        local LeftEndCap = PhoUILeftEndCap
        local RightEndCap = PhoUIRightEndCap

        if StatusbarCount == 0 then
            Actionbar:SetPoint("CENTER", UIParent, "BOTTOM", 0, 20)
            LeftEndCap:SetPoint("BOTTOMLEFT", -90, -10)
            RightEndCap:SetPoint("BOTTOMRIGHT", 90, -10)
        elseif StatusbarCount == 1 then
            Actionbar:SetPoint("CENTER", UIParent, "BOTTOM", 0, 30)
            LeftEndCap:SetPoint("BOTTOMLEFT", -90, -15)
            RightEndCap:SetPoint("BOTTOMRIGHT", 90, -15)
        else -- 2
            Actionbar:SetPoint("CENTER", UIParent, "BOTTOM", 0, 39)
            LeftEndCap:SetPoint("BOTTOMLEFT", -90, -25)
            RightEndCap:SetPoint("BOTTOMRIGHT", 90, -25)
        end
    end

    local function CreateGryphons()
        local Style = DB.gryphons

        if Style == nil or Style == "" then
            Style = "Faction"
        end

        local LeftGryphon, RightGryphon

        if Style == "Faction" then
            local Faction = UnitFactionGroup("player")
            LeftGryphon = Faction == "Horde" and "UI-HUD-ActionBar-Wyvern-Left" or "UI-HUD-ActionBar-Gryphon-Left"
            RightGryphon = Faction == "Horde" and "UI-HUD-ActionBar-Wyvern-Right" or "UI-HUD-ActionBar-Gryphon-Right"
        else
            LeftGryphon = "UI-HUD-ActionBar-".. Style .."-Left"
            RightGryphon = "UI-HUD-ActionBar-".. Style .."-Right"
        end

        local PrefixList = {"Left", "Right"}
        for _, Prefix in pairs(PrefixList) do
            local Frame = CreateFrame("Frame", P .. Prefix .. "EndCap", Actionbar)
            Frame:SetFrameLevel(5)
            Frame:SetSize(105, 100)
            if Prefix == "Left" then
                Frame:SetPoint("BOTTOMLEFT", -90, -25)
            else
                Frame:SetPoint("BOTTOMRIGHT", 90, -25)
            end
            
            Frame.Gryphon = Frame:CreateTexture()
            Frame.Gryphon:SetAllPoints()

            if Prefix == "Left" then
                Frame.Gryphon:SetAtlas(LeftGryphon, true)
            else
                Frame.Gryphon:SetAtlas(RightGryphon, true)
            end

            if PhoUI.DARK_MODE then
                Frame.Gryphon:SetDesaturated(1)
                Frame.Gryphon:SetVertexColor(0.4, 0.4, 0.4)
            end

            if Style == "Hide" then
                Frame:Hide()
            end
        end
    end

    local function CreateActionbar()
        -- Style Actionbar
        Actionbar:SetSize(Width, Height)
        Actionbar:SetPoint("CENTER", UIParent, "BOTTOM", 0, 20)
        Actionbar:SetFrameLevel(0)

        Actionbar.Background = Actionbar:CreateTexture(nil, "BACKGROUND")
        Actionbar.Background:SetAtlas("talents-background-bottombar", true)
        Actionbar.Background:SetPoint("TOPLEFT", 3.5, -3.5)
        Actionbar.Background:SetPoint("BOTTOMRIGHT", -7, 6.5)

        if PhoUI.DARK_MODE then
            Actionbar.Background:SetDesaturated(1)
            Actionbar.Background:SetVertexColor(0.2, 0.2, 0.2)
        end

        local Border = CreateFrame("Frame", "Border", Actionbar)
        Border:SetAllPoints()

        for i, v in pairs(BorderObj) do
            Border[i] = Border:CreateTexture(nil, "ARTWORK")
            Border[i]:SetAtlas(v.Atlas, true)
            if PhoUI.DARK_MODE then
                Border[i]:SetDesaturated(1)
                Border[i]:SetVertexColor(0.2, 0.2, 0.2)
            end

            for _, point in pairs(v.Point) do
                Border[i]:SetPoint(unpack(point))
            end
        end
    end

    local function AddButtonSeparator(Bar, Button, Point, X)
        local Separator = CreateFrame("Frame", nil, Bar)
        Separator:SetSize(2, 40)
        Separator:SetPoint(Point, Button, X, 0)

        Separator.Top = Separator:CreateTexture(nil, "BORDER")
        Separator.Center = Separator:CreateTexture(nil, "BACKGROUND")
        Separator.Bottom = Separator:CreateTexture(nil, "BORDER")

        Separator.Top:SetAtlas("UI-HUD-ActionBar-Frame-Divider-ThreeSlice-EdgeTop", true)
        Separator.Center:SetAtlas("!UI-HUD-ActionBar-Frame-Divider-ThreeSlice-Center", true)
        Separator.Bottom:SetAtlas("UI-HUD-ActionBar-Frame-Divider-ThreeSlice-EdgeBottom", true)

        Separator.Top:SetPoint("TOP", 0, 0)
        Separator.Center:SetPoint("TOP", 0, 0)
        Separator.Center:SetPoint("BOTTOM", 0, 0)
        Separator.Bottom:SetPoint("BOTTOM", 0, 0)

        if PhoUI.DARK_MODE then
            Separator.Top:SetDesaturated(1)
            Separator.Center:SetDesaturated(1)
            Separator.Bottom:SetDesaturated(1)

            Separator.Top:SetVertexColor(0.2, 0.2, 0.2)
            Separator.Center:SetVertexColor(0.2, 0.2, 0.2)
            Separator.Bottom:SetVertexColor(0.2, 0.2, 0.2)
        end
    end

    local function LeftActionbarButtons()
        local ActionbarLeft = CreateFrame("Frame", P .. "ActionbarLeft", Actionbar)
        ActionbarLeft:SetPoint("LEFT", Actionbar, "LEFT", -4, -0.5)

        for i = 1, 12 do
            local PosX = (i - 1) * 41 + 8
            local PlaceHolderButton = CreateFrame("Frame", P .. "PlaceHolderButtonLeft" .. i, ActionbarLeft)
            PlaceHolderButton:SetSize(PlaceHolderButtonSize, PlaceHolderButtonSize)
            PlaceHolderButton:SetPoint("LEFT", PosX, 2)
    
            PlaceHolderButton.Border = PlaceHolderButton:CreateTexture()
            PlaceHolderButton.Border:SetAtlas("talents-node-choiceflyout-square-locked")
            PlaceHolderButton.Border:SetAllPoints()

            if PhoUI.DARK_MODE then
                PlaceHolderButton.Border:SetDesaturated(1)
                PlaceHolderButton.Border:SetVertexColor(0.2, 0.2, 0.2)
            end
    
            AddButtonSeparator(ActionbarLeft, PlaceHolderButton, "RIGHT", 3)
    
            if i == 12 then
                ActionbarLeft:SetSize(PosX + PlaceHolderButtonSize, 50)
                ActionbarPageFramePos = PosX
            end
        end
    end

    local function RightActionbarButtons()
        local ActionbarRight = CreateFrame("Frame", P .. "ActionbarRight", Actionbar)
        local ActionbarRightYPos = DB.style == "full" and -0.5 or 43
        ActionbarRight:SetPoint("RIGHT", Actionbar, "RIGHT", -8.5, ActionbarRightYPos)
        ActionbarRight:SetFrameLevel(PhoUIActionbarLeft:GetFrameLevel() - 1)

        if DB.style == "full" then
            for i = 1, 6 do
                local PosX = (i - 1) * 41 + 8
                local PlaceHolderButton = CreateFrame("Frame", P .. "PlaceHolderButtonRight" .. i, ActionbarRight)
                PlaceHolderButton:SetSize(PlaceHolderButtonSize, PlaceHolderButtonSize)
                PlaceHolderButton:SetPoint("LEFT", PosX, 2)

                PlaceHolderButton.Border = PlaceHolderButton:CreateTexture()
                PlaceHolderButton.Border:SetAtlas("talents-node-choiceflyout-square-locked")
                PlaceHolderButton.Border:SetAllPoints()
    
                if PhoUI.DARK_MODE then
                    PlaceHolderButton.Border:SetDesaturated(1)
                    PlaceHolderButton.Border:SetVertexColor(0.2, 0.2, 0.2)
                end
    
                AddButtonSeparator(ActionbarRight, PlaceHolderButton, "LEFT", -2)

                if i == 6 then
                    ActionbarRight:SetSize(PosX + PlaceHolderButtonSize, 50)
                end
            end

        elseif DB.style == "classic" then
            for i = 1, 12 do
                local PosX = (i - 1) * 41 + 8
                local PlaceHolderButton = CreateFrame("Frame", P .. "PlaceHolderButtonRight" .. i, ActionbarRight)
                PlaceHolderButton:SetSize(PlaceHolderButtonSize, PlaceHolderButtonSize)
                PlaceHolderButton:SetPoint("LEFT", PosX, 2)

                if i == 12 then
                    ActionbarRight:SetSize(PosX + PlaceHolderButtonSize, 50)
                end
            end
        end
    end

    local function ActionbarPageFrame()
        local ActionbarPageFrame = CreateFrame("Frame", nil, Actionbar)
        ActionbarPageFrame:SetSize(36, 36)
        ActionbarPageFrame:SetPoint("LEFT", ActionbarPageFramePos+37, 1)
        ActionbarPageFrame:SetFrameLevel(MainMenuBar:GetFrameLevel() + 1)

        ActionbarPageFrame.BG = ActionbarPageFrame:CreateTexture()
        ActionbarPageFrame.BG:SetAllPoints()
        ActionbarPageFrame.BG:SetColorTexture(0, 0, 0, .8)

        local ButtonUP = CreateFrame("Frame", nil, ActionbarPageFrame)
        ButtonUP:SetSize(18, 18)
        ButtonUP:SetPoint("TOPLEFT", 0, 1)

        ButtonUP.BG = ButtonUP:CreateTexture()
        ButtonUP.BG:SetAtlas("talents-node-square-locked", true)
        ButtonUP.BG:SetSize(18, 18)
        ButtonUP.BG:SetPoint("TOPLEFT", ButtonUP, "TOPLEFT", 0, 0)

        
        if PhoUI.DARK_MODE then
            ButtonUP.BG:SetDesaturated(1)
            ButtonUP.BG:SetVertexColor(0.2, 0.2, 0.2)
        end

        MainMenuBar.ActionBarPageNumber.UpButton:SetParent(ButtonUP)
        MainMenuBar.ActionBarPageNumber.UpButton:SetPoint("TOPLEFT", 0, 0)
        MainMenuBar.ActionBarPageNumber.UpButton:SetSize(18, 18)
        MainMenuBar.ActionBarPageNumber.UpButton:SetNormalAtlas("hud-MainMenuBar-arrowup-up", true)
        MainMenuBar.ActionBarPageNumber.UpButton:SetPushedAtlas("hud-MainMenuBar-arrowup-down")
        MainMenuBar.ActionBarPageNumber.UpButton:SetHighlightAtlas("hud-MainMenuBar-arrowup-highlight", "ADD")
        MainMenuBar.ActionBarPageNumber.UpButton:Show()

        if PhoUI.DARK_MODE then
            MainMenuBar.ActionBarPageNumber.UpButton:GetNormalTexture():SetVertexColor(0.2, 0.2, 0.2)
        end

        local ButtonDown = CreateFrame("Frame", nil, ActionbarPageFrame)
        ButtonDown:SetSize(18, 18)
        ButtonDown:SetPoint("BOTTOMLEFT", 0, 0)

        ButtonDown.BG = ButtonUP:CreateTexture()
        ButtonDown.BG:SetAtlas("talents-node-square-locked", true)
        ButtonDown.BG:SetSize(18, 18)
        ButtonDown.BG:SetPoint("BOTTOMLEFT", ButtonDown, "BOTTOMLEFT", 0, 0)

        if PhoUI.DARK_MODE then
            ButtonDown.BG:SetDesaturated(1)
            ButtonDown.BG:SetVertexColor(0.2, 0.2, 0.2)
        end

        MainMenuBar.ActionBarPageNumber.DownButton:SetParent(ButtonDown)
        MainMenuBar.ActionBarPageNumber.DownButton:SetPoint("TOPLEFT", 0, 0)
        MainMenuBar.ActionBarPageNumber.DownButton:SetSize(18, 18)
        MainMenuBar.ActionBarPageNumber.DownButton:SetNormalAtlas("hud-MainMenuBar-arrowdown-up", true)
        MainMenuBar.ActionBarPageNumber.DownButton:SetPushedAtlas("hud-MainMenuBar-arrowdown-down", true)
        MainMenuBar.ActionBarPageNumber.DownButton:SetHighlightAtlas("hud-MainMenuBar-arrowdown-highlight", "ADD")
        MainMenuBar.ActionBarPageNumber.DownButton:Show()

        if PhoUI.DARK_MODE then
            MainMenuBar.ActionBarPageNumber.DownButton:GetNormalTexture():SetVertexColor(0.2, 0.2, 0.2)
        end

        local PageNumber = CreateFrame("Frame", nil, ActionbarPageFrame)
        PageNumber:SetSize(15, 15)
        PageNumber:SetPoint("TOPRIGHT", -2, -8)

        PageNumber.Background = PageNumber:CreateTexture()
        PageNumber.Background:SetAtlas("talents-node-square-locked", true)
        PageNumber.Background:SetAllPoints()

        if PhoUI.DARK_MODE then
            PageNumber.Background:SetVertexColor(0.2, 0.2, 0.2)
        end

        MainMenuBar.ActionBarPageNumber.Text:SetParent(PageNumber)
        MainMenuBar.ActionBarPageNumber.Text:SetPoint("CENTER", 0, -1)
        MainMenuBar.ActionBarPageNumber.Text:SetSize(18, 18)
        MainMenuBar.ActionBarPageNumber.Text:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
    end

    if DB.enable then
        MainMenuBar:ClearAllPoints()
        MainMenuBar:SetPoint("BOTTOM", 0, -50)
        CreateActionbar()
        LeftActionbarButtons()
        if DB.style == "full" or DB.style == "classic" then
            RightActionbarButtons()
        end

        Actionbar:SetScale(DB.size)
    
        ActionbarPageFrame()
        CreateGryphons()

        self.EventFrame = CreateFrame("Frame")
        self.EventFrame:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR")
        self.EventFrame:RegisterEvent("PET_BATTLE_CLOSE")
        self.EventFrame:RegisterEvent("PET_BATTLE_OPENING_START")
    
        self.EventFrame:SetScript("OnEvent", function(s, e, ...) 
            if C_PetBattles.IsInBattle() or HasVehicleActionBar() then
                Actionbar:Hide()
            else
                Actionbar:Show()
            end
        end)
    end
end