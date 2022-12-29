------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Menu")

function Module:OnEnable()
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

    function self:CreateBorderArt()

        PhoUI:HideFrame(MainMenuMicroButton.MainMenuBarPerformanceBar)
        MainMenuMicroButton.MainMenuBarPerformanceBar:SetAlpha(0)

        PhoUI:HideFrame(BagBarExpandToggle)
        BagBarExpandToggle:SetAlpha(0)

        local Bags = CreateFrame("Frame", p .. "Bags", MicroButtonAndBagsBar)
        local Menu = CreateFrame("Frame", p .. "Menu", MicroButtonAndBagsBar)
        
        Bags:SetPoint("TOPRIGHT", MicroButtonAndBagsBar, "TOPRIGHT", 3, -6)
        Bags:SetSize(216, 50)
        Bags:SetFrameLevel(0)

        Menu:SetPoint("BOTTOMRIGHT", MicroButtonAndBagsBar, "BOTTOMRIGHT", 3, -2)
        Menu:SetSize(235, 40)
        Menu:SetFrameLevel(2)

        Menu.Background = Menu:CreateTexture()
        Menu.Background:SetAtlas("talents-background-bottombar", true)
        Menu.Background:SetPoint("TOPLEFT", 3.5, -3.5)
        Menu.Background:SetPoint("BOTTOMRIGHT", -7, 6.5)

        Bags.Background = Bags:CreateTexture()
        Bags.Background:SetAtlas("talents-background-bottombar", true)
        Bags.Background:SetPoint("TOPLEFT", 3.5, -2.5)
        Bags.Background:SetPoint("BOTTOMRIGHT", -7, 6.5)

        MainMenuBarBackpackButton:SetSize(30, 30)
        MainMenuBarBackpackButton:ClearAllPoints()
        MainMenuBarBackpackButton:SetPoint("TOPRIGHT", MicroButtonAndBagsBar, "TOPRIGHT", -7, -11)

        MainMenuBarBackpackButtonCount:ClearAllPoints()
        MainMenuBarBackpackButtonCount:SetPoint("CENTER", 0, -5)

        for i = 1, #BagButtons do
            local Button = BagButtons[i]
            local LastButton = i == 1 and MainMenuBarBackpackButton or BagButtons[i-1]

            Button:SetSize(30, 30)
            Button:ClearAllPoints()

            if i == 1 then
                Button:SetPoint("RIGHT", MainMenuBarBackpackButton, "LEFT", -4, 0)
            else
                Button:SetPoint("RIGHT", LastButton, "LEFT", -4, 0)
            end
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
            local MenuBorder = CreateFrame("Frame", p .. "MenuBorder", Menu)
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
            local BagsBorder = CreateFrame("Frame", p .. "BagsBorder", Bags)
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

    self:CreateBorderArt()

    local function UpdateBagButtonTexture(Button)
        Button.CircleMask:Hide()

        Button.NormalTexture:SetTexture(PhoUI.TEXTURE_PATH .. "Button")
        Button.SlotHighlightTexture:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Highlight")

        local Normal = Button:GetNormalTexture()
        local Highlight = Button:GetHighlightTexture()
        local Pushed = Button:GetPushedTexture()

        Normal:SetTexture(PhoUI.TEXTURE_PATH .. "Button")
        Highlight:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Highlight")
        Pushed:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Highlight")

        if PhoUI.DARK_MODE then
            Normal:SetVertexColor(0.2, 0.2, 0.2)
        end
    end

    self.EventFrame = CreateFrame("FRAME")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:RegisterEvent("BAG_UPDATE")
    self.EventFrame:SetScript("OnEvent", function()
        MainMenuBarBackpackButton.CircleMask:Hide()

        MainMenuBarBackpackButton.icon:SetTexture("interface/mainmenubar/mainmenubar")
        MainMenuBarBackpackButton.icon:SetTexCoord(0.638671875, 0.701171875, 0.65234375, 0.90234375)
        
        if MainMenuBarBackpackButton.styled == nil then
            UpdateBagButtonTexture(MainMenuBarBackpackButton)
            MainMenuBarBackpackButton.styled = true
        end

        for i = 1, #BagButtons do
            local Button = BagButtons[i]
            if Button.styled == nil then
                hooksecurefunc(Button, "UpdateTextures", function(self) 
                    UpdateBagButtonTexture(self)
                end)
                Button.styled = true
            end
        end
    end)

    for i = 1, #MicroButtons do
        local Button = MicroButtons[i]
        if Button.Border == nil then

            local Height = Button:GetNormalTexture():GetHeight()

            Button.Border = Button:CreateTexture()
            Button.Border:SetTexture(PhoUI.TEXTURE_PATH .. "Button")
            Button.Border:SetPoint("TOPLEFT", 0, 0)
            Button.Border:SetPoint("BOTTOMRIGHT", 0, 0)
            Button.Border:SetHeight(Height)

            if PhoUI.DARK_MODE then
                Button.Border:SetVertexColor(0.2, 0.2, 0.2)
            end
        end
    end
end