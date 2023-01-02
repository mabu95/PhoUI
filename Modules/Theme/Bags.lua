------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Bags")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end

    PhoUI.StyleChilds(ContainerFrame1MoneyFrame.Border)
    PhoUI.StyleChilds(BackpackTokenFrame.Border)
    PhoUI.StyleChilds(ContainerFrameCombinedBags.Bg)
    ContainerFrameCombinedBags.Bg.BottomLeft:SetColorTexture(0.1, 0.1, 0.1)
    ContainerFrameCombinedBags.Bg.BottomRight:SetColorTexture(0.1, 0.1, 0.1)
    PhoUI.StyleChilds(ContainerFrameCombinedBags.NineSlice)
    PhoUI.StyleChilds(ContainerFrameCombinedBags.MoneyFrame.Border)

    PhoUI.StyleButton(ContainerFrameCombinedBags.CloseButton)

    for i = 1, 6 do
        PhoUI.StyleChilds(_G["ContainerFrame" .. i].NineSlice)
        PhoUI.StyleChilds(_G["ContainerFrame" .. i].Bg)
        _G["ContainerFrame" .. i].Bg.BottomLeft:SetColorTexture(0.1, 0.1, 0.1)
        _G["ContainerFrame" .. i].Bg.BottomRight:SetColorTexture(0.1, 0.1, 0.1)

        PhoUI.StyleButton(_G["ContainerFrame" .. i].CloseButton)

        for b = 1, 36 do
            local normalTexture = _G["ContainerFrame" .. i .. "Item" .. b .. "NormalTexture"]
            normalTexture:SetVertexColor(unpack(PhoUI.THEME_COLOR))
        end
    end
end