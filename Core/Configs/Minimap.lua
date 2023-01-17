local P, H, O, U, I = ...
local Module = PhoUI:NewModule("Core.Configs.Minimap")

function Module:OnEnable()
    self.Config = {
        name = "Minimap",
        type = "group",
        order = 5,
        args = {
            header = {
                name = "Minimap Options",
                type = "header",
                disabled = true,
                order = 1
            },
            enable = {
                name = "Enable Custom Minimap",
                desc = "Enable PhoUI Minimap",
                type = "toggle",
                width = 1.3,
                order = 2
            },
            hide_icons = {
                name = "Hide Minimap Icons",
                desc = "Hide the Minimap Icons",
                type = "toggle",
                width = 1.3,
                order = 3
            },
            shape = {
                name = "Shape",
                desc = "Set the Shape of the Minimap",
                type = "select",
                width = 1.3,
                values = {
                    ["round"] = "Round",
                    ["square"] = "Square"
                },
                order = 4
            },
            header_style = {
                name = "Header Style",
                desc = "Set the Style of the Minimap Header",
                type = "select",
                width = 1.3,
                values = {
                    ["default"] = "Default",
                    ["inside"] = "Inside"
                },
                order = 5
            }
        }
    }
end