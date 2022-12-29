------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme")

function Module:OnEnable()
    local Theme = PhoUI.db.profile.general.theme

    if Theme == "blizzard" then return end

    local function SetDarkMode(Frame)
        Frame:SetVertexColor(0, 0, 0)
    end

    local function StyleChilds(Frame, ColorTexture)
        local Childs = { Frame:GetRegions() }
        for _, c in ipairs(Childs) do
            c:SetVertexColor(0.2, 0.2, 0.2)
            if ColorTexture then
                c:SetColorTexture(0.2, 0.2, 0.2)
            end
        end
    end

    local function StyleTab(Frame)
        local TabList = {
            Frame.Left,
            Frame.Right,
            Frame.Middle,
        }

        local ActiveTabList = {
            Frame.LeftActive,
            Frame.RightActive,
            Frame.MiddleActive
        }

        for i = 1, #TabList do
            TabList[i]:SetVertexColor(0.2, 0.2, 0.2)
        end

        for i = 1, #ActiveTabList do
            ActiveTabList[i]:SetVertexColor(0.2, 0.2, 0.2, 1)
        end
    end

    -- Bags
    StyleChilds(ContainerFrame1MoneyFrame.Border)
    StyleChilds(BackpackTokenFrame.Border)
    for i = 1, 6 do
        StyleChilds(_G["ContainerFrame" .. i].NineSlice)
        StyleChilds(_G["ContainerFrame" .. i].Bg, true)
        for b = 1, 36 do
            local normalTexture = _G["ContainerFrame" .. i .. "Item" .. b .. "NormalTexture"]
            normalTexture:SetVertexColor(0.2, 0.2, 0.2)
        end
    end
    StyleChilds(ContainerFrameCombinedBags.Bg)
    StyleChilds(ContainerFrameCombinedBags.NineSlice)
    StyleChilds(ContainerFrameCombinedBags.MoneyFrame.Border)

    -- Charframe
    SetDarkMode(CharacterFrame.Bg)
    SetDarkMode(PaperDollInnerBorderLeft)
    SetDarkMode(PaperDollInnerBorderRight)
    SetDarkMode(PaperDollInnerBorderTop)
    SetDarkMode(PaperDollInnerBorderTopLeft)
    SetDarkMode(PaperDollInnerBorderTopRight)
    SetDarkMode(PaperDollInnerBorderBottom)
    SetDarkMode(PaperDollInnerBorderBottomLeft)
    SetDarkMode(PaperDollInnerBorderBottomRight)
    SetDarkMode(PaperDollInnerBorderBottom2)
    StyleChilds(CharacterFrame.NineSlice)
    StyleChilds(TokenFramePopup.Border)
    StyleChilds(ReputationDetailFrame.Border)
    StyleChilds(CharacterFrameInset.NineSlice)
    StyleChilds(CharacterFrameInsetRight.NineSlice)
    SetDarkMode(PaperDollInnerBorderLeft)

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

    StyleTab(CharacterFrameTab1)
    StyleTab(CharacterFrameTab2)
    StyleTab(CharacterFrameTab3)

end