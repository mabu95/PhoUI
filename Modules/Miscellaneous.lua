local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Miscellaneous")

function Module:OnEnable()
    local db = PhoUI.db.profile.miscellaneous
    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("MERCHANT_SHOW")
    self.EventFrame:RegisterEvent("CHAT_MSG_WHISPER")
    self.EventFrame:RegisterEvent("CHAT_MSG_BN_WHISPER")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self.EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
    self.EventFrame:RegisterEvent("DUEL_REQUESTED")
    self.EventFrame:RegisterEvent("DUEL_FINISHED")
    self.EventFrame:RegisterEvent("CHAT_MSG_SYSTEM")

    local function AutoSell()
        self.EventFrame:SetScript("OnEvent", function(s, e, ...)
            if e == "MERCHANT_SHOW" then
                for Bag = 0, 4 do
                    for Slot = 0, C_Container.GetContainerNumSlots(Bag) do
                        local ContainerItemLink = C_Container.GetContainerItemLink(Bag, Slot)
                        if ContainerItemLink and select(3, GetItemInfo(ContainerItemLink)) == 0 then
                            C_Container.UseContainerItem(Bag, Slot)
                        end
                    end
                end
            end
        end)
    end

    local function AutoRepair(Type)
        self.EventFrame:SetScript("OnEvent", function(s, e, ...)
            if e == "MERCHANT_SHOW" then
                if CanMerchantRepair() then
                    local Cost = GetRepairAllCost()

                    if Cost > 0 then
                        local Money = GetMoney()

                        -- If Type == Guild
                        if IsInGuild() and Type == "guild" then
                            local GetGuildBankWithdrawMoney = GetGuildBankWithdrawMoney()

                            if GetGuildBankWithdrawMoney > GetGuildBankMoney() then
                                GetGuildBankWithdrawMoney = GetGuildBankMoney()
                            end

                            if GetGuildBankWithdrawMoney > Cost and CanGuildBankRepair() then
                                RepairAllItems(1)
                            end
                        end

                        -- If Type == Default
                        if Money > Cost then
                            RepairAllItems()
                        end
                    end
                end
            end
        end)
    end

    local function AutoInvite()
        self.EventFrame:SetScript("OnEvent", function(s, e, arg1, arg2, ...)
            if((not UnitExists("party1") or UnitIsGroupLeader("player") or UnitIsGroupAssistant("player"))) then
                if arg1 == db.auto_invite_message then
                    if e == "CHAT_MSG_WHISPER" then
                        C_PartyInfo.InviteUnit(arg2)
                    elseif e == "CHAT_MSG_BN_WHISPER" then
                        local BNET_ID = select(11, ...)
                        local BNET_INFO = C_BattleNet.GetAccountInfoByID(BNET_ID)
                        BNInviteFriend(BNET_INFO.gameAccountInfo.gameAccountID)
                    end
                end
            end
        end)
    end

    local function TabBinder()
        local TB_Fail, TB_DefaultKey, TB_LastTargetKey, TB_TargetKey, TB_CurrentBind, TB_Success = false, true
        self.EventFrame:SetScript("OnEvent", function(s, e, ...)
            if e == "CHAT_MSG_SYSTEM" then

            elseif e == "ZONE_CHANGED_NEW_AREA" or e == "PLAYER_ENTERING_WORLD" or ( e == "PLAYER_REGEN_ENABLED" and TB_Fail) or e == "DUEL_REQUESTED" or e == "DUEL_FINISHED" then
                local TB_BindSet = GetCurrentBindingSet()
                local TB_PvPType = GetZonePVPInfo()
                local _, TB_ZoneType = IsInInstance()

                TB_TargetKey = GetBindingKey("TARGETNEARESTENEMYPLAYER")
                if TB_TargetKey == nil then
                    TB_TargetKey = GetBindingKey("TARGETNEARESTENEMY")
                end
                if TB_TargetKey == nil and TB_DefaultKey == true then
                    TB_TargetKey = "TAB"
                end

                TB_LastTargetKey = GetBindingByKey("TARGETPREVIOUSENEMYPLAYER")
                if TB_LastTargetKey == nil then
                    TB_LastTargetKey = GetBindingKey("TARGETPREVIOUSENEMY")
                end
                if TB_LastTargetKey == nil and TB_DefaultKey == true then
                    TB_LastTargetKey = "SHIFT-TAB"
                end

                if TB_TargetKey ~= nil then
                    TB_CurrentBind = GetBindingAction(TB_TargetKey) 
                end

                if TB_ZoneType == "arena" or TB_PvPType == "combat" or TB_ZoneType == "pvp" or e == "DUEL_REQUESTED" then
                    if TB_CurrentBind ~= "TARGETNEARESTENEMYPLAYER" then
                        if TB_TargetKey == nil then
                            TB_Success = 1
                        else
                            TB_Success = SetBinding(TB_TargetKey, "TARGETNEARESTENEMYPLAYER")
                        end
                        if TB_LastTargetKey ~= nil then
                            SetBinding(TB_LastTargetKey, "TARGETPREVIOUSENEMYPLAYER")
                        end
                        if TB_Success == 1 then
                            SaveBindings(TB_BindSet)
                            TB_Fail = false
                        else
                            TB_Fail = true
                        end
                    end
                else
                    if TB_CurrentBind ~= "TARGETNEARESTENEMY" then
                        if TB_TargetKey == nil then
                            TB_Success = 1
                        else
                            TB_Success = SetBinding(TB_TargetKey, "TARGETNEARESTENEMY")
                        end

                        if TB_LastTargetKey ~= nil then
                            SetBinding(TB_LastTargetKey, "TARGETPREVIOUSENEMY")
                        end

                        if TB_Success == 1 then
                            SaveBindings(TB_BindSet)
                            TB_Fail = false
                        else
                            TB_Fail = true
                        end
                    end
                end
            end
        end)
    end

    -- Surrender Arena with Command
    SLASH_SURRENDERPHOUI = "/" .. db.pvp_surrender
    SlashCmdList.SURRENDERPHOUI = SurrenderArena;

    if db.auto_sell then
        AutoSell()
    end

    if db.auto_repair ~= "no" then
        local Type = db.auto_repair
        AutoRepair(Type)
    end

    if db.auto_invite then
        AutoInvite()
    end

    if db.pvp_tabbinder then
        TabBinder()
    end
end