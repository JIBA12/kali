--// KaLi Hub v2 - Modern GUI Design
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Rain-Design/Libraries/main/Shaman/Library.lua"
))()

local Flags = Library.Flags

--// Window
local Window = Library:Window({
    Text = "KaLi Hub",
    Color = Color3.fromRGB(20, 20, 25),       -- Dark background
    Accent = Color3.fromRGB(0, 170, 255),     -- Highlight color
    Rounded = true,                            -- Rounded corners
    Draggable = true,                          -- Dragable
    Transparency = 0.15                        -- Slight transparency
})

--// Tabs with icons
local MainTab = Window:Tab({ Text = "Main", Icon = "rbxassetid://6034818375" })
local SettingsTab = Window:Tab({ Text = "Settings", Icon = "rbxassetid://6034818375" })
local AboutTab = Window:Tab({ Text = "About", Icon = "rbxassetid://6034818375" })

--// Sections with design
local MainSection = MainTab:Section({
    Text = "Features",
    Side = "Left",
    AccentColor = Color3.fromRGB(0, 200, 255)
})

local AdvancedSection = MainTab:Section({
    Text = "Advanced Features",
    Side = "Left",
    Collapsible = true,
    Collapsed = true,           -- Starts collapsed
    AccentColor = Color3.fromRGB(255, 100, 100)
})

local SettingsSection = SettingsTab:Section({
    Text = "Options",
    Side = "Left",
    AccentColor = Color3.fromRGB(0, 255, 150)
})

local AboutSection = AboutTab:Section({
    Text = "Info",
    Side = "Right",
    AccentColor = Color3.fromRGB(200, 200, 200)
})

--// Main Section Features
MainSection:Button({
    Text = "Do Action",
    Tooltip = "Executes main action",
    Color = Color3.fromRGB(0, 170, 255),
    HoverColor = Color3.fromRGB(0, 220, 255),
    Callback = function()
        print("Main action executed!")
    end
})

MainSection:Toggle({
    Text = "Enable Feature",
    Default = false,
    Color = Color3.fromRGB(0, 255, 180),
    HoverColor = Color3.fromRGB(0, 255, 220),
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
    Color = Color3.fromRGB(255, 165, 0),
    HoverColor = Color3.fromRGB(255, 200, 50),
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

--// Advanced Section Features
AdvancedSection:Toggle({
    Text = "Advanced Toggle",
    Default = false,
    Color = Color3.fromRGB(255, 100, 100),
    HoverColor = Color3.fromRGB(255, 150, 150),
    Callback = function(state)
        print("Advanced Toggle:", state)
    end
})

AdvancedSection:Button({
    Text = "Advanced Button",
    Color = Color3.fromRGB(255, 0, 150),
    HoverColor = Color3.fromRGB(255, 0, 220),
    Callback = function()
        print("Advanced Button pressed")
    end
})

--// Settings Section
SettingsSection:Toggle({
    Text = "Show Notifications",
    Default = true,
    Color = Color3.fromRGB(0, 200, 255),
    HoverColor = Color3.fromRGB(0, 220, 255),
    Callback = function(state)
        print("Notifications enabled:", state)
    end
})

SettingsSection:Dropdown({
    Text = "Mode",
    List = {"Easy", "Medium", "Hard"},
    Flag = "ModeSelect",
    Color = Color3.fromRGB(0, 255, 180),
    Callback = function(selection)
        print("Mode selected:", selection)
    end
})

SettingsSection:Input({
    Text = "Set Name",
    Placeholder = "Enter name here",
    Flag = "PlayerName",
    Color = Color3.fromRGB(255, 200, 0),
    Callback = function(text)
        print("Name set to:", text)
    end
})

--// About Section
AboutSection:Label({
    Text = "Created by YourName",
    Color = Color3.fromRGB(0, 200, 255),
    Tooltip = "Credits"
})

AboutSection:Label({
    Text = "Version 2.0",
    Color = Color3.fromRGB(200, 200, 200)
})

--// Keybind to toggle GUI (with smooth animation)
Window:Keybind({
    Default = Enum.KeyCode.RightShift,
    Callback = function()
        Window:Toggle() -- shows/hides GUI
    end,
    Text = "Toggle GUI",
    Color = Color3.fromRGB(0, 200, 255)
})

--// Config save/load
local HttpService = game:GetService("HttpService")
local ConfigFlag = "KaLiHubConfig"

local function SaveConfig()
    local data = HttpService:JSONEncode(Flags)
    writefile(ConfigFlag..".json", data)
    print("Config saved")
end

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

LoadConfig()

-- Save button
SettingsSection:Button({
    Text = "Save Config",
    Color = Color3.fromRGB(0, 255, 100),
    HoverColor = Color3.fromRGB(0, 255, 150),
    Callback = SaveConfig
})

-- Default tab
MainTab:Select()
