------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Editmode = PhoUI:NewModule("Core.Editmode")
local LibEditMode = LibStub("LibEditMode")

function Editmode:OnEnable()
    local db = PhoUI.db.profile
    local MicroButtonAndBagsBarDefaultPos = {
        point = "BOTTOMRIGHT",
        x = 0,
        y = 0,
    }
    
    -- LFG Eye

    -- Micromenu & Bagbar
    MicroButtonAndBagsBar:ClearAllPoints()
    MicroButtonAndBagsBar:SetPoint(db.e_menu.point, db.e_menu.x, db.e_menu.y)
    
    local function MicroButtonAndBagsBarPosition(Frame, LayoutName, Point, X, Y)
        db.e_menu.point = Point
        db.e_menu.x = X
        db.e_menu.y = Y
    end

    LibEditMode:AddFrame(MicroButtonAndBagsBar, MicroButtonAndBagsBarPosition, MicroButtonAndBagsBarDefaultPos)
    LibEditMode:AddFrameSettings(MicroButtonAndBagsBar, {
        name = 'Button scale',
        kind = LibEditMode.SettingType.Checkbox,
        default = 1,
        get = function(layoutName)
            return true
            --return MyButtonDB[layoutName].scale
        end,
        set = function(layoutName, value)
            --MyButtonDB[layoutName].scale = value
            --button:SetScale(value)
        end,
    })


    LibEditMode:RegisterCallback('enter', function()
        MainMenuBar.Selection:Hide()
        MultiBarBottomLeft.Selection:Hide()
        MultiBarBottomRight.Selection:Hide()
    end)
    -- Durability Doll


    LibEditMode:RegisterCallback('layout', function(layoutName)
        MainMenuBar.Selection:Hide()
        MultiBarBottomLeft.Selection:Hide()
        MultiBarBottomRight.Selection:Hide()
    end)
end