local P, H, O, Y, K = ...
local Module = PhoUI:NewModule("Actionbar.Menu")

function Module:OnEnable()
    local MainMenuBarBackpackButton = MainMenuBarBackpackButton
    local MainMenuBarBackpackButtonCount = MainMenuBarBackpackButtonCount
    local BagBarExpandToggle = BagBarExpandToggle
    local BagsBar = BagsBar
    local MicroMenu = MicroMenu
    local PhoUIActionbar = _G[P .. "Actionbar"]
    local DB = PhoUI.db.profile.actionbar
    local ActionbarStyle = DB.style

    SetCVar("expandBagBar", true)

    local BagButtons = {
        CharacterBag0Slot,
        CharacterBag1Slot,
        CharacterBag2Slot,
        CharacterBag3Slot,
        CharacterReagentBag0Slot
    }

    local MicroButtons = {
        CharacterMicroButton,
        SpellbookMicroButton,
        TalentMicroButton,
        AchievementMicroButton,
        QuestLogMicroButton,
        GuildMicroButton,
        LFDMicroButton,
        CollectionsMicroButton,
        EJMicroButton,
        StoreMicroButton,
        MainMenuMicroButton,
    }

    local function ApplyClassicStyle()
        local MenuFrame = CreateFrame("Frame", nil, PhoUIActionbar)
        MenuFrame:SetSize(260, 38)
        MenuFrame:SetPoint("RIGHT", -200, 0.5)
        MenuFrame:SetFrameLevel(0)

        MainMenuBarBackpackButton:ClearAllPoints()
        MainMenuBarBackpackButton:SetPoint("RIGHT", PhoUIActionbar, "RIGHT", -11, 0)

        for i = 1, 2 do
            local Separator = CreateFrame("Frame", nil, MenuFrame)
            Separator:SetSize(2, 40)
            if i == 1 then
                Separator:SetPoint("LEFT", 0, 0)
            else
                Separator:SetPoint("RIGHT", 0, 0)
            end

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
                Separator.Top:SetVertexColor(0.2, 0.2, 0.2)
                Separator.Center:SetVertexColor(0.2, 0.2, 0.2)
                Separator.Bottom:SetVertexColor(0.2, 0.2, 0.2)
            end
        end

        for i = 1, #MicroButtons do
            local MicroButton = MicroButtons[i]
            local PosX = (i - 1) * 22 + 10

            MicroButton:SetParent(MenuFrame)
            MicroButton:ClearAllPoints()
            MicroButton:SetPoint("LEFT", PosX, -1)

            MicroButton.Border = MicroButton:CreateTexture(nil, "OVERLAY")
            PhoUI:SetAtlas(MicroButton.Border, "Button_Border")
            MicroButton.Border:SetPoint("TOPLEFT", 0, 2)
            MicroButton.Border:SetPoint("BOTTOMRIGHT", 0, 1)

            if PhoUI.DARK_MODE then
                MicroButton.Border:SetVertexColor(0.2, 0.2, 0.2)
            end

            MicroButton.FlashBorder:ClearAllPoints()
            MicroButton.FlashBorder:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Highlight")
            MicroButton.FlashBorder:SetPoint("TOPLEFT", 0, 2.5)
            MicroButton.FlashBorder:SetPoint("BOTTOMRIGHT", 0, -1)
        end

        for i = 1, #BagButtons do
            local BagButton = BagButtons[i]
            local LastBagButton = i == 1 and MainMenuBarBackpackButton or BagButtons[i - 1]
            local Point = i == 1 and MainMenuBarBackpackButton or LastBagButton

            BagButton:SetSize(31, 31)
            BagButton:ClearAllPoints()
            BagButton:SetPoint("RIGHT", Point, "LEFT", 0, 0)
        end
    end

    local function ApplyNewStyle()
        local Bags = CreateFrame("Frame", P .. "Bags", BagsBar)
        local Menu = CreateFrame("Frame", P .. "Menu", MicroMenu)

        Bags:SetPoint("TOPRIGHT", BagsBar, "TOPRIGHT", 3, -6)
        Bags:SetSize(202, 50)
        Bags:SetFrameLevel(0)

        Bags.Background = Bags:CreateTexture()
        Bags.Background:SetAtlas("talents-background-bottombar", true)
        Bags.Background:SetPoint("TOPLEFT", 3.5, -2.5)
        Bags.Background:SetPoint("BOTTOMRIGHT", -7, 6.5)

        MainMenuBarBackpackButton:ClearAllPoints()
        MainMenuBarBackpackButton:SetPoint("TOPRIGHT", BagsBar, "TOPRIGHT", -7, -11)

        MainMenuBarBackpackButtonCount:ClearAllPoints()
        MainMenuBarBackpackButtonCount:SetPoint("CENTER", 0, -5)

        Menu:SetPoint("BOTTOMRIGHT", MicroMenu, "BOTTOMRIGHT", 3, -2)
        Menu:SetSize(235, 40)
        Menu:SetFrameLevel(2)

        Menu.Background = Menu:CreateTexture()
        Menu.Background:SetAtlas("talents-background-bottombar", true)
        Menu.Background:SetPoint("TOPLEFT", 3.5, -3.5)
        Menu.Background:SetPoint("BOTTOMRIGHT", -7, 6.5)

        for i = 1, #BagButtons do
            local BagButton = BagButtons[i]
            local LastBagButton = i == 1 and MainMenuBarBackpackButton or BagButtons[i - 1]
            local Point = i == 1 and MainMenuBarBackpackButton or LastBagButton

            BagButton:SetSize(31, 31)
            BagButton:ClearAllPoints()
            BagButton:SetPoint("RIGHT", Point, "LEFT", 0, 0)
        end

        MainMenuMicroButton.MainMenuBarPerformanceBar:SetAlpha(0)
        for i = 1, #MicroButtons do
            local MicroButton = MicroButtons[i]
            local PosX = (i - 1) * 20 + 6

            MicroButton:SetParent(Menu)
            MicroButton:ClearAllPoints()
            MicroButton:SetPoint("LEFT", PosX, 0)

            MicroButton.Border = MicroButton:CreateTexture(nil, "OVERLAY")
            PhoUI:SetAtlas(MicroButton.Border, "Button_Border")
            MicroButton.Border:SetPoint("TOPLEFT", 0, 2)
            MicroButton.Border:SetPoint("BOTTOMRIGHT", 0, 1)

            MicroButton.FlashBorder:ClearAllPoints()
            MicroButton.FlashBorder:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Highlight")
            MicroButton.FlashBorder:SetPoint("TOPLEFT", 0, 2.5)
            MicroButton.FlashBorder:SetPoint("BOTTOMRIGHT", 0, -1)
        end

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
        local function CreateMenuBorder()
            local MenuBorder = CreateFrame("Frame", P .. "MenuBorder", Menu)
            MenuBorder:SetAllPoints()

            for i, v in pairs(BorderObj) do
                MenuBorder[i] = MenuBorder:CreateTexture()
                MenuBorder[i]:SetAtlas(v.Atlas, true)
                if PhoUI.DARK_MODE then
                    MenuBorder[i]:SetDesaturated(1)
                    MenuBorder[i]:SetVertexColor(0.2, 0.2, 0.2)
                end

                for _, point in pairs(v.Point) do
                    MenuBorder[i]:SetPoint(unpack(point))
                end

                if i == "TOPRIGHT" then
                    MenuBorder[i]:Hide()
                end
            end

            MenuBorder.TOP:ClearAllPoints()
            MenuBorder.TOP:SetPoint("TOPLEFT", 17, 0)
            MenuBorder.TOP:SetPoint("TOPRIGHT", -8, 0)

            MenuBorder.RIGHT:ClearAllPoints()
            MenuBorder.RIGHT:SetPoint("TOPRIGHT", 0, 0)
            MenuBorder.RIGHT:SetPoint("BOTTOMRIGHT", 0, 23)
        end

        local function CreateBagsBorder()
            local BagsBorder = CreateFrame("Frame", P .. "BagsBorder", Bags)
            BagsBorder:SetAllPoints()

            for i, v in pairs(BorderObj) do
                BagsBorder[i] = BagsBorder:CreateTexture()
                BagsBorder[i]:SetAtlas(v.Atlas, true)

                if PhoUI.DARK_MODE then
                    BagsBorder[i]:SetDesaturated(1)
                    BagsBorder[i]:SetVertexColor(0.2, 0.2, 0.2)
                end

                for _, point in pairs(v.Point) do
                    BagsBorder[i]:SetPoint(unpack(point))
                end
            end
        end

        CreateBagsBorder()
        CreateMenuBorder()
    end

    if ActionbarStyle == "classic" then
        ApplyClassicStyle()
    else
        if DB.menu_style == "custom" then
            BagsBar:SetClampedToScreen(false)
            MicroMenu:SetClampedToScreen(false)
            ApplyNewStyle()
        elseif DB.menu_style == "hide" then
            MicroButtonAndBagsBar:SetAlpha(0)
            MicroButtonAndBagsBar:Hide()
        end
    end

    local function LayoutBagsBar()

    end

    if BagsBar and BagsBar.Layout then
        PhoUI:SecureHook(BagsBar, "Layout", LayoutBagsBar)
        EventRegistry:UnregisterCallback("MainMenuBarManager.OnExpandChanged", BagsBar);
    end

    local function UpdateBag(BagButton)
        BagButton.CircleMask:Hide()

        BagButton.NormalTexture:SetTexture(PhoUI.TEXTURE_PATH .. "Button")
        BagButton.SlotHighlightTexture:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Highlight")
        
        local Normal = BagButton:GetNormalTexture()
        local Highlight = BagButton:GetHighlightTexture()
        local Pushed = BagButton:GetPushedTexture()

        Normal:SetTexture(PhoUI.TEXTURE_PATH .. "Button")
        Highlight:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Highlight")
        Pushed:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Highlight")

        if PhoUI.DARK_MODE then
            Normal:SetDesaturated(1)
            Normal:SetVertexColor(0.2, 0.2, 0.2)
        end
    end

    if DB.menu_style == "custom" or ActionbarStyle == "classic" then
        PhoUI:HideFrame(BagBarExpandToggle)
        BagBarExpandToggle:SetAlpha(0)
        MainMenuBarBackpackButton:SetSize(31, 31)
    
        MainMenuBarBackpackButtonCount:ClearAllPoints()
        MainMenuBarBackpackButtonCount:SetPoint("CENTER", 0, -5)
    
        self.EventFrame = CreateFrame("FRAME")
        self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
        self.EventFrame:RegisterEvent("BAG_UPDATE")
        self.EventFrame:RegisterEvent("BAG_UPDATE_DELAYED")
        self.EventFrame:RegisterEvent("CVAR_UPDATE");
    
        self.EventFrame:SetScript("OnEvent", function()
            if MainMenuBarBackpackButton.PhoUI == nil then
                MainMenuBarBackpackButton.icon:SetTexture("interface/mainmenubar/mainmenubar")
                MainMenuBarBackpackButton.icon:SetTexCoord(0.638671875, 0.701171875, 0.65234375, 0.90234375)
                UpdateBag(MainMenuBarBackpackButton)
                MainMenuBarBackpackButton.PhoUI = true
            end
    
            for i = 1, #BagButtons do
                local BagButton = BagButtons[i]
                BagButton:Show()
                if BagButton.PhoUI == nil then
                    hooksecurefunc(BagButton, "UpdateTextures", function(self)
                        UpdateBag(self)
                    end)
                    BagButton.PhoUI = true
                end
            end
        end)
    end
end