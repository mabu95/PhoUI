------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Spellbook")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end

    PhoUI.StyleChilds(SpellBookFrame.NineSlice)
    PhoUI.StyleChilds(SpellBookFrameInset.NineSlice)
    PhoUI.StyleFrame(SpellBookFrame.Bg)
    PhoUI.StyleButton(SpellBookFrame.CloseButton)
    PhoUI.StyleTab(SpellBookFrameTabButton1)
    PhoUI.StyleTab(SpellBookFrameTabButton2)
    PhoUI.StyleTab(SpellBookFrameTabButton3)
    PhoUI.StyleTab(SpellBookFrameTabButton4)
    PhoUI.StyleTab(SpellBookFrameTabButton5)
end