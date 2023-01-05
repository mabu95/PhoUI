------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Talents")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end
    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("ADDON_LOADED")
    self.EventFrame:SetScript("OnEvent", function(s, e, v)
        if v == "Blizzard_ClassTalentUI" then
            PhoUI.StyleChilds(ClassTalentFrame.NineSlice)
            if ClassTalentFrame.TalentsTab.BottomBar ~= nil then
                PhoUI.StyleFrame(ClassTalentFrame.TalentsTab.BottomBar)
            end
            for _, Frame in pairs({
                ClassTalentFrameTalentsPvpTalentFrameTalentListScrollFrameScrollBarThumbTexture,
                ClassTalentFrameTalentsPvpTalentFrameTalentListScrollFrameScrollBarTop,
                ClassTalentFrameTalentsPvpTalentFrameTalentListScrollFrameScrollBarMiddle,
                ClassTalentFrameTalentsPvpTalentFrameTalentListScrollFrameScrollBarBottom,
                
            }) do
                PhoUI.StyleFrame(Frame)
            end

            local Tabs = ClassTalentFrame.TabSystem
            for _, Tab in ipairs({Tabs:GetChildren()}) do
                PhoUI.StyleTab(Tab)
            end

            PhoUI.StyleButton(ClassTalentFrameCloseButton)
        end
    end)
end