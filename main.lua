--// KaLi Hub - Orion UI
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({
    Name = "KaLi Hub",
    HidePremium = true,          -- hide premium features
    SaveConfig = true,           -- allows saving configs
    ConfigFolder = "KaLiHub"     -- folder to save config
})

--// Tabs
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://6034818375", -- icon asset
    PremiumOnly = false
})

local SettingsTab = Window:MakeTab({
    Name = "Settings",
    Icon = "rbxassetid://6034818375",
    PremiumOnly = false
})

local AboutTab = Window:MakeTab({
    Name = "About",
    Icon = "rbxassetid://6034818375",
    PremiumOnly = false
})

--// Main Tab Features
MainTab:AddButton({
    Name = "Do Action",
    Callback = function()
        print("Action executed!")
    end
})

MainTab:AddToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Feature enabled:", state)
    end
})

MainTab:AddSlider({
    Name = "Power Level",
    Min = 0,
    Max = 100,
    Default = 50,
    Color = Color3.fromRGB(0, 170, 255),
    Increment = 1,
    Callback = function(value)
        print("Power Level:", value)
    end
})

MainTab:AddDropdown({
    Name = "Target Part",
    Default = "Head",
    Options = {"Head", "Torso", "Random"},
    Callback = function(option)
        print("Target part:", option)
    end
})

MainTab:AddBind({
    Name = "Action Key",
    Default = Enum.KeyCode.E,
    Hold = false,
    Callback = function()
        print("Keybind pressed!")
    end
})

--// Settings Tab Features
SettingsTab:AddToggle({
    Name = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications:", state)
    end
})

SettingsTab:AddDropdown({
    Name = "Mode",
    Default = "Easy",
    Options = {"Easy", "Medium", "Hard"},
    Callback = function(selection)
        print("Mode selected:", selection)
    end
})

SettingsTab:AddButton({
    Name = "Save Config",
    Callback = function()
        OrionLib:SaveConfig()
        print("Config saved!")
    end
})

SettingsTab:AddButton({
    Name = "Load Config",
    Callback = function()
        OrionLib:LoadConfig()
        print("Config loaded!")
    end
})

--// About Tab
AboutTab:AddLabel("Created by YourName")
AboutTab:AddLabel("Version 1.0")
AboutTab:AddLabel("Orion UI Library")

--// Show notification
OrionLib:MakeNotification({
    Name = "KaLi Hub",
    Content = "GUI Loaded Successfully!",
    Image = "rbxassetid://6034818375",
    Time = 5
})
