------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Custom = PhoUI:NewModule("CustomActionbar")

function Custom:OnEnable()
    local db = PhoUI.db.profile.actionbar
    local Height = 50
    local PagerPos = 0
    
    local Width = db.style == "full" and 785 or 540

    PhoUI:HideFrame(MainMenuBar.EndCaps)
    PhoUI:HideFrame(MainMenuBar.BorderArt)
    PhoUI:HideFrame(MainMenuBar.Background)

    local function Gryphons(Faction)
        local GryphonLeft = CreateFrame("FRAME", p .. "LeftEndCap", PhoUIActionbar)
        GryphonLeft:SetFrameLevel(5)
        GryphonLeft:SetSize(105, 100)
        GryphonLeft:SetPoint("BOTTOMLEFT", -90, -15)
        GryphonLeft.Background = GryphonLeft:CreateTexture()
        GryphonLeft.Background:SetAllPoints()

        local GryphonRight = CreateFrame("FRAME", p .. "RightEndCap", PhoUIActionbar)
        GryphonRight:SetFrameLevel(5)
        GryphonRight:SetSize(105, 100)
        GryphonRight:SetPoint("BOTTOMRIGHT", 90, -15)
        GryphonRight.Background = GryphonRight:CreateTexture()
        GryphonRight.Background:SetAllPoints()

        if Faction == "Horde" then
            GryphonLeft.Background:SetAtlas("UI-HUD-ActionBar-Wyvern-Left", true)
            GryphonRight.Background:SetAtlas("UI-HUD-ActionBar-Wyvern-Right", true)
        else
            GryphonLeft.Background:SetAtlas("UI-HUD-ActionBar-Gryphon-Left", true)
            GryphonRight.Background:SetAtlas("UI-HUD-ActionBar-Gryphon-Right", true)
        end

        if PhoUI.DARK_MODE then
            GryphonLeft.Background:SetDesaturated(1)
            GryphonLeft.Background:SetVertexColor(0.4, 0.4, 0.4)

            GryphonRight.Background:SetDesaturated(1)
            GryphonRight.Background:SetVertexColor(0.4, 0.4, 0.4)
        end
    end
    
    local function CreateBorderArt()
        local Actionbar = CreateFrame("Frame", p .. "Actionbar", UIParent)
        Actionbar:SetSize(Width, Height)
        Actionbar:SetPoint("CENTER", UIParent, "BOTTOM", 0, 50)
        --Actionbar:SetPoint("CENTER", UIParent, "BOTTOM", 0, 200)
        Actionbar:SetFrameLevel(0)

        Actionbar.Background = Actionbar:CreateTexture(nil, "BACKGROUND")
        Actionbar.Background:SetAtlas("talents-background-bottombar", true)
        Actionbar.Background:SetPoint("TOPLEFT", 3.5, -3.5)
        Actionbar.Background:SetPoint("BOTTOMRIGHT", -7, 6.5)

        if PhoUI.DARK_MODE then
            Actionbar.Background:SetDesaturated(1)
            Actionbar.Background:SetVertexColor(0.2, 0.2, 0.2)
        end

        local function CreateBorder()
            local Border = CreateFrame("Frame", "Border", Actionbar)
            Border:SetAllPoints()

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

            for i, v in pairs(BorderObj) do
                Border[i] = Border:CreateTexture(nil, "BORDER")
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

        local function PlaceholderButtons()

            function AddSeparator(Parent, Button, Point, X)
                local Separator = CreateFrame("FRAME", nil, Parent)
                Separator:SetSize(2, 40)
                Separator:SetPoint(Point, Button, Point, X, 0)

                Separator.TOP = Separator:CreateTexture(nil, "BORDER")
                Separator.TOP:SetAtlas("UI-HUD-ActionBar-Frame-Divider-ThreeSlice-EdgeTop", true)
                Separator.TOP:SetPoint("TOP", 0, 0)

                Separator.CENTER = Separator:CreateTexture(nil, "BACKGROUND")
                Separator.CENTER:SetAtlas("!UI-HUD-ActionBar-Frame-Divider-ThreeSlice-Center", true)
                Separator.CENTER:SetPoint("TOP", 0, 0)
                Separator.CENTER:SetPoint("BOTTOM", 0, 0)

                Separator.BOTTOM = Separator:CreateTexture(nil, "BORDER")
                Separator.BOTTOM:SetAtlas("UI-HUD-ActionBar-Frame-Divider-ThreeSlice-EdgeBottom", true)
                Separator.BOTTOM:SetPoint("BOTTOM", 0, 0)

                if PhoUI.DARK_MODE then
                    Separator.TOP:SetDesaturated(1)
                    Separator.TOP:SetVertexColor(0.2, 0.2, 0.2)
                    Separator.CENTER:SetDesaturated(1)
                    Separator.CENTER:SetVertexColor(0.2, 0.2, 0.2)
                    Separator.BOTTOM:SetDesaturated(1)
                    Separator.BOTTOM:SetVertexColor(0.2, 0.2, 0.2)
                end
            end

            local Size = 38
            
            local LeftBar = CreateFrame("Frame", nil, Actionbar)
            LeftBar:SetPoint("LEFT", Actionbar, "LEFT", -4, 0)

            local RightBar = CreateFrame("Frame", nil, Actionbar)
            RightBar:SetPoint("RIGHT", Actionbar, "RIGHT", -8.5, 0)

            -- Left Bar
            for i = 1, 12 do
                local POS_X = (i - 1) * 41 + 8
                local PlaceholderButton = CreateFrame("FRAME", p .. "PlaceholderButtonLeft" .. i, LeftBar)
                PlaceholderButton:SetSize(Size, Size)
                PlaceholderButton:SetPoint("LEFT", POS_X, 2)

                PlaceholderButton.Border = PlaceholderButton:CreateTexture()
                PlaceholderButton.Border:SetAtlas("talents-node-choiceflyout-square-locked")
                PlaceholderButton.Border:SetAllPoints()

                if PhoUI.DARK_MODE then
                    PlaceholderButton.Border:SetDesaturated(1)
                    PlaceholderButton.Border:SetVertexColor(0.2, 0.2, 0.2)
                end

                AddSeparator(LeftBar, PlaceholderButton, "RIGHT", 3)

                if i == 12 then
                    LeftBar:SetSize(POS_X + Size, 50)
                    PagerPos = POS_X
                end
            end
            
            if db.style == "full" then
                -- Right Bar
                for i = 1, 6 do
                    local POS_X = (i - 1) * 41 + 8
                    local PlaceholderButton = CreateFrame("FRAME", p .. "PlaceholderButtonRight" .. i, RightBar)
                    PlaceholderButton:SetSize(Size, Size)
                    PlaceholderButton:SetPoint("LEFT", POS_X, 2)

                    PlaceholderButton.Border = PlaceholderButton:CreateTexture()
                    PlaceholderButton.Border:SetAtlas("talents-node-choiceflyout-square-locked")
                    PlaceholderButton.Border:SetAllPoints()

                    if PhoUI.DARK_MODE then
                        PlaceholderButton.Border:SetDesaturated(1)
                        PlaceholderButton.Border:SetVertexColor(0.2, 0.2, 0.2)
                    end

                    AddSeparator(RightBar, PlaceholderButton, "LEFT", -2)

                    if i == 6 then
                        RightBar:SetSize(POS_X + Size, 50)
                    end
                end
            end
        end
        
        local function MenuPager()
            local MenuPager = CreateFrame("FRAME", nil, Actionbar)
            MenuPager:SetSize(36, 36)
            MenuPager:SetPoint("LEFT", PagerPos+37, 1)
            MenuPager:SetFrameLevel(99)

            MenuPager.BG = MenuPager:CreateTexture()
            MenuPager.BG:SetAllPoints()
            MenuPager.BG:SetColorTexture(0, 0, 0, .8)

            local ButtonUP = CreateFrame("Frame", nil, MenuPager)
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

            if PhoUI.DARK_MODE then
                MainMenuBar.ActionBarPageNumber.UpButton:GetNormalTexture():SetVertexColor(0.2, 0.2, 0.2)
            end

            MainMenuBar.ActionBarPageNumber.UpButton:Show()

            local ButtonDown = CreateFrame("Frame", nil, MenuPager)
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
            
            if PhoUI.DARK_MODE then
                MainMenuBar.ActionBarPageNumber.DownButton:GetNormalTexture():SetVertexColor(0.2, 0.2, 0.2)
            end

            MainMenuBar.ActionBarPageNumber.DownButton:Show()

            local PageNumber = CreateFrame("Frame", nil, MenuPager)
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
            MainMenuBar.ActionBarPageNumber.Text:SetFont(PhoUI.DEFAULT_FONT, 11, "OUTLINE")
        end

        CreateBorder()
        PlaceholderButtons()
        MenuPager()
   
        if db.gryphons then
            local Faction = UnitFactionGroup("player")
            Gryphons(Faction)
        end
    end

    CreateBorderArt()


    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR")
    self.EventFrame:RegisterEvent("PET_BATTLE_CLOSE")
    self.EventFrame:RegisterEvent("PET_BATTLE_OPENING_START")

    self.EventFrame:SetScript("OnEvent", function(s, e, ...) 
        if C_PetBattles.IsInBattle() or HasVehicleActionBar() then
            _G[p .. "Actionbar"]:Hide()
        else
            _G[p .. "Actionbar"]:Show()
        end
    end)

end