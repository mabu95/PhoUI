------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Editmode")
local LibEditMode = LibStub("LibEditMode")

-- @TODO: Fix when invisible

function Module:OnEnable()
    local db = PhoUI.db.profile.editmode
    local CustomActionbar = PhoUI.db.profile.actionbar.enable
    local DurabilityFrame = DurabilityFrame
    local VehicleSeatIndicator = VehicleSeatIndicator
    local StatusTrackingBarManager = StatusTrackingBarManager

    local DefaultPos = {
        [VehicleSeatIndicator] = {
            point = db.vehicle.point,
            x = db.vehicle.x,
            y = db.vehicle.y
        },
        [DurabilityFrame] = {
            point = db.durability.point,
            x = db.durability.x,
            y = db.durability.y
        },
        [StatusTrackingBarManager] = {
            point = "BOTTOM",
            x = 0,
            y = 0
        }
    }

    VehicleSeatIndicator:SetParent(UIParent)
    VehicleSeatIndicator:ClearAllPoints()
    VehicleSeatIndicator:SetPoint(db.vehicle.point, db.vehicle.x, db.vehicle.y)

    DurabilityFrame:SetParent(UIParent)
    DurabilityFrame:ClearAllPoints()
    DurabilityFrame:SetPoint(db.durability.point, db.durability.x, db.durability.y)

    if not CustomActionbar then
        StatusTrackingBarManager:ClearAllPoints()
        StatusTrackingBarManager:SetPoint(db.statustracking.point, db.statustracking.x, db.statustracking.y)
    end

    local function VehicleSeatIndicatorPos(Frame, LayoutName, Point, X, Y)
        db.vehicle.point = Point
        db.vehicle.x = X
        db.vehicle.y = Y
    end

    local function DurabilityFramePos(Frame, LayoutName, Point, X, Y)
        db.durability.point = Point
        db.durability.x = X
        db.durability.y = Y
    end

    local function StatusTrackingBarManagerPos(Frame, LayoutName, Point, X, Y)
        db.statustracking.point = Point
        db.statustracking.x = X
        db.statustracking.y = Y
    end

    hooksecurefunc(UIParentRightManagedFrameContainer, "UpdateFrame", function()
        VehicleSeatIndicator:SetParent(UIParent)
        VehicleSeatIndicator:ClearAllPoints()
        VehicleSeatIndicator:SetPoint(db.vehicle.point, db.vehicle.x, db.vehicle.y)

        DurabilityFrame:SetParent(UIParent)
        DurabilityFrame:ClearAllPoints()
        DurabilityFrame:SetPoint(db.durability.point, db.durability.x, db.durability.y)
    end)

    LibEditMode:AddFrame(VehicleSeatIndicator, VehicleSeatIndicatorPos, DefaultPos.VehicleSeatIndicator)
    LibEditMode:AddFrame(DurabilityFrame, DurabilityFramePos, DefaultPos.DurabilityFrame)
    
    if not CustomActionbar then
        LibEditMode:AddFrame(StatusTrackingBarManager, StatusTrackingBarManagerPos, DefaultPos.StatusTrackingBarManager)
    end
    --
    --LibEditMode:RegisterCallback("layout", function(layoutName)
    --    --print('callback', layoutName)
    --end)



    --[[
    LibEditMode:AddFrameSettingsButton(VehicleSeatIndicator, {
        text = "Save",
        click = function()

        end
    })
    ]]

    --[[LibEditMode:AddFrameSettings(VehicleSeatIndicator, {
        {
            name = 'VehicleSeatIndicator Scale',
            kind = Enum.EditModeSettingDisplayType.Slider,
            default = 1,
            get = function(layoutName)
                print(db.vehicle.scale)
                return db.vehicle.scale
            end,
            set = function(layoutName, value)
                db.vehicle.scale = IsVehicleAimPowerAdjustable
            end,
        }
    })]]
end