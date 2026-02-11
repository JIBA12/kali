-- ============================================
-- KaLiHub V3 Main GUI (Loader Version)
-- No Key System – Loaded after validation
-- ============================================

-- Services
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove old GUI
pcall(function()
if CoreGui:FindFirstChild("KaLiHubV3") then
CoreGui.KaLiHubV3:Destroy()
end
end)

-- ============================================
-- MAIN GUI
-- ============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaLiHubV3"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui or PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,320,0,200)
Main.Position = UDim2.new(0.5,-160,0.5,-100)
Main.BackgroundColor3 = Color3.fromRGB(25,25,30)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,35)
Header.BackgroundTransparency = 1
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-70,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub V3"
Title.TextColor3 = Color3.fromRGB(200,200,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Minimize
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,30,0,25)
Minimize.Position = UDim2.new(1,-70,0,5)
Minimize.Text = "-"
Minimize.BackgroundColor3 = Color3.fromRGB(0,0,0)
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Parent = Header
Instance.new("UICorner", Minimize)

-- Close
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,30,0,25)
Close.Position = UDim2.new(1,-35,0,5)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(0,0,0)
Close.TextColor3 = Color3.new(1,1,1)
Close.Parent = Header
Instance.new("UICorner", Close)

-- Header Line
local Line = Instance.new("Frame")
Line.Size = UDim2.new(1,0,0,1)
Line.Position = UDim2.new(0,0,1,-1)
Line.BackgroundColor3 = Color3.fromRGB(80,160,255)
Line.BorderSizePixel = 0
Line.Parent = Header

-- ============================================
-- DRAG SYSTEM (Mobile + PC)
-- ============================================

local dragging = false
local dragStart, startPos

Header.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1
or input.UserInputType == Enum.UserInputType.Touch then

```
    dragging = true
    dragStart = input.Position
    startPos = Main.Position

    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
        end
    end)
end
```

end)

UIS.InputChanged:Connect(function(input)
if dragging and (
input.UserInputType == Enum.UserInputType.MouseMovement
or input.UserInputType == Enum.UserInputType.Touch) then

```
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end
```

end)

-- ============================================
-- FLOATING MINIMIZE SYSTEM
-- ============================================

local Floating

Minimize.MouseButton1Click:Connect(function()
Main.Visible = false
if Floating then return end

```
Floating = Instance.new("TextButton")
Floating.Size = UDim2.new(0,35,0,35)
Floating.Position = UDim2.new(0.5,-20,0.5,-20)
Floating.BackgroundColor3 = Color3.fromRGB(80,160,255)
Floating.Text = "K"
Floating.TextColor3 = Color3.new(1,1,1)
Floating.Font = Enum.Font.GothamBold
Floating.TextSize = 16
Floating.Parent = ScreenGui
Instance.new("UICorner", Floating)

-- Floating drag
local fDragging = false
local fStart, fPos

Floating.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        fDragging = true
        fStart = input.Position
        fPos = Floating.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                fDragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if fDragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then

        local delta = input.Position - fStart
        Floating.Position = UDim2.new(
            fPos.X.Scale,
            fPos.X.Offset + delta.X,
            fPos.Y.Scale,
            fPos.Y.Offset + delta.Y
        )
    end
end)

Floating.MouseButton1Click:Connect(function()
    Main.Visible = true
    Floating:Destroy()
    Floating = nil
end)
```

end)

-- Close
Close.MouseButton1Click:Connect(function()
ScreenGui:Destroy()
end)

-- ============================================
-- CONTENT AREA (Add your tabs/scripts here)
-- ============================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,0,1,-35)
Content.Position = UDim2.new(0,0,0,35)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- Example label (replace with your features)
local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(1,0,1,0)
Info.BackgroundTransparency = 1
Info.Text = "KaLiHub Loaded Successfully"
Info.TextColor3 = Color3.new(1,1,1)
Info.Font = Enum.Font.Gotham
Info.TextSize = 14
Info.Parent = Content
