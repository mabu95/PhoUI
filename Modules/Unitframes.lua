------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Unitframes")

function Module:OnEnable()
    local db = PhoUI.db.profile.unitframes

    local function SetColoredStatusBars(Statusbar)
        Statusbar:SetStatusBarDesaturated(1)
        if UnitIsPlayer(Statusbar.unit) and UnitIsConnected(Statusbar.unit) and UnitClass(Statusbar.unit) then
            _, Class = UnitClass(Statusbar.unit)
            local Color = RAID_CLASS_COLORS[Class]
        
            if db.classcolor then
                Statusbar:SetStatusBarColor(Color.r, Color.g, Color.b)
            else
                Statusbar:SetStatusBarColor(0, 1, 0)
            end
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

    if db.classcolor then
        hooksecurefunc("UnitFrameHealthBar_Update", SetColoredStatusBars)
        hooksecurefunc("HealthBar_OnValueChanged", SetColoredStatusBars)
    end
end