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
    
                MainMenuBarButton:SetSize(41, 41)
                MainMenuBarButton:ClearAllPoints()
                MainMenuBarButton:SetPoint("CENTER", PlacerholderButtonLeft, "CENTER", 0, 0)
    
                MultiBarBottomLeftButton:SetSize(41, 41)
                MultiBarBottomLeftButton:ClearAllPoints()
                MultiBarBottomLeftButton:SetPoint("CENTER", PlacerholderButtonLeft, "CENTER", 0, 50)
    
                if db.style == "full" then
                    MultiBarBottomRightButton:SetSize(41, 41)
                    if i <= 6 then
                        MultiBarBottomRightButton:ClearAllPoints()
                        MultiBarBottomRightButton:SetPoint("CENTER", PlacerholderButtonRight, "CENTER", 0, 0)
                    else
                        local i = i - 6
                        PlacerholderButtonRight = _G[p .. "PlaceholderButtonRight" .. i]
                        MultiBarBottomRightButton:ClearAllPoints()
                        MultiBarBottomRightButton:SetPoint("CENTER", PlacerholderButtonRight, "CENTER", 0, 50)
                    end
                end
            end

            StanceBar:ClearAllPoints()
            StanceBar:SetPoint("TOPLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 3, 35)

            PetActionBar:ClearAllPoints()
            PetActionBar:SetPoint("TOPLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 3, 35)
        end

        local function UpdateButton(Button, SetSize)
            local Width, Height = 0, 0

            if db.enable and SetSize then
                Button:SetSize(41, 41)
            end
    
            Width, Height = Button:GetSize()

            Button:GetNormalTexture():SetSize(Width, Height)
            Button:SetNormalTexture(PhoUI.TEXTURE_PATH .. "Button")
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
            _G[Button:GetName() .. "Cooldown"]:SetPoint("TOPLEFT", Button, "TOPLEFT", 0, 0)
            _G[Button:GetName() .. "Cooldown"]:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 0, 0)

            Button.CheckedTexture:SetAllPoints()
            Button:GetPushedTexture():SetAllPoints()
            Button.HighlightTexture:SetAllPoints()

            if Button and Button.Backdrop == nil then
                Button.Backdrop = CreateFrame("Frame", Button:GetName() .. "Backdrop", Button, "BackdropTemplate")
                Button.Backdrop:SetFrameLevel(Button:GetFrameLevel() - 1)
                Button.Backdrop:SetBackdrop({
                    bgFile = "",
                    edgeFile = PhoUI.TEXTURE_PATH .. "Backdrop",
                    tile = false, tileSize = 32,
                    edgeSize = 6,
                    insets = { left = 3, right = 3, top = 3, bottom = 3 }
                })
                Button.Backdrop:SetPoint("TOPLEFT", Button, "TOPLEFT", -2, 2)
                Button.Backdrop:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", 2, -2)
                Button.Backdrop:SetBackdropBorderColor(0, 0, 0, .6)
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

    function UpdateKeybind(Button)
        local HotKey = _G[Button:GetName() .. "HotKey"]
        if db.short_keybinds then
            local Text = HotKey:GetText()
            
            for i = 0, 9 do

                --print(KEY_NUMLOCK)
                if Text == _G["KEY_NUMPAD"..i] then
                    Text = gsub(Text, _G["KEY_NUMPAD"..i], "Nu"..i)
                end
                --
            end

            HotKey:SetText(Text)
        end
    end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:RegisterEvent("UPDATE_BINDINGS")
    self.EventFrame:SetScript("OnEvent", self.Init)
end