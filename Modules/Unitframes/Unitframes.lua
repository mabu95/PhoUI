local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Unitframes")

function Module:OnEnable()
    local DB = PhoUI.db.profile.unitframes
    local PhoUI_UnitReaction = {
        [1] = {r = 236/255, g = 64/255, b = 36/255},
        [2] = {r = 236/255, g = 64/255, b = 36/255},
        [3] = {r = 253/255, g = 91/255, b = 0},
        [4] = {r = 255/255, g = 228/255, b = 0},
        [5] = {r = 0/255, g = 255/255, b = 0},
        [6] = {r = 0/255, g = 255/255, b = 0},
        [7] = {r = 0/255, g = 255/255, b = 0},
        [8] = {r = 0/255, g = 255/255, b = 0},
    }

    function SetColoredStatusBars(Statusbar)
        Statusbar:SetStatusBarDesaturated(1)
        if UnitIsPlayer(Statusbar.unit) and UnitIsConnected(Statusbar.unit) and UnitClass(Statusbar.unit) then
            _, Class = UnitClass(Statusbar.unit)
            local Color = RAID_CLASS_COLORS[Class]
            Statusbar:SetStatusBarColor(Color.r, Color.g, Color.b)
        elseif UnitIsPlayer(Statusbar.unit) and not UnitIsConnected(Statusbar.unit) then
            Statusbar:SetStatusBarColor(.5, .5, .5)
        else
            if UnitExists(Statusbar.unit) then
                if (not UnitPlayerControlled(Statusbar.unit) and UnitIsTapDenied(Statusbar.unit)) then
                    Statusbar:SetStatusBarColor(.5, .5, .5)
                elseif not UnitIsTapDenied(Statusbar.unit) then
                    local Reaction = FACTION_BAR_COLORS[UnitReaction(Statusbar.unit, "player")]
                    if Reaction then
                        Statusbar:SetStatusBarColor(Reaction.r, Reaction.g, Reaction.b)
                    end
                end
            end
        end
    end

    local function SetUnColoredStatusBars(Statusbar)
        if UnitExists(Statusbar.unit) then
            Statusbar:SetStatusBarDesaturated(1)
            if (not UnitPlayerControlled(Statusbar.unit) and UnitIsTapDenied(Statusbar.unit)) or (UnitIsPlayer(Statusbar.unit) and not UnitIsConnected(Statusbar.unit)) then
                Statusbar:SetStatusBarColor(.5, .5, .5)
            else
                local Reaction = PhoUI_UnitReaction[UnitReaction(Statusbar.unit, "player")]
                --print(UnitReaction(Statusbar.unit, "player"))
                if Reaction then
                    Statusbar:SetStatusBarColor(Reaction.r, Reaction.g, Reaction.b);
                end
                 --else
                --    Statusbar:SetStatusBarColor(UnitSelectionColor(Statusbar.unit), 1);
                      --Statusbar:SetStatusBarColor(UnitSelectionColor(Statusbar.unit), true);
                --end
                
            end
        end
    end

    if DB.classcolor then
        hooksecurefunc("UnitFrameHealthBar_Update", SetColoredStatusBars)
        hooksecurefunc("HealthBar_OnValueChanged", SetColoredStatusBars)
    else
        hooksecurefunc("UnitFrameHealthBar_Update", SetUnColoredStatusBars)
        hooksecurefunc("HealthBar_OnValueChanged", SetUnColoredStatusBars)
    end

    if DB.texture ~= "default" then
        hooksecurefunc("UnitFrameManaBar_UpdateType", function(self)
            if self and self.unitFrame then
                local u = self.unitFrame
                local Texture = PhoUI:GetTexture(DB.texture)

                if u.manabar then
                    u.manabar.texture:SetTexture(Texture)
                    local PowerColor = GetPowerBarColor(u.manabar.powerType)
                    if PowerColor then
                        if u.manabar.powerType == 0 then
                            u.manabar:SetStatusBarColor(0, 0.5, 1)
                        else
                            u.manabar:SetStatusBarColor(PowerColor.r, PowerColor.g, PowerColor.b)
                        end
                    end
                end
            end
        end)
    end

    -- Fix Bigdebuffs
    if IsAddOnLoaded("BigDebuffs") then
        hooksecurefunc(BigDebuffs, "UNIT_AURA", function(self, unit)
            local Frame = self.UnitFrames[unit]
            if not Frame then return end

            if Frame.mask then
                if Frame.unit == "player" then
                    Frame.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
                    Frame.icon:SetDrawLayer("BACKGROUND")
                    
                    Frame:SetFrameLevel(PlayerFrame.PlayerFrameContainer:GetFrameLevel())
                end

                if Frame.unit == "target" then
                    Frame.icon:SetDrawLayer("BACKGROUND")
                    Frame:SetFrameLevel(TargetFrame.TargetFrameContainer:GetFrameLevel())
                end

                if Frame.unit == "focus" then
                    Frame.icon:SetDrawLayer("BACKGROUND")
                    Frame:SetFrameLevel(FocusFrame.TargetFrameContainer:GetFrameLevel())
                end
            end
        end)
    end

    function self:CheckStyle()
        return DB.frame_style == "big" or DB.frame_style == "small" and true or false
    end

    function self.AddPlayerFrameBorder(Style)
        local FrameInfo = {
            {
                Width = 99,
                Height = 81,
                Pos = -9,
                TexCoord = { 0.388671875, 0.001953125, 0.001953125, 0.318359375 }
            },
            {
                Width = 80,
                Height = 79,
                Pos = 11,
                TexCoord = { 0.314453125, 0.001953125, 0.634765625, 0.943359375 }
            },
            {
                Width = 80,
                Height = 79,
                Pos = 11,
                TexCoord = { 0.314453125, 0.001953125, 0.322265625, 0.630859375 }
            }
        }
        
        FrameInfo = FrameInfo[Style]

        local FrameBorder = CreateFrame("Frame", "PlayerFrameBorder", PlayerFrame)
        FrameBorder:SetFrameLevel(PlayerFrame:GetFrameLevel() + 8)
        FrameBorder:SetSize(FrameInfo.Width, FrameInfo.Height)
        FrameBorder:SetPoint("TOPLEFT", FrameInfo.Pos, -7)

        FrameBorder.Border = FrameBorder:CreateTexture()
        FrameBorder.Border:SetTexture("interface/hud/uiunitframeboss2x")
        FrameBorder.Border:SetTexCoord(unpack(FrameInfo.TexCoord))
        FrameBorder.Border:SetAllPoints()

        if PhoUI.DARK_MODE then
            FrameBorder.Border:SetDesaturated(1)
            FrameBorder.Border:SetVertexColor(0.2, 0.2, 0.2)
        end
    end
end