-- Simple Executor-Safe GUI

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
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

-- Title Bar
local title = Instance.new("TextButton")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "KaLi Hub"
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.BorderSizePixel = 0
title.Parent = main

-- Minimize Button
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0, 30, 0, 30)
minimize.Position = UDim2.new(1, -30, 0, 0)
minimize.Text = "-"
minimize.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.BorderSizePixel = 0
minimize.Parent = main

-- Floating Button
local float = Instance.new("TextButton")
float.Size = UDim2.new(0, 50, 0, 50)
float.Position = UDim2.new(0, 100, 0, 100)
float.Text = "KaLi"
float.Visible = false
float.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
float.TextColor3 = Color3.new(1, 1, 1)
float.BorderSizePixel = 0
float.Parent = gui

-- Example Button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -20, 0, 40)
btn.Position = UDim2.new(0, 10, 0, 50)
btn.Text = "Test Button"
btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
btn.TextColor3 = Color3.new(1, 1, 1)
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

-- Dragging function
local function makeDraggable(frame)
    local dragging = false
    local dragInput, mousePos, framePos

    local function update(input)
        local delta = input.Position - mousePos
        frame.Position = UDim2.new(0, framePos.X + delta.X, 0, framePos.Y + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Make main window and floating button draggable
makeDraggable(title)
makeDraggable(float)
