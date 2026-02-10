--// KaLi Hub - Shaman GUI (Fade-In + Theme, STABLE)

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
local TweenService = game:GetService("TweenService")

-- =====================
-- THEME (B)
-- =====================
Library:Theme({
    Background = Color3.fromRGB(20, 20, 25),
    Secondary = Color3.fromRGB(30, 30, 38),
    Accent = Color3.fromRGB(80, 160, 255),
    Outline = Color3.fromRGB(40, 40, 50),
    Text = Color3.fromRGB(235, 235, 235)
})

-- =====================
-- WINDOW
-- =====================
local Window = Library:Window({
    Text = "KaLi Hub"
})

-- =====================
-- TABS
-- =====================
local MainTab = Window:Tab({ Text = "Main" })
local SettingsTab = Window:Tab({ Text = "Settings" })

-- =====================
-- SECTIONS
-- =====================
local MainSection = MainTab:Section({ Text = "Features" })
local SettingsSection = SettingsTab:Section({ Text = "Options" })

-- =====================
-- MAIN FEATURES
-- =====================
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

-- =====================
-- SETTINGS
-- =====================
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
    Text = "KaLi Hub © 2026",
    Color = Color3.fromRGB(120, 180, 255)
})

-- =====================
-- FADE-IN ANIMATION (A)
-- =====================
task.wait() -- let UI fully render first

local gui = Library.UI
if gui then
    gui.Enabled = true

    for _, obj in ipairs(gui:GetDescendants()) do
        if obj:IsA("Frame") then
            obj.BackgroundTransparency = 1
            TweenService:Create(
                obj,
                TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0}
            ):Play()
        elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
            obj.TextTransparency = 1
            TweenService:Create(
                obj,
                TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {TextTransparency = 0}
            ):Play()
        end
    end
end

-- =====================
-- NOTIFY
-- =====================
Library:Notify({
    Title = "KaLi Hub",
    Text = "Loaded Successfully",
    Duration = 4
})

-- Select default tab LAST
MainTab:Select()
