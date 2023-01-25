local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Unitframes.CompactUnitFrame")

function Module:OnEnable()
    local DB = PhoUI.db.profile.unitframes
    
    hooksecurefunc("CompactUnitFrame_UpdateAll", function(self)
        if self:IsForbidden() then return end
        if DB.raid_texture == "default" then return end

        local Texture = PhoUI:GetTexture(DB.raid_texture)
        local Name = self:GetName()

        if Name and Name:match("^Compact") then
            self.healthBar:SetStatusBarTexture(Texture)
            self.healthBar:GetStatusBarTexture():SetDrawLayer("BORDER")
            self.powerBar:SetStatusBarTexture(Texture)
            self.powerBar:GetStatusBarTexture():SetDrawLayer("BORDER")
            self.myHealPrediction:SetTexture(Texture)
            self.otherHealPrediction:SetTexture(Texture)
        end
    end)
end