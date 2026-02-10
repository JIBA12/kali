--// Simple Executor-Safe GUI

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Remove old GUI if exists
if player.PlayerGui:FindFirstChild("KaLiHub") then
    player.PlayerGui.KaLiHub:Destroy()
end

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "KaLiHub"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- Main Window
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 200)
main.Position = UDim2.new(0.5, -150, 0.5, -100)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

-- Title Bar
local title = Instance.new("TextButton")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.Text = "KaLi Hub"
title.TextColor3 = Color3.fromRGB(0,170,255)
title.BorderSizePixel = 0
title.Parent = main

-- Minimize Button
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0,30,0,30)
minimize.Position = UDim2.new(1,-30,0,0)
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(60,60,60)
minimize.TextColor3 = Color3.new(1,1,1)
minimize.BorderSizePixel = 0
minimize.Parent = main

-- Floating Button
local float = Instance.new("TextButton")
float.Size = UDim2.new(0,50,0,50)
float.Position = UDim2.new(0,100,0,100)
float.Text = "KaLi"
float.Visible = false
float.BackgroundColor3 = Color3.fromRGB(0,170,255)
float.TextColor3 = Color3.new(1,1,1)
float.BorderSizePixel = 0
float.Parent = gui

-- Example Button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1,-20,0,40)
btn.Position = UDim2.new(0,10,0,50)
btn.Text = "Test Button"
btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
btn.TextColor3 = Color3.new(1,1,1)
btn.BorderSizePixel = 0
btn.Parent = main

btn.MouseButton1Click:Connect(function()
    print("Button works!")
end)

-- Minimize / Restore
minimize.MouseButton1Click:Connect(function()
    main.Visible = false
    float.Visible = true
end)

float.MouseButton1Click:Connect(function()
    main.Visible = true
    float.Visible = false
end)

-- Drag Function (Main)
local dragging = false
local dragOffset

title.MouseButton1Down:Connect(function()
    dragging = true
    dragOffset = Vector2.new(mouse.X - main.AbsolutePosition.X, mouse.Y - main.AbsolutePosition.Y)
end)

title.MouseButton1Up:Connect(function()
    dragging = false
end)

mouse.Move:Connect(function()
    if dragging then
        main.Position = UDim2.new(0, mouse.X - dragOffset.X, 0, mouse.Y - dragOffset.Y)
    end
end)

-- Drag Function (Floating Button)
local fdrag = false
local fOffset

float.MouseButton1Down:Connect(function()
    fdrag = true
    fOffset = Vector2.new(mouse.X - float.AbsolutePosition.X, mouse.Y - float.AbsolutePosition.Y)
end)

float.MouseButton1Up:Connect(function()
    fdrag = false
end)

mouse.Move:Connect(function()
    if fdrag then
        float.Position = UDim2.new(0, mouse.X - fOffset.X, 0, mouse.Y - fOffset.Y)
    end
end)
