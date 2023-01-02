------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.GameMenu")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end

    PhoUI.StyleFrame(GameMenuFrame.Header.CenterBG)
    PhoUI.StyleFrame(GameMenuFrame.Header.LeftBG)
    PhoUI.StyleFrame(GameMenuFrame.Header.RightBG)

    PhoUI.StyleChilds(GameMenuFrame.Border)

    GameMenuFrame.Border.Bg:SetColorTexture(0, 0, 0, .8)
end