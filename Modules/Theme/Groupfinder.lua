------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Groupfinder")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end

    PhoUI.StyleChilds(PVEFrame.NineSlice)
    PhoUI.StyleChilds(PVEFrameLeftInset.NineSlice)
    PhoUI.StyleChilds(LFDParentFrameInset.NineSlice)
    PhoUI.StyleChilds(RaidFinderFrameRoleInset.NineSlice)
    PhoUI.StyleChilds(RaidFinderFrameBottomInset.NineSlice)
    PhoUI.StyleChilds(LFGListFrame.CategorySelection.Inset.NineSlice)
    PhoUI.StyleChilds(LFDRoleCheckPopup.Border)
    PhoUI.StyleChilds(PVPReadyDialog.Border)

    for _, Frame in pairs({
        PVEFrame.Bg,
        LFDQueueFrameBackground,
        LFDParentFrameRoleBackground,
        PVEFrameTopFiligree,
        PVEFrameBottomFiligree,
        PVEFrameBlueBg,
        LFGListFrame.CategorySelection.Inset.CustomBG
    }) do
        PhoUI.StyleFrame(Frame)
    end

    PhoUI.StyleTab(PVEFrameTab1)
    PhoUI.StyleTab(PVEFrameTab2)
    PhoUI.StyleTab(PVEFrameTab3)

    PhoUI.StyleButton(PVEFrameCloseButton)
end