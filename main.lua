-- Remove old GUI
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("KaLiHub") then
CoreGui.KaLiHub:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaLiHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Main Window (Mobile Friendly Size)
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 320, 0, 360)
Main.Position = UDim2.new(0.5, -160, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(30,30,35)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,40)
Header.BackgroundColor3 = Color3.fromRGB(40,40,50)
Header.BorderSizePixel = 0
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-80,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Header

-- Close Button
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,35,1,0)
Close.Position = UDim2.new(1,-35,0,0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(200,60,60)
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.Parent = Header

-- Minimize Button
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,35,1,0)
Minimize.Position = UDim2.new(1,-70,0,0)
Minimize.Text = "-"
Minimize.BackgroundColor3 = Color3.fromRGB(70,170,255)
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 14
Minimize.Parent = Header

-- Sidebar (Tabs)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,100,1,-40)
Sidebar.Position = UDim2.new(0,0,0,40)
Sidebar.BackgroundColor3 = Color3.fromRGB(35,35,45)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

-- Content Area (Sections)
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-100,1,-40)
Content.Position = UDim2.new(0,100,0,40)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- Tab System
local Tabs = {}

local function CreateTab(name)
local TabButton = Instance.new("TextButton")
TabButton.Size = UDim2.new(1,0,0,40)
TabButton.BackgroundColor3 = Color3.fromRGB(45,45,55)
TabButton.Text = name
TabButton.TextColor3 = Color3.new(1,1,1)
TabButton.Font = Enum.Font.Gotham
TabButton.TextSize = 14
TabButton.Parent = Sidebar

```
local Page = Instance.new("Frame")
Page.Size = UDim2.new(1,0,1,0)
Page.Visible = false
Page.BackgroundTransparency = 1
Page.Parent = Content

TabButton.MouseButton1Click:Connect(function()
    for _,p in pairs(Content:GetChildren()) do
        if p:IsA("Frame") then
            p.Visible = false
        end
    end
    Page.Visible = true
end)

if #Content:GetChildren() == 1 then
    Page.Visible = true
end

return Page
```

end

-- Example Tabs
local MainTab = CreateTab("Main")
local PlayerTab = CreateTab("Player")
local SettingsTab = CreateTab("Settings")

-- Floating Icon (Minimized)
local Float = Instance.new("TextButton")
Float.Size = UDim2.new(0,60,0,60)
Float.Position = UDim2.new(0,20,0.5,-30)
Float.BackgroundColor3 = Color3.fromRGB(70,170,255)
Float.Text = "K"
Float.TextColor3 = Color3.new(1,1,1)
Float.Font = Enum.Font.GothamBold
Float.TextSize = 24
Float.Visible = false
Float.Parent = ScreenGui
Instance.new("UICorner", Float).CornerRadius = UDim.new(1,0)

-- Minimize Action
Minimize.MouseButton1Click:Connect(function()
Main.Visible = false
Float.Visible = true
end)

-- Restore Action
Float.MouseButton1Click:Connect(function()
Main.Visible = true
Float.Visible = false
end)

-- Close Action
Close.MouseButton1Click:Connect(function()
ScreenGui:Destroy()
end)

-- Dragging (Mobile + PC)
local function MakeDraggable(frame)
local dragging = false
local dragInput, startPos, startFramePos

```
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        startPos = input.Position
        startFramePos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - startPos
        frame.Position = UDim2.new(
            startFramePos.X.Scale,
            startFramePos.X.Offset + delta.X,
            startFramePos.Y.Scale,
            startFramePos.Y.Offset + delta.Y
        )
    end
end)
```

end

MakeDraggable(Main)
MakeDraggable(Float)
