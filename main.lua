--// KaLi Hub - Mercury UI
local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

-- CREATE WINDOW
local Window = Mercury:Create{
    Name = "KaLi Hub",
    Size = UDim2.fromOffset(500, 400),
    Theme = "Dark",
    IntroText = "KaLi Hub Loaded"
}

-- CREATE TABS
local MainTab = Window:Tab{ Name = "Main" }
local SettingsTab = Window:Tab{ Name = "Settings" }

-- MAIN TAB SECTION
local MainSection = MainTab:Section{ Name = "Features" }

-- Add Buttons, Toggles, Sliders
MainSection:Button{
    Name = "Do Action",
    Callback = function()
        print("Main action executed!")
    end
}

MainSection:Toggle{
    Name = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Feature enabled:", state)
    end
}

MainSection:Slider{
    Name = "Power Level",
    Default = 50,
    Min = 0,
    Max = 100,
    Callback = function(value)
        print("Power Level:", value)
    end
}

MainSection:Dropdown{
    Name = "Target Part",
    Default = "Head",
    Options = {"Head", "Torso", "Random"},
    Callback = function(option)
        print("Target part:", option)
    end
}

-- SETTINGS TAB SECTION
local SettingsSection = SettingsTab:Section{ Name = "Options" }

SettingsSection:Toggle{
    Name = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications enabled:", state)
    end
}

SettingsSection:Dropdown{
    Name = "Mode",
    Default = "Easy",
    Options = {"Easy", "Medium", "Hard"},
    Callback = function(selection)
        print("Mode selected:", selection)
    end
}

SettingsSection:Input{
    Name = "Set Name",
    Placeholder = "Enter name here",
    Callback = function(text)
        print("Name set to:", text)
    end
}

SettingsSection:Label{
    Text = "Created by KaLi Hub"
}

-- Mercury automatically handles drag, themes, and smooth animation
