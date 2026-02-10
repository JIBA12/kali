--// KaLi Hub - Mercury UI FULL CONVERT

-- Wait for PlayerGui
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
repeat wait() until Player:FindFirstChild("PlayerGui")

-- Load Mercury Library
local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

-- Create Window
local Window = Mercury:Create{
    Name = "KaLi Hub",
    Size = UDim2.fromOffset(500, 450),
    Theme = "Dark",
    IntroText = "KaLi Hub Loaded"
}

-- Create Tabs
local MainTab = Window:Tab{ Name = "Main" }
local SettingsTab = Window:Tab{ Name = "Settings" }
local AboutTab = Window:Tab{ Name = "About" }

--===========================--
--// MAIN TAB SECTION
--===========================--
local MainSection = MainTab:Section{ Name = "Main Features" }

-- Button
MainSection:Button{
    Name = "Do Action",
    Callback = function()
        print("Main action executed!")
    end
}

-- Toggle
MainSection:Toggle{
    Name = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Feature enabled:", state)
    end
}

-- Slider
MainSection:Slider{
    Name = "Power Level",
    Default = 50,
    Min = 0,
    Max = 100,
    Callback = function(value)
        print("Power Level:", value)
    end
}

-- Dropdown
MainSection:Dropdown{
    Name = "Target Part",
    Default = "Head",
    Options = {"Head", "Torso", "Random"},
    Callback = function(option)
        print("Target part:", option)
    end
}

-- Input Box
MainSection:Input{
    Name = "Walkspeed",
    Placeholder = "Enter walkspeed",
    Callback = function(text)
        print("Walkspeed set to:", text)
    end
}

--===========================--
--// SETTINGS TAB SECTION
--===========================--
local SettingsSection = SettingsTab:Section{ Name = "Settings Options" }

-- Show Notifications Toggle
SettingsSection:Toggle{
    Name = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications enabled:", state)
    end
}

-- Mode Dropdown
SettingsSection:Dropdown{
    Name = "Mode",
    Default = "Easy",
    Options = {"Easy", "Medium", "Hard"},
    Callback = function(selection)
        print("Mode selected:", selection)
    end
}

-- Name Input
SettingsSection:Input{
    Name = "Set Name",
    Placeholder = "Enter your name",
    Callback = function(text)
        print("Name set to:", text)
    end
}

--===========================--
--// ABOUT TAB SECTION
--===========================--
local AboutSection = AboutTab:Section{ Name = "Information" }

AboutSection:Label{
    Text = "KaLi Hub",
    Color = Color3.fromRGB(255, 255, 255)
}

AboutSection:Label{
    Text = "Version: 1.0",
    Color = Color3.fromRGB(180, 180, 180)
}

AboutSection:Label{
    Text = "Created by YourName",
    Color = Color3.fromRGB(150, 200, 255)
}

-- Mercury automatically handles drag and theme
