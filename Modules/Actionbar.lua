------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Actionbar = PhoUI:NewModule("Actionbar")

function Actionbar:OnEnable()
    local db = PhoUI.db.profile.actionbar
    local Dominos, Bartender4 = IsAddOnLoaded("Dominos"), IsAddOnLoaded("Bartender4")
    if Dominos or Bartender4 then return end

    if not db.enable and db.enable_buttons then
        return
    end

    function self:Init()
        if db.enable then
            MultiBarBottomRight:SetFrameLevel(2)
            MainMenuBar:ClearAllPoints()
            MainMenuBar:SetPoint("LEFT", PhoUIActionbar, "LEFT", -4, 0)
    
            for i = 1, 12 do
                local MainMenuBarButton         = _G["ActionButton" .. i]
                local MultiBarBottomRightButton = _G["MultiBarBottomRightButton" .. i]
                local MultiBarBottomLeftButton  = _G["MultiBarBottomLeftButton" .. i]
    
                local PlacerholderButtonLeft    = _G[p .. "PlaceholderButtonLeft" .. i]
                local PlacerholderButtonRight   = _G[p .. "PlaceholderButtonRight" .. i]
    
                MainMenuBarButton:ClearAllPoints()
                MainMenuBarButton:SetPoint("CENTER", PlacerholderButtonLeft, "CENTER", 0, 0)
    
                MainMenuBarButton.RightDivider:Hide()
                MainMenuBarButton.RightDivider:Hide()

                MultiBarBottomLeftButton:ClearAllPoints()
                MultiBarBottomLeftButton:SetPoint("CENTER", PlacerholderButtonLeft, "CENTER", 0, 43)
    
                if db.style == "full" then
                    if i <= 6 then
                        MultiBarBottomRightButton:ClearAllPoints()
                        MultiBarBottomRightButton:SetPoint("CENTER", PlacerholderButtonRight, "CENTER", 0, 0)
                    else
                        local i = i - 6
                        PlacerholderButtonRight = _G[p .. "PlaceholderButtonRight" .. i]
                        MultiBarBottomRightButton:ClearAllPoints()
                        MultiBarBottomRightButton:SetPoint("CENTER", PlacerholderButtonRight, "CENTER", 0, 43)
                    end
                end
            end

            -- Right Bars
            for i = 1, 12 do
                local ButtonLeft = _G["MultiBarLeftButton" .. i]
                local ButtonRight = _G["MultiBarRightButton" .. i]

                local POS_X = (i - 1) * 39 + 8

                ButtonLeft:ClearAllPoints()
                ButtonLeft:SetPoint("TOPLEFT", MultiBarLeft, "TOPLEFT", 0, -POS_X)

                ButtonRight:ClearAllPoints()
                ButtonRight:SetPoint("TOPLEFT", MultiBarRight, "TOPLEFT", 0, -POS_X)
            end

            StanceBar:ClearAllPoints()
            StanceBar:SetPoint("TOPLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 3, 35)

            PetActionBar:ClearAllPoints()
            PetActionBar:SetPoint("TOPLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 3, 35)
        end

        local function UpdateButton(Button, SetSize)
            local Icon = _G[Button:GetName() .. "Icon"]
            --local Mask = _G[Button:GetName()].IconMask
            --Mask:Hide()
            --[[
            Icon:SetTexCoord(.08, .92, .08, .92)
            Icon:ClearAllPoints()
            Icon:SetPoint("TOPLEFT", 1, -1)
            Icon:SetPoint("BOTTOMRIGHT", -1, 1)
            Icon:SetDrawLayer("BACKGROUND")
            ]]

            local Width, Height = Button:GetSize()

            if db.enable and SetSize then
                Width, Height = _G[p .. "PlaceholderButtonLeft1"]:GetSize()
                Width = Width - 2
                Height = Height - 2
                Button:SetScale(1)
                Button:SetSize(Width, Height)
            end

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

            --_G[Button:GetName()].SpellHighlightTexture:SetTexture(PhoUI.TEXTURE_PATH .. "Button_Pushed")
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
            
            UpdateKeybind(Button)
        end
    
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

    local function ShortKeybinds(Text)
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
            ["SM4"] = "C%" .. KEY_BUTTON3,
            ["CM4"] = "S%" .. KEY_BUTTON3,
            ["CM3"] = "C%" .. KEY_BUTTON4,
            ["SM3"] = "S%" .. KEY_BUTTON4,
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

    function UpdateKeybind(Button)
        local HotKey = _G[Button:GetName() .. "HotKey"]
        local Macro = _G[Button:GetName() .. "Name"]
        local Count = _G[Button:GetName() .. "Count"]
        local Text = HotKey:GetText()

        if Text == nil then return end

        if db.short_keybinds then
            Text = ShortKeybinds(Text)
        end

        HotKey:SetFont(PhoUI.DEFAULT_FONT, db.text_size, "OUTLINE")
        Macro:SetFont(PhoUI.DEFAULT_FONT, db.text_size, "OUTLINE")
        Count:SetFont(PhoUI.DEFAULT_FONT, db.text_size, "OUTLINE")

        HotKey:SetAlpha(db.hotkey and 1 or 0)
        Macro:SetAlpha(db.macro and 1 or 0)

        HotKey:SetText(Text)
    end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:RegisterEvent("UPDATE_BINDINGS")
    self.EventFrame:SetScript("OnEvent", self.Init)
end