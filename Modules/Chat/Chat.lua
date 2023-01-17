local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Chat", "AceHook-3.0")
local Module_ChatHistory = PhoUI:NewModule("Chat.History", "AceHook-3.0")
local Module_ChatLinks = PhoUI:NewModule("Chat.Links", "AceHook-3.0")
local DefaultChatBox = DEFAULT_CHAT_FRAME.editBox
local DefaultChatFrame = DEFAULT_CHAT_FRAME
local ENTRY_EVENT, ENTRY_TIME, HISTORY_LOADED = 30, 31, false
local HistoryDB
local CMDDB
local HistoryEvents = { "PLAYER_LOGIN", "CHAT_MSG_CHANNEL", "CHAT_MSG_EMOTE", "CHAT_MSG_GUILD", "CHAT_MSG_GUILD_ACHIEVEMENT", "CHAT_MSG_OFFICER", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER",	"CHAT_MSG_RAID_WARNING", "CHAT_MSG_SAY", "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM", "CHAT_MSG_YELL" }
local HistoryEventsMaxEntries = 50

local ChatFrames = {
    _G.ChatFrame1,
    _G.ChatFrame2,
    _G.ChatFrame3,
    _G.ChatFrame4,
    _G.ChatFrame5,
    _G.ChatFrame6,
    _G.ChatFrame7,
    _G.ChatFrame8,
    _G.ChatFrame9,
    _G.ChatFrame10
}

function Module:OnEnable()
    local DB = PhoUI.db.profile.chat
    if DB.style ~= "custom" then return end

    for i = 1, NUM_CHAT_WINDOWS do
        local ChatFrame = _G[format("ChatFrame%s", i)]
        local ID = ChatFrame:GetID()
        local Chat = ChatFrame:GetName()
        
        if ChatFrame.PhoUI then return end

        ChatFrame.ScrollBar:Hide()
        ChatFrame.ScrollToBottomButton:Hide()

        local Textures = {
            "Left", "Middle", "Right",
            "ActiveLeft", "ActiveMiddle", "ActiveRight",
            "HighlightLeft", "HighlightMiddle", "HighlightRight"
        }

        for _, TextureFrameName in pairs(Textures) do
            _G[format("ChatFrame%sTab", ID)][TextureFrameName]:SetTexture(nil)
        end

        _G[format("ChatFrame%sTabGlow", ID)]:Hide()

        _G[format("ChatFrame%sEditBoxLeft", ID)]:Hide()
        _G[format("ChatFrame%sEditBoxMid", ID)]:Hide()
        _G[format("ChatFrame%sEditBoxRight", ID)]:Hide()

        _G[Chat]:SetClampedToScreen(false)

        local R1, R2, R3 = select(6, _G[Chat .. "EditBox"]:GetRegions())
        R1:Hide()
        R2:Hide()
        R3:Hide()

        _G[Chat .. "EditBox"]:Hide()

        _G[Chat .. "EditBox"]:HookScript("OnEditFocusGained", function(self) self:Show() end)
        _G[Chat .. "EditBox"]:HookScript("OnEditFocusLost", function(self) if self:GetText() == "" then self:Hide() end end)

        for j = 1, #CHAT_FRAME_TEXTURES do
            if Chat .. CHAT_FRAME_TEXTURES[j] ~= Chat .. "Background" then
                _G[Chat .. CHAT_FRAME_TEXTURES[j]]:SetTexture(nil)
            end
        end

        local EditBoxLeft = _G[Chat .. "EditBoxFocusLeft"]
        local EditBoxMid = _G[Chat .. "EditBoxFocusMid"]
        local EditBoxRight = _G[Chat .. "EditBoxFocusRight"]
        EditBoxLeft:SetAlpha(0)
        EditBoxMid:SetAlpha(0, 0, 0)
        EditBoxRight:SetAlpha(0, 0, 0)

        local ButtonFrame = _G[Chat .. "ButtonFrame"]
        if ButtonFrame then ButtonFrame:SetAlpha(0) end

        local ChatAlertFrame = _G.ChatAlertFrame
        ChatAlertFrame:ClearAllPoints()
        ChatAlertFrame:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", 0, 30)

        ChatFrame.PhoUI = true
    end
end


function Module_ChatHistory:OnEnable()
    local DB = PhoUI.db.profile.chat
    if not DB.enable_history then return end

    HistoryDB = PhoUICharChatDB
    CMDDB = PhoUICharChatCMDDB
    local function AddHistoryLine(e, ...)
        local Buffer = {...}

        if Buffer[1] then
            Buffer[ENTRY_EVENT], Buffer[ENTRY_TIME] = e, time()
            tinsert(HistoryDB, 1, Buffer)
        end

        for i = HistoryEventsMaxEntries, #HistoryDB do
            tremove(HistoryDB, 1)
        end
    end

    for i = #HistoryDB, 1, -1 do
        local Buffer = HistoryDB[i]
        ChatFrame_MessageEventHandler(DefaultChatFrame, Buffer[ENTRY_EVENT], unpack(Buffer))
    end
    HISTORY_LOADED = true

    self.EventFrame = CreateFrame("Frame")
    for i = 1, #HistoryEvents do self.EventFrame:RegisterEvent(HistoryEvents[i]) end

    self.EventFrame:SetScript("OnEvent", function(s, e, ...)
        if e == "PLAYER_ENTERING_WORLD" then

        elseif HISTORY_LOADED then
            AddHistoryLine(e, ...)
        end
    end)

    local EditBox = ChatEdit_ChooseBoxForSend()
    EditBox:SetAltArrowKeyMode(false)
    local Index = 1
    local Count = #CMDDB
    EditBox:SetScript("OnArrowPressed", function(self, Button)

        self:SetText("")

        if Button == "UP" then
            self:SetText(CMDDB[Index])
        elseif Button == "DOWN" then
            self:SetText(CMDDB[Index])
        end
        
        if Index < Count then
            Index = Index + 1
        else
            Index = Index - 1
        end
    end)
end


function Module_ChatHistory:OnInitialize()
    local DB = PhoUI.db.profile.chat
    if not DB.enable_history then return end
    self:SecureHook(DefaultChatBox, "AddHistoryLine")
end


function Module_ChatHistory:AddHistoryLine(EditBox)
    local Text = ""
    local Type = EditBox:GetAttribute("chatType")
    local Header = _G["SLASH_" .. Type .. "1"]

    if Header then
        Text = Header
    end

    if Type == "WHISPER" then
        Text = Text .. " " .. EditBox:GetAttribute("tellTarget")
    elseif Type == "CHANNEL" then
        Text = "/" .. EditBox:GetAttribute("channelTarget")
    end

    local EditBoxText = EditBox:GetText()
    if (strlen(EditBoxText) > 0 and not IsSecureCmd(EditBoxText:match("^/[%a%d_]+") or "")) then
        Text = (Header and (Text .. " ") or "") ..  EditBoxText

        tinsert(CMDDB, Text)

        for i = 10, #CMDDB do
            tremove(CMDDB, 1)
        end
    end
end

-- Chat Links
function Module_ChatLinks:OnEnable()
    for _, Event in next, { "CHAT_MSG_SAY", "CHAT_MSG_YELL", "CHAT_MSG_WHISPER", "CHAT_MSG_WHISPER_INFORM", "CHAT_MSG_GUILD", "CHAT_MSG_OFFICER", "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_RAID", "CHAT_MSG_RAID_LEADER", "CHAT_MSG_RAID_WARNING", "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_INSTANCE_CHAT_LEADER", "CHAT_MSG_BATTLEGROUND", "CHAT_MSG_BATTLEGROUND_LEADER", "CHAT_MSG_BN_WHISPER", "CHAT_MSG_BN_WHISPER_INFORM", "CHAT_MSG_BN_CONVERSATION", "CHAT_MSG_CHANNEL", "CHAT_MSG_SYSTEM" } do
        ChatFrame_AddMessageEventFilter(Event, function(s, e, str, ...)
            for _, Pattern in pairs({"(https://%S+%.%S+)", "(http://%S+%.%S+)", "(www%.%S+%.%S+)", "(%d+%.%d+%.%d+%.%d+:?%d*/?%S*)"}) do
                local Result, Match = string.gsub(str, Pattern, "|cff0394ff|Hurl:%1|h[%1]|h|r")
                if Match > 0 then
                    return false, Result, ...
                end
            end
        end)
    end

    local SetHyperLink = _G.ItemRefTooltip.SetHyperlink
    function _G.ItemRefTooltip:SetHyperlink(Link, ...)
        if Link and strsub(Link, 1, 3) == "url" then
            local EditBox = ChatEdit_ChooseBoxForSend()
            ChatEdit_ActivateChat(EditBox)
            EditBox:Insert(string.sub(Link, 5))
            EditBox:HighlightText()
            return
        end

        SetHyperlink(self, Link, ...)
    end
end