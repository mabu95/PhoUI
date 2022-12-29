------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Tooltip")

function Module:OnEnable()
    local PT = CreateFrame("GameTooltip", "PhoUIToolTip", UIParent)
    local CB = GetCVar("colorblindMode")

    o = {}

    local function Update_TooltipDataType()
        o.Unit = GetMouseFocus() == WorldFrame and "mouseover" or select(2, GameTooltip:GetUnit())

        if not o.Unit then return end

        o.Reaction = UnitReaction(o.Unit, "player") or nil
        if not o["Reaction"] then return end
        if UnitIsWildBattlePet(o["Unit"]) then return end

        o.TipUnitName, o.TipUnitRealm   = UnitName(o.Unit)
        o.TipIsPlayer                   = UnitIsPlayer(o.Unit)
        o.UnitLevel                     = UnitEffectiveLevel(o.Unit)
        o.RealLevel                     = UnitLevel(o.Unit)
        o.UnitClass                     = UnitClassBase(o.Unit)
        o.PlayerControl                 = UnitPlayerControlled(o.Unit)
        o.PlayerRace                    = UnitRace(o.Unit)

        if o.UnitClass then
            o.Sex = UnitSex(o.Unit)
            o.Class = o.Sex == 2 and LOCALIZED_CLASS_NAMES_MALE[o.UnitClass] or LOCALIZED_CLASS_NAMES_FEMALE[o.UnitClass]

            o.ClassColor = RAID_CLASS_COLORS[o.UnitClass]
            o.TipClassColor = "|cff" .. string.format("%02x%02x%02x", o.ClassColor.r * 255, o.ClassColor.g * 255, o.ClassColor.b * 255)
        end

        if o.TipIsPlayer then
            local GuildName, GuildRank = GetGuildInfo(o.Unit)

            if GuildName and GuildRank then
                if CB == "1" then
                    o.GI, o.UI = 2, 4
                else
                    o.GI, o.UI = 2, 3
                end

                o.GuildName, o.GuildRank = GuildName, GuildRank
            else
                o.GuildName = nil

                if CB == "1" then
                    o.GI, o.UI = 0, 3
                else
                    o.GI, o.UI = 0, 2
                end
            end

            if UnitIsCharmed(o.Unit) then
                o.UI = o.UI + 1
            end
        end

        if o.TipIsPlayer and o.GuildName then
            local FactionName = UnitFactionGroup(o.Unit)
            local Color = FactionName == "Horde" and "FF7979" or "7979FF"
            _G["GameTooltipTextLeft" .. o.GI]:SetText("|c00" .. Color .. o.GuildName .. " - " .. o.GuildRank .. "|r")
        end

        if (o.TipIsPlayer or p.PlayerControl) or o.Reaction > 4 then
            if o.TipIsPlayer then
                o.NameColor = o.TipClassColor
            else
                o.NameColor = UnitIsPVP(o.Unit) and "|cff00ff00" or "|cff00aaff"
            end

            o.NameText = UnitPVPName(o.Unit) or o.TipUnitName

            if o.TipUnitRealm then o.NameText = o.NameText .. " - " .. o.TipUnitRealm end

            if UnitIsDeadOrGhost(o.Unit) then o.NameColor = "|c88888888" end
            _G["GameTooltipTextLeft1"]:SetText(o.NameColor .. o.NameText .. "|cffffffff|r")
        elseif UnitIsDeadOrGhost(o.Unit) then
            _G["GameTooltipTextLeft1"]:SetText("|c88888888" .. (_G["GameTooltipTextLeft1"]:GetText() or "") .. "|cffffffff|r")
        end

        if o.TipIsPlayer then
            if o.Reaction < 5 then
                if o.UnitLevel == -1 then
                    o.InfoText = ("|cffff3333Level ??|cffffffff")
                else
                    o.LevelDifficulty = C_PlayerInfo.GetContentDifficultyCreatureForPlayer(o.Unit)
                    o.LevelColor = GetDifficultyColor(o.LevelDifficulty)
                    o.LevelColor = string.format('%02x%02x%02x', o.LevelColor.r * 255, o.LevelColor.g * 255, o.LevelColor.b * 255)
                    o.InfoText = ("|cff" .. o.LevelColor .. "Level" .. " " .. o.UnitLevel .. "|cffffffff")
                end
            else
                if o.UnitLevel ~= o.RealLevel then
                    o.InfoText = "Level " .. o.UnitLevel .. "(" .. o.RealLevel .. ")"
                else
                    o.InfoText = "Level " .. o.UnitLevel
                end
            end
            if o.PlayerRace then
                o.InfoText = o.InfoText .. " " .. o.PlayerRace
            end

            o.InfoText = o.InfoText .. " " .. o.TipClassColor .. o.Class or o.InfoText
            _G["GameTooltipTextLeft" .. o.UI]:SetText(o.InfoText .. "|cffffffff|r")
        end


        -- # Show Target
        o.Target = UnitName(o.Unit .. "target");
        if o.Target == nil or o.Target == "" then return end

        if (UnitIsUnit(o.Target, "player")) then 
            o.Target = ("|c12ff4400" .. "You")
        elseif UnitIsPlayer(o.Unit .. "target") then
            o.TargetBase = UnitClassBase(o.Unit .. "target")
            o.TargetColor = RAID_CLASS_COLORS[o.TargetBase]
            o.TargetColor = "|cff" .. string.format('%02x%02x%02x', o.TargetColor.r * 255, o.TargetColor.g * 255, o.TargetColor.b * 255)
            o.Target = (o.TargetColor .. o.Target)
        end
        GameTooltip:AddLine("Target: " .. o.Target)
    end

    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, Update_TooltipDataType)

    hooksecurefunc("SharedTooltip_SetBackdropStyle", function(self)
        if not self.SetBackdrop then
            Mixin(self, BackdropTemplateMixin)
        end
        
        local backdrop = {
            bgFile = "Interface\\Buttons\\WHITE8x8",
            bgColor = {0.03, 0.03, 0.03, 0.9},
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            borderColor = {0.1, 0.1, 0.1, 0.9},
            azeriteBorderColor = {1, 0.3, 0, 0.9},
            tile = false,
            tileEdge = false,
            tileSize = 16,
            edgeSize = 16,
            insets = {left=3, right=3, top=3, bottom=3}
          }      
          self:SetBackdrop(backdrop)
          
          self:SetBackdropBorderColor(0.1, 0.1, 0.1, 0)
          self:SetBackdropColor(0, 0, 0, .1)

        self.NineSlice:SetBorderColor(0.2, 0.2, 0.2)
    end)
end