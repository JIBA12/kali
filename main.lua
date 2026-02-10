--// KaLi Hub - Mercury UI FULL FIX

-- Wait for PlayerGui
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
repeat wait() until Player:FindFirstChild("PlayerGui")

-- Load Mercury Library
local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

-- Create Window
local Window = Mercury:Create{
    Name = "KaLi Hub",
    Size = UDim2.fromOffset(500, 450),
    Theme = "Dark",
    IntroText = "KaLi Hub Loaded"
}

--===========================--
-- TABS
--===========================--
local MainTab = Window:Tab{ Name = "Main" }
local SettingsTab = Window:Tab{ Name = "Settings" }
local AboutTab = Window:Tab{ Name = "About" }

--===========================--
-- MAIN TAB
--===========================--
local MainSection = MainTab:Section{ Name = "Main Features" }

MainSection:Button{
    Name = "Do Action",
    Callback = function() print("Main action executed!") end
}

MainSection:Toggle{
    Name = "Enable Feature",
    Default = false,
    Callback = function(state) print("Feature enabled:", state) end
}

MainSection:Slider{
    Name = "Power Level",
    Default = 50,
    Min = 0,
    Max = 100,
    Callback = function(value) print("Power Level:", value) end
}

MainSection:Dropdown{
    Name = "Target Part",
    Default = "Head",
    Options = {"Head", "Torso", "Random"},
    Callback = function(option) print("Target part:", option) end
}

MainSection:Input{
    Name = "Walkspeed",
    Placeholder = "Enter walkspeed",
    Callback = function(text) print("Walkspeed set to:", text) end
}

--===========================--
-- SETTINGS TAB
--===========================--
local SettingsSection = SettingsTab:Section{ Name = "Settings Options" }

SettingsSection:Toggle{
    Name = "Show Notifications",
    Default = true,
    Callback = function(state) print("Notifications enabled:", state) end
}

SettingsSection:Dropdown{
    Name = "Mode",
    Default = "Easy",
    Options = {"Easy", "Medium", "Hard"},
    Callback = function(selection) print("Mode selected:", selection) end
}

SettingsSection:Input{
    Name = "Set Name",
    Placeholder = "Enter your name",
    Callback = function(text) print("Name set to:", text) end
}

--===========================--
-- ABOUT TAB
--===========================--
local AboutSection = AboutTab:Section{ Name = "Information" }

AboutSection:Label{ Text = "KaLi Hub", Color = Color3.fromRGB(255,255,255) }
AboutSection:Label{ Text = "Version: 1.0", Color = Color3.fromRGB(180,180,180) }
AboutSection:Label{ Text = "Created by YourName", Color = Color3.fromRGB(150,200,255) }

--===========================--
-- THEME SWITCHER (Dark / Light)
--===========================--
SettingsSection:Dropdown{
    Name = "Theme",
    Default = "Dark",
    Options = {"Dark", "Light"},
    Callback = function(option)
        if option == "Dark" then
            Mercury:SetTheme("Dark")
        else
            Mercury:SetTheme("Light")
        end
        print("Theme changed to:", option)
    end
}

--===========================--
-- OPTIONAL: Floating Icon (Draggable Show/Hide)
--===========================--
local UIS = game:GetService("UserInputService")
local PlayerGui = Player:WaitForChild("PlayerGui")

local IconGui = Instance.new("ScreenGui", PlayerGui)
IconGui.Name = "KaLiHubIcon"

local Icon = Instance.new("ImageButton")
Icon.Size = UDim2.fromOffset(50,50)
Icon.Position = UDim2.fromScale(0.95,0.05)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://6034818375" -- your icon asset
Icon.Parent = IconGui

local dragging, dragInput, dragStart, startPos

Icon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Icon.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Icon.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Icon.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

Icon.MouseButton1Click:Connect(function()
    Window:SetVisibility(not Window.Visible)
end)
