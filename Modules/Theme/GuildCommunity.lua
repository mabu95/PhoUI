------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.GuildCommunity")

function Module:OnEnable()
    if not PhoUI.DARK_MODE then return end
    
    PhoUI.StyleChilds(GuildRegistrarFrame.NineSlice)

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("ADDON_LOADED")
    self.EventFrame:SetScript("OnEvent", function(s, e, v)
        if v == "Blizzard_Communities" then
            PhoUI.StyleChilds(CommunitiesFrame.NineSlice)
            PhoUI.StyleChilds(CommunitiesFrame.GuildMemberDetailFrame.Border)
            PhoUI.StyleChilds(CommunitiesFrameInset.NineSlice)
            PhoUI.StyleChilds(CommunitiesFrameCommunitiesList.InsetFrame.NineSlice)
            PhoUI.StyleChilds(CommunitiesFrame.Chat.InsetFrame.NineSlice)
            PhoUI.StyleChilds(CommunitiesFrame.MemberList.InsetFrame)

            for _, Frame in pairs({
                CommunitiesFrame.Bg,
                CommunitiesFrameInset.Bg,
                CommunitiesFrame.MemberList.ColumnDisplay.Background,
                CommunitiesFrame.ChatEditBox.Left,
                CommunitiesFrame.ChatEditBox.Mid,
                CommunitiesFrame.ChatEditBox.Right,
                CommunitiesFrameCommunitiesList.TopFiligree,
                CommunitiesFrameCommunitiesList.BottomFiligree,
                CommunitiesFrameCommunitiesList.Bg,
                CommunitiesFrameCommunitiesListListScrollFrameThumbTexture,
                CommunitiesFrameCommunitiesListListScrollFrameTop,
                CommunitiesFrameCommunitiesListListScrollFrameMiddle,
                CommunitiesFrameCommunitiesListListScrollFrameBottom,
                CommunitiesFrame.Chat.MessageFrame.ScrollBar.thumbTexture,
                CommunitiesFrame.Chat.MessageFrame.ScrollBar.ScrollBarTop,
                CommunitiesFrame.Chat.MessageFrame.ScrollBar.ScrollBarMiddle,
                CommunitiesFrame.Chat.MessageFrame.ScrollBar.ScrollBarBottom,
                CommunitiesFrame.Chat.MessageFrame.ScrollBar.ScrollUp.Normal,
                CommunitiesFrame.Chat.MessageFrame.ScrollBar.ScrollDown.Normal,
                CommunitiesFrame.Chat.MessageFrame.ScrollBar.ScrollUp.Disabled,
                CommunitiesFrame.Chat.MessageFrame.ScrollBar.ScrollDown.Disabled,
            }) do
                PhoUI.StyleFrame(Frame)
            end
        end
    end)
end