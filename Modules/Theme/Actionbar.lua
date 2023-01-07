------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Theme.Actionbar")

function Module:OnEnable()
    local db = PhoUI.db.profile.actionbar

    if not PhoUI.DARK_MODE then return end
    
    -- Make Menu dark
    if not db.menu_enable then
        local MICRO = {
            CharacterMicroButton,
            SpellbookMicroButton,
            TalentMicroButton,
            AchievementMicroButton,
            QuestLogMicroButton,
            GuildMicroButton,
            LFDMicroButton,
            CollectionsMicroButton,
            EJMicroButton,
            StoreMicroButton,
            MainMenuMicroButton,
            MainMenuBarBackpackButton,
        }

        BagBarExpandToggle:GetNormalTexture():SetVertexColor(0.2, 0.2, 0.2)

        for i = 1, #MICRO do
            MICRO[i]:GetNormalTexture():SetVertexColor(0.3, 0.3, 0.3)
        end

        local BAGS = {
            CharacterBag0Slot,
            CharacterBag1Slot,
            CharacterBag2Slot,
            CharacterBag3Slot,
            CharacterReagentBag0Slot
        }
    
        self.EventFrame = CreateFrame("Frame")
        self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
        self.EventFrame:RegisterEvent("BAG_UPDATE")
        self.EventFrame:SetScript("OnEvent", function()
            for i = 1, #BAGS do
                local BagButton = BAGS[i]
                hooksecurefunc(BagButton, "UpdateTextures", function(self)
                    if self.styled == nil then
                        self:GetNormalTexture():SetDesaturated(1)
                        self:GetNormalTexture():SetVertexColor(0.3, 0.3, 0.3)
                        self.darkmode = true
                    end
                end)
            end
        end)
    end

    -- Make Actionbar dark
    if not db.enable then
        MainMenuBar.EndCaps.LeftEndCap:SetDesaturated(1)
        MainMenuBar.EndCaps.LeftEndCap:SetVertexColor(0.4, 0.4, 0.4)
        MainMenuBar.EndCaps.RightEndCap:SetDesaturated(1)
        MainMenuBar.EndCaps.RightEndCap:SetVertexColor(0.4, 0.4, 0.4)

        PhoUI.StyleChilds(MainMenuBar.Background, true)
        PhoUI.StyleChilds(MainMenuBar.BorderArt)
        PhoUI.StyleChilds(MainMenuBar.ActionBarPageNumber.UpButton)
        PhoUI.StyleChilds(MainMenuBar.ActionBarPageNumber.DownButton)

        PhoUI.StyleChilds(StatusTrackingBarManager)
    end
end