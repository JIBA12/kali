--// Enhanced GUI for Project
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Rain-Design/Libraries/main/Shaman/Library.lua"
))()

local Flags = Library.Flags

--// Window
local Window = Library:Window({
    Text = "KaLi hub"
})

--// Tabs
local MainTab = Window:Tab({ Text = "Main" })
local SettingsTab = Window:Tab({ Text = "Settings" })
local AboutTab = Window:Tab({ Text = "About" })

--// Sections
local MainSection = MainTab:Section({ Text = "Features" })
local SettingsSection = SettingsTab:Section({ Text = "Options" })
local AboutSection = AboutTab:Section({ Text = "Info", Side = "Right" })

--// Collapsible Section Example
local Collapsible = MainTab:Section({
    Text = "Advanced Features",
    Collapsible = true
})

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

--// Collapsible Section Features
Collapsible:Toggle({
    Text = "Advanced Toggle",
    Default = false,
    Callback = function(state)
        print("Advanced Toggle:", state)
    end
})

Collapsible:Button({
    Text = "Advanced Button",
    Callback = function()
        print("Advanced Button pressed")
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

--// About Section
AboutSection:Label({
    Text = "Created by YourName",
    Color = Color3.fromRGB(150, 200, 255),
    Tooltip = "Credits"
})

AboutSection:Label({
    Text = "Version 1.0",
    Color = Color3.fromRGB(200, 200, 200)
})

--// Keybind to toggle GUI
Window:Keybind({
    Default = Enum.KeyCode.RightShift,
    Callback = function()
        Window:Toggle() -- shows/hides GUI
    end,
    Text = "Toggle GUI"
})

--// Config save/load
local HttpService = game:GetService("HttpService")
local ConfigFlag = "MyProjectGUIConfig"

-- Save config
local function SaveConfig()
    local data = HttpService:JSONEncode(Flags)
    writefile(ConfigFlag..".json", data)
    print("Config saved")
end

-- Load config
local function LoadConfig()
    if isfile(ConfigFlag..".json") then
        local data = readfile(ConfigFlag..".json")
        local decoded = HttpService:JSONDecode(data)
        for k,v in pairs(decoded) do
            if Flags[k] ~= nil then
                Flags[k] = v
            end
        end
        print("Config loaded")
    end
end

-- Load config on start
LoadConfig()

-- Example save button
SettingsSection:Button({
    Text = "Save Config",
    Callback = SaveConfig
})

-- Default tab selected
MainTab:Select()
