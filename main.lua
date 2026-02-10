--// New GUI for Project
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Rain-Design/Libraries/main/Shaman/Library.lua"
))()

local Flags = Library.Flags

--// Window
local Window = Library:Window({
    Text = "MyProject GUI"
})

--// Tabs
local MainTab = Window:Tab({ Text = "Main" })
local SettingsTab = Window:Tab({ Text = "Settings" })

--// Sections
local MainSection = MainTab:Section({ Text = "Features" })
local SettingsSection = SettingsTab:Section({ Text = "Options" })

--// Main Section Features
MainSection:Button({
    Text = "Do Action",
    Tooltip = "Executes main action",
    Callback = function()
        print("Main action executed!")
    end
})

MainSection:Toggle({
    Text = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Feature enabled:", state)
    end
})

MainSection:Slider({
    Text = "Power Level",
    Minimum = 0,
    Maximum = 100,
    Default = 50,
    Flag = "PowerLevel",
    Callback = function(value)
        print("Power Level:", value)
    end
})

MainSection:ColorPicker({
    Text = "Select Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        print("Color chosen:", color)
    end
})

--// Settings Section
SettingsSection:Toggle({
    Text = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications enabled:", state)
    end
})

SettingsSection:Dropdown({
    Text = "Mode",
    List = {"Easy", "Medium", "Hard"},
    Flag = "ModeSelect",
    Callback = function(selection)
        print("Mode selected:", selection)
    end
})

SettingsSection:Input({
    Text = "Set Name",
    Placeholder = "Enter name here",
    Flag = "PlayerName",
    Callback = function(text)
        print("Name set to:", text)
    end
})

--// Label Example
local infoLabel = SettingsSection:Label({
    Text = "Created by YourName",
    Color = Color3.fromRGB(150, 200, 255),
    Tooltip = "Credits"
})

--// Default tab selected
MainTab:Select()
