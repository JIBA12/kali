--// KaLiHub Full Framework (Mobile + PC Fixed)

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Remove old GUI
pcall(function()
    if CoreGui:FindFirstChild("KaLiHub") then
        CoreGui.KaLiHub:Destroy()
    end
end)

-- Safe parent
local parentGui = CoreGui
pcall(function()
    if gethui then
        parentGui = gethui()
    end
end)

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KaLiHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = parentGui or PlayerGui

-- Main Window
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,360,0,400)
Main.Position = UDim2.new(0.5,-180,0.5,-200)
Main.BackgroundColor3 = Color3.fromRGB(30,30,35)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,40)
Header.BackgroundColor3 = Color3.fromRGB(45,45,55)
Header.BorderSizePixel = 0
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-90,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "KaLiHub"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Buttons
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,40,1,0)
Minimize.Position = UDim2.new(1,-80,0,0)
Minimize.Text = "-"
Minimize.BackgroundColor3 = Color3.fromRGB(70,170,255)
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Parent = Header

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,40,1,0)
Close.Position = UDim2.new(1,-40,0,0)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(200,60,60)
Close.TextColor3 = Color3.new(1,1,1)
Close.Parent = Header

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0,110,1,-40)
Sidebar.Position = UDim2.new(0,0,0,40)
Sidebar.BackgroundColor3 = Color3.fromRGB(35,35,45)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local TabLayout = Instance.new("UIListLayout", Sidebar)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1,-110,1,-40)
Content.Position = UDim2.new(0,110,0,40)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- Floating Button
local Float = Instance.new("TextButton")
Float.Size = UDim2.new(0,60,0,60)
Float.Position = UDim2.new(0,20,0.5,-30)
Float.BackgroundColor3 = Color3.fromRGB(70,170,255)
Float.Text = "K"
Float.TextColor3 = Color3.new(1,1,1)
Float.Visible = false
Float.Parent = ScreenGui
Instance.new("UICorner", Float).CornerRadius = UDim.new(1,0)

--------------------------------------------------
-- Drag (Mobile + PC FIXED)
--------------------------------------------------
local function MakeDraggable(frame)
    local dragging = false
    local dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

MakeDraggable(Main)
MakeDraggable(Float)

-- Minimize / Close
Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false
    Float.Visible = true
end)

Float.MouseButton1Click:Connect(function()
    Main.Visible = true
    Float.Visible = false
end)

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

--------------------------------------------------
-- Framework
--------------------------------------------------
local KaLiHub = {}
local firstTab = true

function KaLiHub:CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1,0,0,40)
    TabButton.Text = name
    TabButton.BackgroundColor3 = Color3.fromRGB(45,45,55)
    TabButton.TextColor3 = Color3.new(1,1,1)
    TabButton.Parent = Sidebar

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1,0,1,0)
    Page.CanvasSize = UDim2.new()
    Page.ScrollBarThickness = 4
    Page.Visible = false
    Page.BackgroundTransparency = 1
    Page.Parent = Content

    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0,6)

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 10)
    end)

    -- First tab auto open
    if firstTab then
        firstTab = false
        Page.Visible = true
    end

    TabButton.MouseButton1Click:Connect(function()
        for _,v in pairs(Content:GetChildren()) do
            if v:IsA("ScrollingFrame") then
                v.Visible = false
            end
        end
        Page.Visible = true
    end)

    local Tab = {}

    function Tab:Section(text)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1,-10,0,25)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(120,180,255)
        Label.Font = Enum.Font.GothamBold
        Label.TextSize = 14
        Label.Parent = Page
    end

    function Tab:Button(text, callback)
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,-10,0,35)
        Btn.BackgroundColor3 = Color3.fromRGB(60,60,75)
        Btn.Text = text
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Parent = Page

        Btn.MouseButton1Click:Connect(function()
            pcall(callback)
        end)
    end

    function Tab:Toggle(text, default, callback)
        local state = default

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,-10,0,35)
        Btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
        Btn.Text = text
        Btn.TextColor3 = Color3.new(1,1,1)
        Btn.Parent = Page

        Btn.MouseButton1Click:Connect(function()
            state = not state
            Btn.BackgroundColor3 = state and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
            pcall(function()
                callback(state)
            end)
        end)
    end

    return Tab
end

--------------------------------------------------
-- Example
--------------------------------------------------
local MainTab = KaLiHub:CreateTab("Main")
MainTab:Section("Features")
MainTab:Button("Test Button", function()
    print("Clicked")
end)

MainTab:Toggle("Auto Farm", false, function(v)
    print("Toggle:", v)
end)

local PlayerTab = KaLiHub:CreateTab("Player")
PlayerTab:Section("Player Options")
PlayerTab:Button("Speed Boost", function()
    local hum = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = 50
    end
end)
