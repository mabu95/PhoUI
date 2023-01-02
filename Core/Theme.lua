------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Color = { 0.3, 0.3, 0.3 }


local function StyleFrame(Frame, ColorTexture)
    if not ColorTexture then
        Frame:SetVertexColor(unpack(Color))
    else
        Frame:SetColorTexture(unpack(Color))
    end
end

local function StyleChilds(Frame, ColorTexture)
    local ChildFrames = { Frame:GetRegions() }
    for _, F in ipairs(ChildFrames) do
        F:SetDesaturation(1)
        F:SetVertexColor(unpack(Color))

        if ColorTexture then
            F:SetColorTexture(0.2, 0.2, 0.2)
        end
    end
end

local function StyleButton(Button)
    Button:GetNormalTexture():SetVertexColor(0.6, 0.6, 0.6)
end

local function StyleTab(Tab)
    local TabList = {
        Tab.Left,
        Tab.Right,
        Tab.Middle,
    }

    local ActiveTabList = {
        Tab.LeftActive,
        Tab.RightActive,
        Tab.MiddleActive
    }

    for i = 1, #TabList do
        TabList[i]:SetVertexColor(unpack(Color))
    end

    for i = 1, #ActiveTabList do
        ActiveTabList[i]:SetVertexColor(unpack(Color))
    end
end

_G[p].THEME_COLOR = Color
_G[p].StyleFrame = StyleFrame
_G[p].StyleChilds = StyleChilds
_G[p].StyleButton = StyleButton
_G[p].StyleTab = StyleTab