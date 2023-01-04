------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("BuffsDebuffs")

function Module:OnEnable()
    local BuffCollapse = PhoUI.db.profile.unitframes.buff_collapse

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:RegisterUnitEvent("UNIT_AURA", "player")

    if BuffCollapse then
        self.EventFrame:SetScript("OnEvent", function(s, e, ...)
            BuffFrame.CollapseAndExpandButton:Hide()
        end)
    end

    local HOOKED_BUFFS = {}
    local function UpdateBuffs(self)
        for Frame, _ in pairs(self.activeObjects) do
            if not HOOKED_BUFFS[Frame] then
                HOOKED_BUFFS[Frame] = true

                if not Frame.Backdrop then
                    Frame.Backdrop = CreateFrame("Frame", nil, nil, "BackdropTemplate")
                    Frame.Backdrop:SetFrameLevel(Frame:GetFrameLevel() - 1)

                    Frame.Backdrop:SetBackdrop({
                        bgFile = "",
                        edgeFile = PhoUI.TEXTURE_PATH .. "Backdrop",
                        tile = false, tileSize = 0,
                        edgeSize = 5,
                        insets = { left = 5, right = 5, top = 5, bottom = 5 }
                    })
                    Frame.Backdrop:SetBackdropBorderColor(0, 0, 0, 1)
                    Frame.Backdrop:SetPoint("TOPLEFT", Frame, "TOPLEFT", -3, 3)
                    Frame.Backdrop:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", 2, -2)
                end
            end
        end
    end

    if PhoUI.DARK_MODE then
        for _, p in pairs(TargetFrame.auraPools.pools) do
            hooksecurefunc(p, "Acquire", UpdateBuffs)
        end
    end
end