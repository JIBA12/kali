--// KaLi Hub - Rayfield UI (FIXED & EXECUTING)

-- Load Rayfield Library (CORRECT URL)
local Rayfield
local success, err = pcall(function()
    Rayfield = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"
    ))()
end)

if not success or not Rayfield then
    warn("Rayfield failed to load:", err)
    return
end

-- Create Window
local Window = Rayfield:CreateWindow({
    Name = "KaLi Hub",
    LoadingTitle = "KaLi Hub",
    LoadingSubtitle = "Rayfield UI",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "KaLiHub",
        FileName = "Config"
    },
    KeySystem = false
})

-- Tabs
local MainTab = Window:CreateTab("Main", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- ===== MAIN TAB =====
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

-- ===== SETTINGS TAB =====
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
