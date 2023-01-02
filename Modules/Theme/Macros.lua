------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Macros")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("ADDON_LOADED")
    self.EventFrame:SetScript("OnEvent", function(s, e, v)
        if v == "Blizzard_MacroUI" then
            PhoUI.StyleFrame(MacroFrame.Bg)

            PhoUI.StyleChilds(MacroFrame.NineSlice)
            PhoUI.StyleChilds(MacroFrameInset.NineSlice)
            PhoUI.StyleChilds(MacroFrameTextBackground.NineSlice, true)

            PhoUI.StyleFrame(MacroPopupFrame.BG)
            PhoUI.StyleFrame(MacroPopupFrame.BorderBox.BottomEdge)
            PhoUI.StyleFrame(MacroPopupFrame.BorderBox.BottomLeftCorner)
            PhoUI.StyleFrame(MacroPopupFrame.BorderBox.BottomRightCorner)
            PhoUI.StyleFrame(MacroPopupFrame.BorderBox.RightEdge)
            PhoUI.StyleFrame(MacroPopupFrame.BorderBox.TopEdge)
            PhoUI.StyleFrame(MacroPopupFrame.BorderBox.TopLeftCorner)
            PhoUI.StyleFrame(MacroPopupFrame.BorderBox.TopRightCorner)

            PhoUI.StyleButton(MacroFrameCloseButton)
            PhoUI.StyleTab(MacroFrameTab1)
            PhoUI.StyleTab(MacroFrameTab2)
        end
    end)
end