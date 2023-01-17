local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Actionbar.Actionbar")
local LibEditModeOverride = LibStub("LibEditModeOverride-1.0")

function Module:OnEnable()

    local DB = PhoUI.db.profile.actionbar
    local Dominos, Bartender4 = IsAddOnLoaded("Dominos"), IsAddOnLoaded("Bartender4")
    local MainMenuBar = MainMenuBar
    local MultiBarBottomRight = MultiBarBottomRight
    local StanceBar = StanceBar
    local PetActionBar = PetActionBar
    local MultiBarBottomLeftButton1 = MultiBarBottomLeftButton1
    local MultiBarLeft = MultiBarLeft
    local MultiBarRight = MultiBarRight
    local MultiBarBottomLeft = MultiBarBottomLeft

    local function MoveBars()

        -- Update Frame Levels
        MultiBarBottomLeft:SetFrameLevel(MainMenuBar:GetFrameLevel() + 1)
        MultiBarBottomRight:SetFrameLevel(MainMenuBar:GetFrameLevel() + 1)

        for i = 1, 12 do
            local MainMenuBarButton         = _G["ActionButton" .. i]
            local MultiBarBottomRightButton = _G["MultiBarBottomRightButton" .. i]
            local MultiBarBottomLeftButton  = _G["MultiBarBottomLeftButton" .. i]
            local PlacerholderButtonLeft    = _G[P .. "PlaceHolderButtonLeft" .. i]
            local PlacerholderButtonRight   = _G[P .. "PlaceHolderButtonRight" .. i]

            MainMenuBarButton.RightDivider:Hide()
            MainMenuBarButton.RightDivider:Hide()
            MainMenuBar.EndCaps:Hide()
            MainMenuBar.Background:Hide()
            MainMenuBar.BorderArt:Hide()

            MainMenuBarButton:ClearAllPoints()
            MainMenuBarButton:SetPoint("CENTER", PlacerholderButtonLeft, "CENTER", 0, 0)

            MultiBarBottomLeftButton:ClearAllPoints()
            MultiBarBottomLeftButton:SetPoint("CENTER", PlacerholderButtonLeft, "CENTER", 0, 43)

            if DB.style == "full" then
                if i <= 6 then
                    MultiBarBottomRightButton:ClearAllPoints()
                    MultiBarBottomRightButton:SetPoint("CENTER", PlacerholderButtonRight, "CENTER", 0, 0)
                else
                    local i = i - 6
                    PlacerholderButtonRight = _G[P .. "PlaceHolderButtonRight" .. i]
                    MultiBarBottomRightButton:ClearAllPoints()
                    MultiBarBottomRightButton:SetPoint("CENTER", PlacerholderButtonRight, "CENTER", 0, 43)
                end
            elseif DB.style == "classic" then
                MultiBarBottomRightButton:ClearAllPoints()
                MultiBarBottomRightButton:SetPoint("CENTER", PlacerholderButtonRight, "CENTER", 0, 0)
            end
        end

        for i = 1, 12 do
            local ButtonLeft = _G["MultiBarLeftButton" .. i]
            local ButtonRight = _G["MultiBarRightButton" .. i]

            local PosX = (i - 1) * 39 + 8

            ButtonLeft:ClearAllPoints()
            ButtonLeft:SetPoint("TOPLEFT", MultiBarLeft, "TOPLEFT", 0, -PosX)

            ButtonRight:ClearAllPoints()
            ButtonRight:SetPoint("TOPLEFT", MultiBarRight, "TOPLEFT", 0, -PosX)
        end
    end

    local function UpdateButton(Button, SetSize)
        UpdateButtonText(Button)

        if not DB.custom_buttons then
            if PhoUI.DARK_MODE then
                Button:GetNormalTexture():SetVertexColor(0.2, 0.2, 0.2)
                if Button.RightDivider then
                    Button.RightDivider:SetVertexColor(0.2, 0.2, 0.2)
                end
            end
        end

        local Width, Height = Button:GetSize()

        if DB.enable and SetSize then
            Width, Height = _G[P .. "PlaceHolderButtonLeft1"]:GetSize()
            Width = Width - 2
            Height = Height - 2

            Button:SetScale(1)
            Button:SetSize(Width, Height)
        end

        if DB.enable or DB.custom_buttons then
            PhoUI:SetButtonAtlas(Button, "NormalTexture", "Button_Border")
            Button:GetNormalTexture():SetSize(Width, Height)

            Button:SetHighlightTexture(PhoUI.TEXTURE_PATH .. "Button_Highlight")
            Button:SetPushedTexture(PhoUI.TEXTURE_PATH .. "Button_Pushed")
            Button.CheckedTexture:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Highlight")

            if PhoUI.DARK_MODE then
                Button:GetNormalTexture():SetVertexColor(0.2, 0.2, 0.2)
            end
            
            if _G[Button:GetName() .. "Border"] then
                _G[Button:GetName() .. "Border"]:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Border")
                _G[Button:GetName() .. "Border"]:ClearAllPoints()
                _G[Button:GetName() .. "Border"]:SetAllPoints()
            end

            _G[Button:GetName() .. "Cooldown"]:ClearAllPoints()
            _G[Button:GetName() .. "Cooldown"]:SetPoint("TOPLEFT", Button, "TOPLEFT", -1, -1)
            _G[Button:GetName() .. "Cooldown"]:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 0, 0)

            _G[Button:GetName()].NewActionTexture:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Pushed")
            _G[Button:GetName()].NewActionTexture:ClearAllPoints()
            _G[Button:GetName()].NewActionTexture:SetPoint("TOPLEFT", Button, "TOPLEFT", 0, 0)
            _G[Button:GetName()].NewActionTexture:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 0, 0)

            _G[Button:GetName()].SpellHighlightTexture:ClearAllPoints()
            _G[Button:GetName()].SpellHighlightTexture:SetPoint("TOPLEFT", Button, "TOPLEFT", 0, 0)
            _G[Button:GetName()].SpellHighlightTexture:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 0, 0)

            Button.CheckedTexture:SetAllPoints()
            Button:GetPushedTexture():SetAllPoints()
            Button.HighlightTexture:SetAllPoints()

            if Button and Button.Backdrop == nil then
                Button.Backdrop = CreateFrame("Frame", Button:GetName() .. "Backdrop", Button, "BackdropTemplate")
                Button.Backdrop:SetFrameLevel(Button:GetFrameLevel() - 1)
                if PhoUI.DARK_MODE then
                    Button.Backdrop:SetBackdrop({
                        bgFile = "",
                        edgeFile = PhoUI.TEXTURE_PATH .. "Backdrop",
                        tile = false, tileSize = 0,
                        edgeSize = 5,
                        insets = { left = 5, right = 5, top = 5, bottom = 5 }
                    })
                    Button.Backdrop:SetBackdropBorderColor(0, 0, 0, 1)
                else
                    Button.Backdrop:SetBackdrop({
                        bgFile = "",
                        edgeFile = PhoUI.TEXTURE_PATH .. "Backdrop",
                        tile = false, tileSize = 0,
                        edgeSize = 5,
                        insets = { left = 5, right = 5, top = 5, bottom = 5 }
                    })
                    Button.Backdrop:SetBackdropBorderColor(0, 0, 0, .4)
                end

                Button.Backdrop:SetPoint("TOPLEFT", Button, "TOPLEFT", -3, 3)
                Button.Backdrop:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 2, -2)
            end
        end
    end

    local function Init()
        if DB.enable then
            MoveBars()
        end

        -- Style Buttons
        for i = 1, 12 do
            UpdateButton(_G["ActionButton" .. i], true);
            UpdateButton(_G["MultiBarBottomLeftButton" .. i], true);
            UpdateButton(_G["MultiBarBottomRightButton" .. i], true);
            UpdateButton(_G["MultiBarRightButton" .. i], true);
            UpdateButton(_G["MultiBarLeftButton" .. i], true);
            UpdateButton(_G["MultiBar5Button" .. i], true);
            UpdateButton(_G["MultiBar6Button" .. i], true);
            UpdateButton(_G["MultiBar7Button" .. i], true);
    
            if i < 11 then
                UpdateButton(_G["StanceButton" .. i]);
                UpdateButton(_G["PetActionButton" .. i]);
            end
        end
    end

    function ShortHotkeys(Text)
        for i = 0, 9 do
            if Text == _G["KEY_NUMPAD"..i] then
                Text = gsub(Text, _G["KEY_NUMPAD"..i], "Nu"..i)
            end
        end

        local Keys = {
            -- Numpad Buttons
            ["Nu."] = KEY_NUMPADDECIMAL,
            ["Nu/"] = KEY_NUMPADDIVIDE,
            ["Nu-"] = KEY_NUMPADMINUS,
            ["Nu*"] = KEY_NUMPADMULTIPLY,
            ["Nu+"] = KEY_NUMPADPLUS,

            -- Mouse Buttons
            ["WU"] = KEY_MOUSEWHEELUP,
            ["WD"] = KEY_MOUSEWHEELDOWN,
            ["ML"] = KEY_BUTTON1,
            ["MR"] = KEY_BUTTON2,
            ["M3"] = KEY_BUTTON3,
            ["M4"] = KEY_BUTTON4,
            ["M5"] = KEY_BUTTON5,

            -- Extra Buttons
            ["NuL"] = KEY_NUMLOCK,
            ["PU"] = KEY_PAGEUP,
            ["PD"] = KEY_PAGEDOWN,
            ["_"] = KEY_SPACE,
            ["Ins"] = KEY_INSERT,
            ["Hm"] = KEY_HOME,
            ["Del"] = KEY_DELETE,
            ["Caps"] = Capslock,
        }

        for i, v in pairs(Keys) do
            if Text == v then
                Text = gsub(Text, v, i)
            end
        end

        Text = gsub(Text, "(s%-)", "S")
        Text = gsub(Text, "(a%-)", "A")
        Text = gsub(Text, "(c%-)", "C")
        Text = gsub(Text, "(st%-)", "C")

        local ModList = {
            ["CWU"] = "C%" .. KEY_MOUSEWHEELUP,
            ["SWU"] = "S%" .. KEY_MOUSEWHEELUP,
            ["CWD"] = "C%" .. KEY_MOUSEWHEELDOWN,
            ["SWD"] = "S%" .. KEY_MOUSEWHEELDOWN,
            ["CML"] = "C%" .. KEY_BUTTON1,
            ["SML"] = "S%" .. KEY_BUTTON1,
            ["SMR"] = "C%" .. KEY_BUTTON2,
            ["CMR"] = "S%" .. KEY_BUTTON2,
            ["SM3"] = "C%" .. KEY_BUTTON3,
            ["CM3"] = "S%" .. KEY_BUTTON3,
            ["CM4"] = "C%" .. KEY_BUTTON4,
            ["SM4"] = "S%" .. KEY_BUTTON4,
            ["SM5"] = "C%" .. KEY_BUTTON5,
            ["CM5"] = "S%" .. KEY_BUTTON5,
        }

        for i, v in pairs(ModList) do
            if strmatch(Text, "(" .. v .. ")") then
                Text = gsub(Text, v, i)
            end
        end

        return Text
    end

    function UpdateButtonText(Button)
        local Name = Button:GetName()
        local HotKey = _G[Name .. "HotKey"]
        local Macro = _G[Name .. "Name"]
        local Count = _G[Name .. "Count"]
        local Text = HotKey:GetText()

        local FontName, _, _ = NumberFontNormalSmallGray:GetFont()

        if PhoUI.db.profile.general.disable_font then
            HotKey:SetFont(FontName, DB.text_size, "OUTLINE")
            Macro:SetFont(FontName, DB.text_size, "OUTLINE")
            Count:SetFont(FontName, DB.text_size, "OUTLINE")
        else
            HotKey:SetFont(PhoUI.FONT, DB.text_size, "OUTLINE")
            Macro:SetFont(PhoUI.FONT, DB.text_size, "OUTLINE")
            Count:SetFont(PhoUI.FONT, DB.text_size, "OUTLINE")
        end

        if Text == nil then return end

        HotKey:SetAlpha(DB.hotkey and 1 or 0)
        Macro:SetAlpha(DB.macro and 1 or 0)

        Macro:ClearAllPoints()
        Macro:SetPoint("BOTTOM", 0, 4)
        
        if DB.short_hotkey then
            Text = ShortHotkeys(Text)
            HotKey:SetText(Text)
        end
    end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:RegisterEvent("UPDATE_BINDINGS")
    self.EventFrame:SetScript("OnEvent", Init)
end