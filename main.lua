-- Wait for the game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Load Hattori V4 UI library
local Hattori = loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/Ui-Librarys/main/Hattori/V4/source.lua"))()

-- Create the main window
local Window = Hattori:Window({
    Name = "KaLi Hub",
    Size = UDim2.new(0, 500, 0, 400),
    Theme = "Dark"
})

--===========================--
-- TABS
--===========================--
local MainTab = Window:Tab({Name = "Main"})
local SettingsTab = Window:Tab({Name = "Settings"})
local AboutTab = Window:Tab({Name = "About"})

--===========================--
-- MAIN TAB
--===========================--
local MainSection = MainTab:Section({Name = "Features"})

MainSection:Button({Name = "Do Action", Callback = function()
    print("Main action executed!")
end})

MainSection:Toggle({Name = "Enable Feature", Default = false, Callback = function(state)
    print("Feature enabled:", state)
end})

MainSection:Slider({
    Name = "Power Level",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Power Level:", value)
    end
})

MainSection:Dropdown({
    Name = "Target Part",
    Options = {"Head", "Torso", "Random"},
    Default = "Head",
    Callback = function(option)
        print("Target part:", option)
    end
})

MainSection:Input({
    Name = "Walkspeed",
    Placeholder = "Enter walkspeed",
    Callback = function(text)
        print("Walkspeed set to:", text)
    end
})

--===========================--
-- SETTINGS TAB
--===========================--
local SettingsSection = SettingsTab:Section({Name = "Options"})

SettingsSection:Toggle({Name = "Show Notifications", Default = true, Callback = function(state)
    print("Notifications enabled:", state)
end})

SettingsSection:Dropdown({
    Name = "Mode",
    Options = {"Easy", "Medium", "Hard"},
    Default = "Easy",
    Callback = function(option)
        print("Mode selected:", option)
    end
})

SettingsSection:Input({
    Name = "Set Name",
    Placeholder = "Enter your name",
    Callback = function(text)
        print("Name set to:", text)
    end
})

-- Theme switcher
SettingsSection:Dropdown({
    Name = "Theme",
    Options = {"Dark","Light"},
    Default = "Dark",
    Callback = function(option)
        Window:ChangeTheme(option)
        print("Theme changed to:", option)
    end
})

--===========================--
-- ABOUT TAB
--===========================--
local AboutSection = AboutTab:Section({Name = "Info"})

AboutSection:Label({Text = "KaLi Hub", Color = Color3.fromRGB(255,255,255)})
AboutSection:Label({Text = "Version: 1.0", Color = Color3.fromRGB(180,180,180)})
AboutSection:Label({Text = "Created by YourName", Color = Color3.fromRGB(150,200,255)})

AboutSection:Button({Name = "Show Credits", Callback = function()
    print("KaLi Hub created by YourName")
end})
