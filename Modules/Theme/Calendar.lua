------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Calendar")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end
    
    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("ADDON_LOADED")
    self.EventFrame:SetScript("OnEvent", function(s, e, v)
        if v == "Blizzard_Calendar" then
            for _, v in pairs({
                CalendarFrameTopMiddleTexture,
                CalendarFrameRightTopTexture,
                CalendarFrameRightMiddleTexture,
                CalendarFrameRightBottomTexture,
                CalendarFrameBottomRightTexture,
                CalendarFrameBottomMiddleTexture,
                CalendarFrameBottomLeftTexture,
                CalendarFrameLeftMiddleTexture,
                CalendarFrameLeftTopTexture,
                CalendarFrameLeftBottomTexture,
                CalendarFrameTopLeftTexture,
                CalendarFrameTopRightTexture,
                CalendarCreateEventFrame.Header.CenterBG,
                CalendarCreateEventFrame.Header.LeftBG,
                CalendarCreateEventFrame.Header.RightBG,
                CalendarCreateEventFrameButtonBackground,
                CalendarCreateEventCreateButtonBorder,
                CalendarCreateEventMassInviteButtonBorder,
            }) do
                PhoUI.StyleFrame(v)
            end
            PhoUI.StyleFrame(CalendarCreateEventMassInviteButtonBorder)
            PhoUI.StyleButton(CalendarCloseButton)
            PhoUI.StyleButton(CalendarCreateEventCloseButton)
        end
    end)
end
