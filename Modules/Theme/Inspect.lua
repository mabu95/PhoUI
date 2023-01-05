------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Inspect")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("ADDON_LOADED")
    self.EventFrame:SetScript("OnEvent", function(s, e, v)
        if v == "Blizzard_InspectUI" then
            PhoUI.StyleChilds(InspectFrame.NineSlice)
            PhoUI.StyleChilds(InspectFrameInset.NineSlice)
            PhoUI.StyleFrame(InspectFrame.Bg)
            _G.select(InspectMainHandSlot:GetNumRegions(), InspectMainHandSlot:GetRegions()):Hide()
            _G.select(InspectSecondaryHandSlot:GetNumRegions(), InspectSecondaryHandSlot:GetRegions()):Hide()
            for _, Frame in pairs({
                InspectModelFrameBorderLeft,
                InspectModelFrameBorderRight,
                InspectModelFrameBorderTop,
                InspectModelFrameBorderTopLeft,
                InspectModelFrameBorderTopRight,
                InspectModelFrameBorderBottom,
                InspectModelFrameBorderBottomLeft,
                InspectModelFrameBorderBottomRight,
                InspectModelFrameBorderBottom2
            }) do
                PhoUI.StyleFrame(Frame)
            end
            for _, Slot in pairs({
                InspectFeetSlotFrame,
                InspectHandsSlotFrame,
                InspectWaistSlotFrame,
                InspectLegsSlotFrame,
                InspectFinger0SlotFrame,
                InspectFinger1SlotFrame,
                InspectTrinket0SlotFrame,
                InspectTrinket1SlotFrame,
                InspectWristSlotFrame,
                InspectTabardSlotFrame,
                InspectShirtSlotFrame,
                InspectChestSlotFrame,
                InspectBackSlotFrame,
                InspectShoulderSlotFrame,
                InspectNeckSlotFrame,
                InspectHeadSlotFrame,
                InspectMainHandSlotFrame,
                InspectSecondaryHandSlotFrame
            }) do
                Slot:SetAlpha(0)
            end
            PhoUI.StyleTab(InspectFrameTab1)
            PhoUI.StyleTab(InspectFrameTab2)
            PhoUI.StyleTab(InspectFrameTab3)
            PhoUI.StyleButton(InspectFrame.CloseButton)
        end
    end)
end