local P, H, O, Y, K = ...
PhoUI.Configs.Chat= {
    name = "Chat",
    type = "group",
    order = 6,
    args = {
        header = {
            name = "Chat",
            type = "header",
            order = 1
        },
        style = {
            name = "Chat Style",
            desc = "Set the Chat Style",
            type = "select",
            width = "full",
            order = 2,
            values = {
                ["custom"] = "Custom",
                ["Blizzard"] = "Blizzard"
            }
        },
        enable_history = {
            name = "Save Chat history",
            desc = "Save the History of the Chat (100 Entries)",
            type = "toggle",
            width = 1.3,
            order = 3
        },
        hide_buttons = {
            name = "Hide Chat Buttons",
            desc = "Hide Chat Buttons",
            type = "toggle",
            width = 1.3,
            order = 4
        }
    }
}
