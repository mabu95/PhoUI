local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Unitframes.Playerframe")

function Module:OnEnable()
    local db = PhoUI.db.profile.unitframes

    local function AddFrameBorder(Style)
        local FrameInfo = {
            {
                Width = 99,
                Height = 81,
                Pos = -9,
                TexCoord = { 0.388671875, 0.001953125, 0.001953125, 0.318359375 }
            },
            {
                Width = 80,
                Height = 79,
                Pos = 11,
                TexCoord = { 0.314453125, 0.001953125, 0.634765625, 0.943359375 }
            },
            {
                Width = 80,
                Height = 79,
                Pos = 11,
                TexCoord = { 0.314453125, 0.001953125, 0.322265625, 0.630859375 }
            }
        }
        
        FrameInfo = FrameInfo[Style]

        local FrameBorder = CreateFrame("Frame", "PlayerFrameBorder", PlayerFrame)
        FrameBorder:SetFrameLevel(PlayerFrame:GetFrameLevel() + 8)
        FrameBorder:SetSize(FrameInfo.Width, FrameInfo.Height)
        FrameBorder:SetPoint("TOPLEFT", FrameInfo.Pos, -7)

        FrameBorder.Border = FrameBorder:CreateTexture()
        FrameBorder.Border:SetTexture("interface/hud/uiunitframeboss2x")
        FrameBorder.Border:SetTexCoord(unpack(FrameInfo.TexCoord))
        FrameBorder.Border:SetAllPoints()

        if PhoUI.DARK_MODE then
            FrameBorder.Border:SetDesaturated(1)
            FrameBorder.Border:SetVertexColor(0.2, 0.2, 0.2)
        end
    end

    local function StyleExtraBar()
        if PlayerFrameAlternateManaBar ~= nil then
            PlayerFrameAlternateManaBar.DefaultBorder:SetVertexColor(0.2, 0.2, 0.2)
            PlayerFrameAlternateManaBar.DefaultBorderLeft:SetVertexColor(0.2, 0.2, 0.2)
            PlayerFrameAlternateManaBar.DefaultBorderRight:SetVertexColor(0.2, 0.2, 0.2)
        end
    end

    local function PlayerFrame_ToPlayerArt()
        if db.frame_style ~= "blizzard" then
            PlayerFrame.PlayerFrameContainer.PlayerPortraitMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
            PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetDrawLayer("BACKGROUND")
            PlayerFrame.PlayerFrameContainer.PlayerPortraitMask:SetDrawLayer("BACKGROUND")
            PlayerFrame.PlayerFrameContainer.PlayerPortraitMask:SetSize(58, 58)
            PhoUI:CreateLevelFrame("PlayerLevelFrame", PlayerFrame, PlayerFrame:GetFrameLevel() + 10, {"BOTTOMLEFT", 20, 16})

            PlayerFrame.PlayerFrameContainer:SetFrameLevel(4)
            PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual:SetFrameLevel(5)

            PhoUI:HideFrame(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerPortraitCornerIcon)
            PlayerFrame.healthbar.HealthBarMask:Hide()
            PhoUI:HideFrame(PlayerFrame.healthbar.OverAbsorbGlow)
            PlayerFrame.manabar.ManaBarMask:Hide()
            
            PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigePortrait:ClearAllPoints()
            PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigePortrait:SetPoint("LEFT", PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual, 0, 0)
            PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigePortrait:SetScale(0.8)
        end

        if PhoUI.DARK_MODE then
            PlayerFrame.PlayerFrameContainer.FrameTexture:SetDesaturated(1)
            PlayerFrame.PlayerFrameContainer.FrameTexture:SetVertexColor(0.2, 0.2, 0.2)
    
            StyleExtraBar()
        end

        if db.frame_style == "big" then
            PhoUI:SetAtlas(PlayerFrame.PlayerFrameContainer.FrameTexture, "PlayerFrame_Big", true)
            
            local FrameFlash = PlayerFrame.PlayerFrameContainer.FrameFlash
            PhoUI:SetAtlas(FrameFlash, "PlayerFrame_Big_Flash", true)
            FrameFlash:ClearAllPoints()
            FrameFlash:SetPoint("TOPLEFT", 22, -17)

            local StatusTexture = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture
            StatusTexture:SetParent(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual)
            PhoUI:SetAtlas(StatusTexture, "PlayerFrame_Big_Flash", true)
            StatusTexture:ClearAllPoints()
            StatusTexture:SetPoint("TOPLEFT", 22, -17)

            local HealthBar = PlayerFrame.healthbar
            local ManaBar = PlayerFrame.manabar

            HealthBar.OverAbsorbGlow:Hide()

            HealthBar:SetSize(134, 33)
            ManaBar:SetSize(134, 12)

            HealthBar:ClearAllPoints()
            HealthBar:SetPoint("TOPLEFT", 74, -27)

            ManaBar:ClearAllPoints()
            ManaBar:SetPoint("TOPLEFT", 74, -59.5)

            HealthBar.LeftText:SetPoint("LEFT", HealthBar, "LEFT", 12, 0)
            HealthBar.LeftText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
            HealthBar.RightText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")

            ManaBar.LeftText:SetPoint("LEFT", ManaBar, "LEFT", 12, 0)
            ManaBar.LeftText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
            ManaBar.RightText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
        elseif db.frame_style == "small" then
            PhoUI:SetAtlas(PlayerFrame.PlayerFrameContainer.FrameTexture, "PlayerFrame_Small", true)
            
            local FrameFlash = PlayerFrame.PlayerFrameContainer.FrameFlash
            PhoUI:SetAtlas(FrameFlash, "PlayerFrame_Small_Flash", true)
            FrameFlash:ClearAllPoints()
            FrameFlash:SetPoint("TOPLEFT", 19, -17)

            local StatusTexture = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture
            StatusTexture:SetParent(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual)
            PhoUI:SetAtlas(StatusTexture, "PlayerFrame_Small_Flash", true)
            StatusTexture:ClearAllPoints()
            StatusTexture:SetPoint("TOPLEFT", 22, -16)

            local HealthBar = PlayerFrame.healthbar
            local ManaBar = PlayerFrame.manabar

            HealthBar:SetSize(134, 12)
            ManaBar:SetSize(134, 12)

            HealthBar:ClearAllPoints()
            HealthBar:SetPoint("TOPLEFT", 74, -45.5)

            ManaBar:ClearAllPoints()
            ManaBar:SetPoint("TOPLEFT", 74, -59.5)

            HealthBar.LeftText:SetPoint("LEFT", HealthBar, "LEFT", 12, 0)
            HealthBar.LeftText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
            HealthBar.RightText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")

            ManaBar.LeftText:SetPoint("LEFT", ManaBar, "LEFT", 12, 0)
            ManaBar.LeftText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
            ManaBar.RightText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
        end

        if db.frame_style ~= "blizzard" then
            PlayerLevelText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")

            if PlayerFrame.Background == nil then
                PlayerFrame.Background = PlayerFrame:CreateTexture(nil, "ARTWORK")
                PlayerFrame.Background:SetSize(134, 44)
                PlayerFrame.Background:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 75, -27)
                PlayerFrame.Background:SetColorTexture(0, 0, 0, .6)
            end
        end

        if db.chain ~= "none" then
            AddFrameBorder(db.chain)
            if db.chain == 2 then
                PhoUI:SetAtlas(PlayerLevelFrame.Border, "Level_Rare", true)
            end
        end

        if not db.pvpicon then
            PhoUI:HideFrame(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigePortrait)
            PhoUI:HideFrame(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigeBadge)
        end

        if not db.hitindicator then
            hooksecurefunc(PlayerHitIndicator, "Show", PlayerHitIndicator.Hide)
        end
    end
    

    local function PlayerFrame_UpdateLevel()
        PlayerLevelText:ClearAllPoints();
        PlayerLevelText:SetParent(PlayerLevelFrame)
        PlayerLevelText:SetPoint("CENTER", PlayerLevelFrame, 0, 0)

        PlayerHitIndicator:SetParent(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual)    end

    local function PlayerFrame_UpdatePlayerNameTextAnchor()
        PlayerName:SetJustifyH("CENTER")
        PlayerName:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE")
        PlayerName:ClearAllPoints()

        if db.frame_style == "big" then
            PlayerName:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 97, -13)
        else
            PlayerName:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 97, -30)
        end
    end

    local function PlayerFrame_UpdateStatus()
        local AttackIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.AttackIcon        
        local PlayerRestLoop = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerRestLoop;
        local StatusTexture = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture

        if db.frame_style ~= "blizzard" then
            AttackIcon:SetParent(PlayerLevelFrame)
            AttackIcon:ClearAllPoints()
            AttackIcon:SetPoint("CENTER", PlayerLevelFrame, "CENTER", 0, 0)
            AttackIcon:SetSize(13, 12)
            AttackIcon:SetDrawLayer("OVERLAY", 7)
        end

        if not db.rested then
            if IsResting() then
                PlayerRestLoop:Hide()
                StatusTexture:Hide()
            end
        end

        if db.frame_style ~= "blizzard" then
            if PlayerFrame.inCombat then
                if PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:IsShown() then
                    PlayerLevelText:Hide()
                end
            elseif PlayerFrame.onHateList then
                PlayerLevelText:Hide()
            else
                PlayerLevelText:Show()
            end
        end
    end

    local function PlayerFrame_UpdateRolesAssigned()
        local RoleIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.RoleIcon
        local Role =  UnitGroupRolesAssigned("player");

        if Role == "TANK" or Role == "HEALER" or Role == "DAMAGER" then
            local RoleAtlas
            if Role == "TANK" then RoleAtlas = "groupfinder-icon-role-large-tank" end
            if Role == "HEAL" then RoleAtlas = "groupfinder-icon-role-large-heal" end
            if Role == "DAMAGER" then RoleAtlas = "groupfinder-icon-role-large-dps" end
            RoleIcon:SetAtlas(RoleAtlas, true)
        end

        RoleIcon:SetSize(20, 20)
        RoleIcon:ClearAllPoints()
        RoleIcon:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 68, -15)
        RoleIcon:SetDrawLayer("OVERLAY")

        PlayerLevelText:SetShown(true)
    end

    PlayerFrame:HookScript("OnEvent", function(s, e)
        if e == "PLAYER_ENTERING_WORLD" then
            if db.texture ~= "default" then
                local Texture = PhoUI:GetTexture(db.texture)
                s.healthbar:SetStatusBarTexture(Texture)
            end
        end

        if not db.classbar then
            if PlayerFrame.classPowerBar then
                PlayerFrame.classPowerBar:Hide()
            end
            
            ComboPointDruidPlayerFrame:Hide()
            ComboPointPlayerFrame:Hide()
            MonkStaggerBar:Hide()
            EssencePlayerFrame:Hide()
            RuneFrame:Hide()
        end
    end)

    hooksecurefunc("PlayerFrame_ToPlayerArt", PlayerFrame_ToPlayerArt)
    hooksecurefunc("PlayerFrame_UpdateStatus", PlayerFrame_UpdateStatus)

    if db.frame_style ~= "blizzard" then
        hooksecurefunc("PlayerFrame_UpdateLevel", PlayerFrame_UpdateLevel)
        hooksecurefunc("PlayerFrame_UpdatePlayerNameTextAnchor", PlayerFrame_UpdatePlayerNameTextAnchor)
        hooksecurefunc("PlayerFrame_UpdateRolesAssigned", PlayerFrame_UpdateRolesAssigned)
    end
end