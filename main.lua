--// KaLi Hub (FIXED - SAME PROJECT)

local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Rain-Design/Libraries/main/Shaman/Library.lua"
))()

--// Window
local Window = Library:Window({
    Text = "KaLi Hub"
})

--// Tabs
local MainTab = Window:Tab({ Text = "Main" })
local SettingsTab = Window:Tab({ Text = "Settings" })

--// MAIN TAB
MainTab:Button({
    Text = "Do Action",
    Callback = function()
        print("Main action executed!")
    end
})

MainTab:Toggle({
    Text = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Feature enabled:", state)
    end
})

MainTab:Slider({
    Text = "Power Level",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Power Level:", value)
    end
})

--// SETTINGS TAB
SettingsTab:Toggle({
    Text = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications enabled:", state)
    end
})

SettingsTab:Dropdown({
    Text = "Mode",
    List = {"Easy", "Medium", "Hard"},
    Default = "Easy",
    Callback = function(choice)
        print("Mode selected:", choice)
    end
})

SettingsTab:Input({
    Text = "Set Name",
    Placeholder = "Enter name here",
    Callback = function(text)
        print("Name set to:", text)
    end
})

SettingsTab:Label({
    Text = "Created by KaLi Hub"
})

--// REQUIRED (THIS IS WHAT YOU WERE MISSING)
Library:Init()
