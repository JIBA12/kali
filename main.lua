-- KaLi Hub using KaLiUI
-- Make sure KaLiUI.lua is in the same location as this script

local KaLiUI = require(script:WaitForChild("KaLiUI"))

-- Create main window
local Window = KaLiUI:CreateWindow("KaLi Hub")

--===========================--
-- TABS
--===========================--
local MainTab = Window:Tab("Main")
local SettingsTab = Window:Tab("Settings")
local AboutTab = Window:Tab("About")

--===========================--
-- MAIN TAB
--===========================--
local MainSection = MainTab:Section("Features")

MainSection:Button("Do Action", function()
    print("Main action executed!")
end)

MainSection:Toggle("Enable Feature", false, function(state)
    print("Feature enabled:", state)
end)

MainSection:Slider("Power Level", 50, function(value)
    print("Power Level:", value)
end)

MainSection:Dropdown("Target Part", {"Head", "Torso", "Random"}, function(option)
    print("Target part:", option)
end)

MainSection:Input("Walkspeed", "Enter walkspeed", function(text)
    print("Walkspeed set to:", text)
end)

--===========================--
-- SETTINGS TAB
--===========================--
local SettingsSection = SettingsTab:Section("Options")

SettingsSection:Toggle("Show Notifications", true, function(state)
    print("Notifications enabled:", state)
end)

SettingsSection:Dropdown("Mode", {"Easy", "Medium", "Hard"}, function(selection)
    print("Mode selected:", selection)
end)

SettingsSection:Input("Set Name", "Enter your name", function(text)
    print("Name set to:", text)
end)

-- Theme switcher
SettingsSection:Dropdown("Theme", {"Dark","Light"}, function(option)
    if option == "Dark" then
        Window.Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    else
        Window.Frame.BackgroundColor3 = Color3.fromRGB(220,220,220)
    end
    print("Theme changed to:", option)
end)

--===========================--
-- ABOUT TAB
--===========================--
local AboutSection = AboutTab:Section("Info")

AboutSection:Label("KaLi Hub", Color3.fromRGB(255,255,255))
AboutSection:Label("Version: 1.0", Color3.fromRGB(180,180,180))
AboutSection:Label("Created by YourName", Color3.fromRGB(150,200,255))

-- Optional: credits button
AboutSection:Button("Show Credits", function()
    print("KaLi Hub created by YourName")
end)
