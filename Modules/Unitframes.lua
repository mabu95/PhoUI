------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Unitframes")

function Module:OnEnable()
    local db = PhoUI.db.profile.unitframes

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

    local function SetColoredStatusBars(Statusbar)
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

    if db.classcolor then
        hooksecurefunc("UnitFrameHealthBar_Update", SetColoredStatusBars)
        hooksecurefunc("HealthBar_OnValueChanged", SetColoredStatusBars)
    else
        hooksecurefunc("UnitFrameHealthBar_Update", SetUnColoredStatusBars)
        hooksecurefunc("HealthBar_OnValueChanged", SetUnColoredStatusBars)
    end
end