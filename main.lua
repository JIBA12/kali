--// KaLi Hub - Rayfield UI (STABLE)

-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/shlexware/Rayfield/main/source"
))()

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "KaLi Hub",
    LoadingTitle = "KaLi Hub",
    LoadingSubtitle = "by YourName",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "KaLiHub",
        FileName = "Config"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- ======================
-- MAIN TAB
-- ======================
MainTab:CreateButton({
    Name = "Do Action",
    Callback = function()
        print("Action executed")
    end
})

MainTab:CreateToggle({
    Name = "Enable Feature",
    CurrentValue = false,
    Callback = function(Value)
        print("Feature:", Value)
    end
})

MainTab:CreateSlider({
    Name = "Power Level",
    Range = {0, 100},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        print("Power:", Value)
    end
})

-- ======================
-- SETTINGS TAB
-- ======================
SettingsTab:CreateDropdown({
    Name = "Mode",
    Options = {"Easy", "Medium", "Hard"},
    CurrentOption = "Easy",
    Callback = function(Value)
        print("Mode:", Value)
    end
})

SettingsTab:CreateInput({
    Name = "Player Name",
    PlaceholderText = "Enter name",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        print("Name:", Text)
    end
})

SettingsTab:CreateLabel("KaLi Hub © 2026")

-- Notification
Rayfield:Notify({
    Title = "KaLi Hub",
    Content = "GUI Loaded Successfully",
    Duration = 4,
    Image = 4483362458
})
