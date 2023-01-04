------- This file is part of PhoUI -------------------------------------------
------- Twitch   https://www.twitch.tv/phoyk ---------------------------------
------- Twitter  https://twitter.com/phoykwow --------------------------------
------- Github   https://github.com/mabu95 -----------------------------------
------- Discord  https://discord.gg/RxjhKWsN3V -------------------------------
local p, h, o, u, i = ...
local Module = PhoUI:NewModule("Core.Window")
local AceGUI = LibStub("AceGUI-3.0")

function Module:OnEnable()
    local Tree = {
        {
            value = "About",
            text = "About",
            children = {
                {
                    value = "test",
                    text = "testchild"
                }
            }
        },
        {
            value = "unitframes",
            text = "Unitframes"
        },
        {
            value = "actionbar",
            text = "Actionbar"
        },
        {
            value = "tooltip",
            text = "Tooltip",
            disabled = true
        },
        profiles = {
            value = "profiles",
            text = "Profiles"
        }
    }

    local Window = AceGUI:Create("Frame")
    Window:SetTitle("PhoUI " .. "v" .. GetAddOnMetadata("PhoUI", "Version"))
    Window:SetStatusText("AceGUI-3.0 Example Container Frame")
    Window:SetLayout("flow")
    Window:SetCallback("OnClose", function(Widget) AceGUI:Release(Widget) end)


    print(Window.BottomEdge)
    local TreeGroup = AceGUI:Create("TreeGroup")
    TreeGroup:SetFullHeight(true)
    TreeGroup:SetLayout("Flow")
    TreeGroup:SetTree(Tree)
    Window:AddChild(TreeGroup)

end