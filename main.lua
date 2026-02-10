-- Minimal Mercury test - MUST execute
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
repeat wait() until Player:FindFirstChild("PlayerGui")

-- Load Mercury
local success, Mercury = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()
end)

if not success or not Mercury then
    warn("Failed to load Mercury UI library")
    return
end

-- Create Window
local Window = Mercury:Create{
    Name = "Test Hub",
    Size = UDim2.fromOffset(400, 300),
    Theme = "Dark",
    IntroText = "Mercury Test Loaded"
}

-- Create Tab
local Tab = Window:Tab{ Name = "Main" }

-- Create Section
local Section = Tab:Section{ Name = "Features" }

-- Add Button
Section:Button{
    Name = "Test Button",
    Callback = function()
        print("Button clicked")
    end
}

-- Mercury handles drag and theme automatically
