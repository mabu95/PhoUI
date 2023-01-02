------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Character")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end

    for _, F in pairs({
        CharacterFrame.Bg,
        PaperDollInnerBorderLeft,
        PaperDollInnerBorderRight,
        PaperDollInnerBorderTop,
        PaperDollInnerBorderTopLeft,
        PaperDollInnerBorderTopRight,
        PaperDollInnerBorderBottom,
        PaperDollInnerBorderBottomLeft,
        PaperDollInnerBorderBottomRight,
        PaperDollInnerBorderBottom2,
        PaperDollInnerBorderLeft
    }) do
        PhoUI.StyleFrame(F)
    end
    
    for _, F in pairs({
        CharacterFrame.NineSlice,
        TokenFramePopup.Border,
        ReputationDetailFrame.Border,
        CharacterFrameInset.NineSlice,
        CharacterFrameInsetRight.NineSlice
    }) do
        PhoUI.StyleChilds(F)
    end

    for _, v in pairs({
        CharacterFeetSlotFrame,
        CharacterHandsSlotFrame,
        CharacterWaistSlotFrame,
        CharacterLegsSlotFrame,
        CharacterFinger0SlotFrame,
        CharacterFinger1SlotFrame,
        CharacterTrinket0SlotFrame,
        CharacterTrinket1SlotFrame,
        CharacterWristSlotFrame,
        CharacterTabardSlotFrame,
        CharacterShirtSlotFrame,
        CharacterChestSlotFrame,
        CharacterBackSlotFrame,
        CharacterShoulderSlotFrame,
        CharacterNeckSlotFrame,
        CharacterHeadSlotFrame,
        CharacterMainHandSlotFrame,
        CharacterSecondaryHandSlotFrame,
        _G.select(CharacterMainHandSlot:GetNumRegions(), CharacterMainHandSlot:GetRegions()),
        _G.select(CharacterSecondaryHandSlot:GetNumRegions(), CharacterSecondaryHandSlot:GetRegions())
    }) do v:SetAlpha(0) end

    PhoUI.StyleTab(CharacterFrameTab1)
    PhoUI.StyleTab(CharacterFrameTab2)
    PhoUI.StyleTab(CharacterFrameTab3)

    PhoUI.StyleButton(CharacterFrameCloseButton)
end