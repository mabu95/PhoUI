------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Map")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end
    PhoUI.StyleChilds(WorldMapFrame.BorderFrame.NineSlice)
    PhoUI.StyleChilds(WorldMapFrame.NavBar)
    PhoUI.StyleButton(WorldMapFrameCloseButton)
    PhoUI.StyleFrame(WorldMapFrame.BorderFrame.Bg)

    MinimapCompassTexture:SetDesaturated(1)
    MinimapCompassTexture:SetVertexColor(0.1, 0.1, 0.1)

    --SetDesaturated

    for _, B in ipairs({WorldMapFrame.BorderFrame.MaximizeMinimizeFrame:GetChildren()}) do
        PhoUI.StyleButton(B)
    end
end