local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Castbar")

function Module:OnEnable()
    local PlayerCastingBarFrame = PlayerCastingBarFrame
    local TargetFrameSpellBar = TargetFrameSpellBar
    local FocusFrameSpellBar = FocusFrameSpellBar
    local db = PhoUI.db.profile.castbar

    if not db.enable then return end

    local function AddTimer(Castbar)
        Castbar.Timer = Castbar:CreateFontString()
        Castbar.Timer:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
        Castbar.Timer:SetPoint("RIGHT", Castbar, "RIGHT", -5, 0)
        Castbar.UP = 0.1
    end

    local function UpdateTimer(Castbar, Elapsed)
        if not Castbar.UP then return end

        if Castbar.UP and Castbar.UP < Elapsed then
            if Castbar.casting then
                Castbar.Timer:SetText( format("%.1f", max(Castbar.maxValue - Castbar.value, 0)) .. "/" .. format("%.1f", max(Castbar.maxValue)))
            elseif Castbar.channeling then
                Castbar.Timer:SetText(format("%.1f", max(Castbar.value, 0)) .. "/" .. format("%.1f", max(Castbar.maxValue)))
            else
                Castbar.Timer:SetText("")
            end
        else
            Castbar.UP = Castbar.UP - Elapsed
        end
    end

    local function StyleIcon(Castbar)
        local Size = Castbar:GetHeight()

        Castbar.Icon:Show()
        Castbar.Icon:SetSize(Size + 4, Size + 4) -- 15
        Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
        Castbar.Icon:ClearAllPoints()
        Castbar.Icon:SetPoint("RIGHT", Castbar, "LEFT", -5, 0)

        local Border = Castbar:CreateTexture()
        PhoUI:SetAtlas(Border, "Button_Border")
        Border:SetPoint("TOPLEFT", Castbar.Icon, "TOPLEFT", -1.5, 1.5)
        Border:SetPoint("BOTTOMRIGHT", Castbar.Icon, "BOTTOMRIGHT", 1.5, -1.5)

        local Backdrop = CreateFrame("Frame", "Backdrop", Castbar, "BackdropTemplate")
        Backdrop:SetBackdrop({
            bgFile = "",
            edgeFile = PhoUI.TEXTURE_PATH .. "Backdrop",
            tile = false, tileSize = 0,
            edgeSize = 3,
            insets = { left = 3, right = 3, top = 3, bottom = 3 }
        })
        Backdrop:SetBackdropBorderColor(0, 0, 0, 1)
        Backdrop:SetPoint("TOPLEFT", Castbar.Icon, "TOPLEFT", -3, 3)
        Backdrop:SetPoint("BOTTOMRIGHT", Castbar.Icon, "BOTTOMRIGHT", 3, -3)
        Backdrop:SetFrameLevel(Castbar:GetFrameLevel() - 1)
    end

    if not InCombatLockdown() then
        local CastingBars = {
            PlayerCastingBarFrame,
            TargetFrameSpellBar,
            FocusFrameSpellBar  
        }

        for i = 1, #CastingBars do
            local Castbar = CastingBars[i]

            if PhoUI.DARK_MODE then
                Castbar.Border:SetVertexColor(0.2, 0.2, 0.2)
            end

            if Castbar:GetName() == "PlayerCastingBarFrame" then
                if db.timer then
                    PlayerCastingBarFrame.Text:ClearAllPoints()
                    PlayerCastingBarFrame.Text:SetJustifyH("LEFT")
                    PlayerCastingBarFrame.Text:SetPoint("LEFT", PlayerCastingBarFrame, "LEFT", 5, 0.5)
                    PlayerCastingBarFrame.Text:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
                else
                    PlayerCastingBarFrame.Text:ClearAllPoints()
                    PlayerCastingBarFrame.Text:SetPoint("CENTER", PlayerCastingBarFrame, "CENTER", 0, 0)
                    PlayerCastingBarFrame.Text:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
                end
            else
                Castbar.Text:ClearAllPoints()
                Castbar.Text:SetPoint("CENTER", Castbar, "CENTER", 0, 0)
                Castbar.Text:SetFont(STANDARD_TEXT_FONT, 9, "OUTLINE")
            end

            if Castbar.BorderShield ~= nil then
                Castbar.BorderShield:Show()
                Castbar.BorderShield:ClearAllPoints()
                Castbar.BorderShield:SetPoint("CENTER", Castbar.Icon, "CENTER", 0, -3)
            end

            if db.icon then
                if Castbar.Icon ~= nil then      
                    StyleIcon(Castbar)
                end
            end
        end

        if db.timer then
            AddTimer(PlayerCastingBarFrame)
            PlayerCastingBarFrame:HookScript("OnUpdate", UpdateTimer)
        end
    end

    PlayerCastingBarFrame:HookScript("OnEvent", function()
        PlayerCastingBarFrame.playCastFX = false
        PlayerCastingBarFrame.StandardGlow:Hide()
        PlayerCastingBarFrame.TextBorder:Hide()
    end)

    TargetFrameSpellBar:HookScript("OnEvent", function()
        TargetFrameSpellBar.TextBorder:Hide()
    end)

    FocusFrameSpellBar:HookScript("OnEvent", function()
        FocusFrameSpellBar.TextBorder:Hide()
    end)
end