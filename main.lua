-- Make sure HTTP requests are enabled in Roblox Studio

-- Load Hattori V4 safely
local success, Hattori = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/Ui-Librarys/main/Hattori/V4/source.lua"))()
end)

if not success then
    warn("Failed to load Hattori V4 UI Library: " .. tostring(Hattori))
    return
end

-- Create main window
local Window = Hattori:Window({
    Name = "KaLi Hub",
    Size = UDim2.new(0, 500, 0, 400),
    Theme = "Dark"
})

-- ===============================
-- Main Tab
-- ===============================
local MainTab = Window:Tab("Main")

-- Section Header: Features
MainTab:Label({
    Text = "Features",
    Color = Color3.fromRGB(200, 200, 255)
})

-- Button
MainTab:Button({
    Name = "Do Action",
    Callback = function()
        print("Main action executed!")
    end
})

-- Toggle
MainTab:Toggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Feature enabled:", state)
    end
})

-- Slider
MainTab:Slider({
    Name = "Power Level",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Power Level:", value)
    end
})

-- Color Picker
MainTab:Colorpicker({
    Name = "Select Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        print("Color chosen:", color)
    end
})

-- ===============================
-- Settings Tab
-- ===============================
local SettingsTab = Window:Tab("Settings")

-- Section Header: Options
SettingsTab:Label({
    Text = "Options",
    Color = Color3.fromRGB(200, 200, 255)
})

-- Toggle
SettingsTab:Toggle({
    Name = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications enabled:", state)
    end
})

-- Dropdown
SettingsTab:Dropdown({
    Name = "Mode",
    Options = {"Easy", "Medium", "Hard"},
    Callback = function(selection)
        print("Mode selected:", selection)
    end
})

-- Input
SettingsTab:Input({
    Name = "Set Name",
    Placeholder = "Enter name here",
    Callback = function(text)
        print("Name set to:", text)
    end
})

-- Label / Credits
SettingsTab:Label({
    Text = "Created by YourName",
    Color = Color3.fromRGB(150, 200, 255)
})

-- ===============================
-- Default tab selection
-- ===============================
MainTab:Select()
