-- Make sure HTTP requests are enabled in Roblox Studio

-- Load Hattori V4 UI library
local success, Hattori = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/Ui-Librarys/main/Hattori/V4/source.lua"))()
end)

if not success then
    warn("Failed to load Hattori V4 UI Library: " .. tostring(Hattori))
    return
end

-- Create the main window
local Window = Hattori:Window({
    Name = "KaLi Hub",
    Size = UDim2.new(0, 500, 0, 400),
    Theme = "Dark"
})

-- Create tabs
local MainTab = Window:Tab("Main")
local SettingsTab = Window:Tab("Settings")

-- Main Tab Features
MainTab:Button({
    Name = "Do Action",
    Callback = function()
        print("Main action executed!")
    end
})

MainTab:Toggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("Feature enabled:", state)
    end
})

MainTab:Slider({
    Name = "Power Level",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Power Level:", value)
    end
})

MainTab:Colorpicker({
    Name = "Select Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        print("Color chosen:", color)
    end
})

-- Settings Tab Features
SettingsTab:Toggle({
    Name = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications enabled:", state)
    end
})

SettingsTab:Dropdown({
    Name = "Mode",
    Options = {"Easy", "Medium", "Hard"},
    Callback = function(selection)
        print("Mode selected:", selection)
    end
})

SettingsTab:Input({
    Name = "Set Name",
    Placeholder = "Enter name here",
    Callback = function(text)
        print("Name set to:", text)
    end
})

-- Label Example
SettingsTab:Label({
    Text = "Created by YourName",
    Color = Color3.fromRGB(150, 200, 255)
})

-- Optional: select default tab
MainTab:Select()
