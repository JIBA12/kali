--// KaLi Hub - STABLE SHAMAN GUI (NO SECTION BUGS)

-- Load library safely
local Library
local success, lib = pcall(function()
    return loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Rain-Design/Libraries/main/Shaman/Library.lua"
    ))()
end)

if not success or not lib then
    warn("Failed to load Shaman Library")
    return
end

Library = lib
local Flags = Library.Flags

-- Window
local Window = Library:Window({
    Text = "KaLi Hub"
})

-- Tabs
local MainTab = Window:Tab({ Text = "Main" })
local SettingsTab = Window:Tab({ Text = "Settings" })

-- Sections (THIS is the part that was breaking before)
local MainSection = MainTab:Section({
    Text = "Features"
})

local SettingsSection = SettingsTab:Section({
    Text = "Options"
})

-- ===== MAIN SECTION =====
MainSection:Button({
    Text = "Do Action",
    Callback = function()
        print("Action executed")
    end
})

MainSection:Toggle({
    Text = "Enable Feature",
    Default = false,
    Callback = function(v)
        print("Feature:", v)
    end
})

MainSection:Slider({
    Text = "Power Level",
    Minimum = 0,
    Maximum = 100,
    Default = 50,
    Flag = "Power",
    Callback = function(v)
        print("Power:", v)
    end
})

-- ===== SETTINGS SECTION =====
SettingsSection:Dropdown({
    Text = "Mode",
    List = {"Easy", "Medium", "Hard"},
    Flag = "Mode",
    Callback = function(v)
        print("Mode:", v)
    end
})

SettingsSection:Input({
    Text = "Player Name",
    Placeholder = "Enter name",
    Flag = "Name",
    Callback = function(v)
        print("Name:", v)
    end
})

SettingsSection:Label({
    Text = "Created by KaLi Hub",
    Color = Color3.fromRGB(120, 200, 255)
})

-- Notify
Library:Notify({
    Title = "KaLi Hub",
    Text = "GUI Loaded Successfully",
    Duration = 4
})

-- Select tab LAST
task.wait()
MainTab:Select()
