------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Achievment")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("ADDON_LOADED")
    self.EventFrame:SetScript("OnEvent", function(s, e, v)
        if v == "Blizzard_AchievementUI" then
            for _, Frame in pairs({ 
                AchievementFrameHeaderRight,
                AchievementFrame.Header.Left,
                AchievementFrame.Header.Right,
                AchievementFrame.Header.RightDDLInset,
                AchievementFrame.Searchbox,
                AchievementFrameSummary.Background,
                AchievementFrameCategoriesBG,
                AchievementFrame.Background,
                AchievementFrameWoodBorderTopLeft,
                AchievementFrameWoodBorderBottomLeft,
                AchievementFrameWoodBorderTopRight,
                AchievementFrameWoodBorderBottomRight,
                AchievementFrameMetalBorderBottom,
                AchievementFrameMetalBorderBottomLeft,
                AchievementFrameMetalBorderBottomRight,
                AchievementFrameMetalBorderLeft,
                AchievementFrameMetalBorderRight,
                AchievementFrameMetalBorderTop,
                AchievementFrameMetalBorderTopLeft,
                AchievementFrameMetalBorderTopRight,
            }) do
                Frame:SetVertexColor(0.1, 0.1, 0.1)
            end

            PhoUI.StyleButton(AchievementFrameCloseButton)
        end
    end)
end